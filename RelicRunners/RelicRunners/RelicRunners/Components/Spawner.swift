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
    
    private var nameIndex: Int = 0;
    
    private var m_SpikeManager: [SpikeObstacle] = [];
    
    // Enemy Animations
    private let m_GhoulAnim: Animation = GhoulAnimation();
    
    // Boss Animations
    private let m_GolemAnim: Animation = GolemAnimation();
    
    // Obstacle Animations
    private let m_SpikeAnim: SpikeAnimation = SpikeAnimation();
    
    // Getters
    func isBossSpawned() -> Bool {
        return bossSpawned;
    }
    
    func getSpikeManager() -> [SpikeObstacle] {
        return m_SpikeManager;
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
            let point = SKNode();
            
            let enemySpawnPos = spawnEnemies();
            spawnObstacles(enemySpawnPos: enemySpawnPos);
            
            point.position = self.position;
            point.name = "point";
            gameScene.addChild(point);
            
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
    
    func spawnEnemy(enemy: Character, image: String, name: String, placeToSpawn: Int) -> Character {
        enemy.generateCharacter(scene: gameScene, imageNamed: image, enemyName: name);
        enemy.position.x = self.position.x;
        enemy.position.y = gameScene.getMoveAmount() * CGFloat(placeToSpawn + 1);
        enemy.zPosition = (placeToSpawn == 0) ? 1.0 : 2.5;
        
        return enemy;
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
            
            boss.run(m_GolemAnim.idle(speed: 0.2));
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
    
    // Helper method for spawning enemies
    func spawnEnemies() -> [Int] {
        var ghoulSpawnPos = Int.random(in: -2...0);
        var fireWispSpawnPos = Int.random(in: -2...0);
        var impSpawnPos = Int.random(in: -2...0);
        
        // Enemy definitions
        let ghoulEnemy = spawnEnemy(enemy: Character(type: .enemy), image: "ghoul-idle-1", name: "ghoul\(nameIndex)", placeToSpawn: ghoulSpawnPos);
        let fireWisp = spawnEnemy(enemy: Wisp(), image: "fire-move-0", name: "fireWisp\(nameIndex)", placeToSpawn: fireWispSpawnPos) as! Wisp;
        let imp = spawnEnemy(enemy: Imp(), image: "imp-attack-0", name: "imp\(nameIndex)", placeToSpawn: impSpawnPos) as! Imp;
        
        ghoulEnemy.run(m_GhoulAnim.idle(speed: 0.1));
        ghoulEnemy.size = CGSize(width: 201, height: 80);
        
        fireWisp.run(SKAction.move(by: CGVector(dx: -gameScene.size.width, dy: 0), duration: 5));
        
        imp.shootProjectile(projectile: imp.m_Projectile, cooldown: imp.m_Cooldown);
        
        if (ghoulEnemy.shouldSpawn(percentage: 100)) {
            gameScene.addChild(ghoulEnemy);
        } else {
            ghoulSpawnPos = 1;
        }
        
        if (fireWisp.shouldSpawn(percentage: 50)) {
            gameScene.addChild(fireWisp);
        } else {
            fireWispSpawnPos = 1;
        }
        
        if (imp.shouldSpawn(percentage: 30)) {
            gameScene.addChild(imp);
        } else {
            impSpawnPos = 1;
        }
        
        RRGameManager.shared.getGarbageCollector().registerEnemy(enemy: ghoulEnemy);
        RRGameManager.shared.getGarbageCollector().registerEnemy(enemy: fireWisp);
        RRGameManager.shared.getGarbageCollector().registerEnemy(enemy: imp);
        
        nameIndex += 1;
        
        let spawnPos: [Int] = [ghoulSpawnPos, impSpawnPos, 0];
        
        // Returns enemy spawn positions
        return sortEnemySpawnPositions(posArray: spawnPos, from: -2, to: 0);
    }
    
    // Helper method for spawning obstacles
    func spawnObstacles(enemySpawnPos: [Int]) {
        print(enemySpawnPos);
        
        for i in -2...0 {
            if (i != enemySpawnPos[i + 2]) {
                let spike = SpikeObstacle();
                
                spike.generateObstacle(scene: gameScene, imageNamed: "spike-0");
                spike.physicsBody?.categoryBitMask = 0;
                
                spike.position.x = self.position.x;
                spike.position.y = gameScene.getMoveAmount() * CGFloat(i + 1);
                spike.zPosition = -CGFloat(i) + 1;
                
                RRGameManager.shared.getGarbageCollector().registerObstacle(obstacle: spike);
                
                // Spike manager is used in update call to
                // open and close all spikes in the scene
                m_SpikeManager.append(spike);
                
                gameScene.addChild(spike);
            }
        }
    }
    
    // Helper method for sorting enemy spawn positions for obstacles
    func sortEnemySpawnPositions(posArray: [Int], from: Int, to: Int) -> [Int] {
        var sorted: [Int] = posArray.sorted();
        var index = 0;
        
        for i in from...to {
            if (i == to) {
                if (sorted[index] < to) {
                    sorted[index] = to + 1;
                }
            } else if (sorted[index] != i) {
                sorted[index + 1] = sorted[index];
                sorted[index] = to + 1;
            }
            
            index += 1;
        }
        
        return sorted;
    }
}
