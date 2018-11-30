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
    private var distanceTillNextSpawn: CGFloat = 1280;
    private var bossSpawned = false;
    
    func generateSpawner(scene: GameScene) -> Void {
        self.gameScene = scene;
        self.zPosition = 1.0;
    }
    
    func spawn() -> Void {
        if (bossSpawned) {
            return;
        }
        
        if (self.position.x >= lastSpawnPos + distanceTillNextSpawn) {
            let newEnemy = Character(type: .enemy);
            let point = SKNode();
            let placeToSpawn = Int.random(in: -2...0);
            
            newEnemy.generateCharacter(scene: gameScene, imageNamed: "skeleton");
            newEnemy.position.x = self.position.x;
            newEnemy.position.y = (newEnemy.m_MoveAmount) * CGFloat(placeToSpawn+1);
            newEnemy.zPosition = (placeToSpawn == 0) ? 1.0 : 2.5;
            gameScene.addChild(newEnemy);
            
            for i in -2...0 {
                if (i != placeToSpawn) {
                    let newObstacle = Obstacle();
                    newObstacle.generateObstacle(scene: gameScene, imageNamed: "spike");
                    newObstacle.position.x = self.position.x;
                    newObstacle.position.y = newEnemy.m_MoveAmount * CGFloat(i+1);
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
    }
    
    func spawnBoss(boss: Boss) {
        if (bossSpawned) {
            return;
        }
        
        if (RRGameManager.shared.getScoreManager().getScore() > boss.m_SpawnScoreRequirement) {
            // Actions
            let fadeOut = SKAction.fadeOut(withDuration: 1);
            let fadeIn = SKAction.fadeIn(withDuration: 1);
            let sequence = SKAction.sequence([fadeIn, fadeOut]);
            let blink = SKAction.repeat(sequence, count: 3);
            
            // Initialize boss alert UI
            let bossAlert = SKSpriteNode(imageNamed: "relicrunners-bossalert");
            bossAlert.size = CGSize(width: gameScene.size.width, height: gameScene.size.width / 2);
            bossAlert.alpha = 0;
            bossAlert.zPosition = 8;
            gameScene.camera?.addChild(bossAlert);
            
            // Boss spawns in after blink animation completed
            bossAlert.run(blink) {
                boss.position = CGPoint(x: self.gameScene.size.width, y: 0);
                self.gameScene.camera?.addChild(boss);
                boss.animateInFromRight();
            }
            
            // Set boss spawned to true
            bossSpawned = true;
        }
    }
}
