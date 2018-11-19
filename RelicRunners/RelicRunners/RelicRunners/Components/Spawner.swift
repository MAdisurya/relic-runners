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
    
    func generateSpawner(scene: GameScene) -> Void {
        self.gameScene = scene;
        self.zPosition = 1.0;
    }
    
    func spawn() -> Void {
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
}
