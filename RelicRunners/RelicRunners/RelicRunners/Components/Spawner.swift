//
//  EnemySpawner.swift
//  RelicRunners
//
//  Created by Mario Adisurya on 5/11/18.
//  Copyright © 2018 Mario Adisurya. All rights reserved.
//

import SpriteKit

class Spawner: SKNode {
    
    var gameScene: GameScene!;
    
    private var lastSpawnPos: CGFloat = 0;
    private var lastPowerUpSpawnPos: CGFloat = 0;
    private let distanceTillNextSpawn: CGFloat = 1280;
    private let distanceTillNextPowerUp: CGFloat = 800;
    private var bossSpawned = false;
    
    // Getters
    func isBossSpawned() -> Bool {
        return bossSpawned;
    }
    
    // Setters
    func setBossSpawned(spawned: Bool) {
        bossSpawned = spawned;
    }
    
    func generateSpawner(scene: GameScene) -> Void {
        self.gameScene = scene;
        self.zPosition = 1.0;
    }
    
    func spawn() -> Void {
        if (bossSpawned) {
            return;
        }
        
        // Handle spawning of enemy and obstacles
        if (self.position.x >= lastSpawnPos + distanceTillNextSpawn) {
            let newEnemy = Character(type: .enemy);
            let point = SKNode();
            let placeToSpawn = Int.random(in: -2...0);
            
            newEnemy.generateCharacter(scene: gameScene, imageNamed: "skeleton");
            newEnemy.position.x = self.position.x;
            newEnemy.position.y = (gameScene.getMoveAmount()) * CGFloat(placeToSpawn+1);
            newEnemy.zPosition = (placeToSpawn == 0) ? 1.0 : 2.5;
            gameScene.addChild(newEnemy);
            
            for i in -2...0 {
                if (i != placeToSpawn) {
                    let newObstacle = Obstacle();
                    newObstacle.generateObstacle(scene: gameScene, imageNamed: "spike");
                    newObstacle.position.x = self.position.x;
                    newObstacle.position.y = gameScene.getMoveAmount() * CGFloat(i+1);
                    newObstacle.zPosition = -CGFloat(i) + 1;
                    
                    RRGameManager.shared.getGarbageCollector().registerObstacle(obstacle: newObstacle);
                    gameScene.addChild(newObstacle);
                }
            }
            
            point.position = self.position;
            point.name = "point";
            gameScene.addChild(point);
            
            RRGameManager.shared.getGarbageCollector().registerEnemy(enemy: newEnemy);
            
            lastSpawnPos = self.position.x;
        }
        
        // Handle spawning of power ups
        if (self.position.x >= lastPowerUpSpawnPos + distanceTillNextPowerUp) {
            let random = UInt32.random(in: 0..<PowerUpTypes.none.rawValue);
            let randomPos = Int.random(in: -1...1);
            if let powerUp = PowerUpTypes(rawValue: random) {
                let newPowerUp = PowerUpDrop(powerUpType: powerUp);
                
                newPowerUp.position = CGPoint(x: self.position.x, y: gameScene.getMoveAmount() * CGFloat(randomPos));
                gameScene.addChild(newPowerUp);
                lastPowerUpSpawnPos = self.position.x;
                
                RRGameManager.shared.getGarbageCollector().registerPowerUp(powerUp: newPowerUp);
            }
        }
    }
    
    func spawnBoss(boss: Boss) {
        if (bossSpawned || boss.m_Dead) {
            return;
        }
        
        if (RRGameManager.shared.getScoreManager().getScore() > boss.m_SpawnScoreRequirement) {
            // Actions
            let fadeOut = SKAction.fadeOut(withDuration: 0.5);
            let fadeIn = SKAction.fadeIn(withDuration: 0.5);
            let sequence = SKAction.sequence([fadeIn, fadeOut]);
            let blink = SKAction.repeat(sequence, count: 3);
            let wait = SKAction.wait(forDuration: 3);
            let blinkThenWait = SKAction.sequence([blink, wait]);
            
            // Initialize boss alert UI
            let bossAlert = SKSpriteNode(imageNamed: "relicrunners-bossalert");
            bossAlert.size = CGSize(width: gameScene.size.width, height: gameScene.size.width / 2);
            bossAlert.alpha = 0;
            bossAlert.zPosition = 12;
            gameScene.camera?.addChild(bossAlert);
            
            boss.updateHeldWeapon();
            RRGameManager.shared.getEventManager().broadcastEvent(event: "resetBossWeapons");
            
            // Boss spawns in after blink animation completed
            bossAlert.run(blinkThenWait) {
                boss.position = CGPoint(x: self.gameScene.size.width, y: 0);
                self.gameScene.camera?.addChild(boss);
                self.gameScene.getCamera().stopCamera();
                
                boss.animateInFromRight() {
                    boss.resetAttackInterval();
                    boss.m_State = .ATTACKING;
                };
            }
            
            // Set boss spawned to true
            bossSpawned = true;
        }
    }
}
