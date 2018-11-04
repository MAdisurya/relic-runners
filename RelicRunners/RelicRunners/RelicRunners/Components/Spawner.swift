//
//  EnemySpawner.swift
//  RelicRunners
//
//  Created by Mario Adisurya on 5/11/18.
//  Copyright © 2018 Mario Adisurya. All rights reserved.
//

import SpriteKit

class Spawner: SKNode {
    
    var gameScene: SKScene!;
    
    private var lastSpawnPos: CGFloat = 0;
    private var distanceTillNextSpawn: CGFloat = 1280;
    
    func generateSpawner(scene: SKScene) -> Void {
        self.gameScene = scene;
    }
    
    func spawnEnemy() -> Void {
        if (self.position.x >= lastSpawnPos + distanceTillNextSpawn) {
            let newEnemy = Character(type: .enemy);
            let placeToSpawn = Int.random(in: -1...1);
            
            newEnemy.generateCharacter(scene: gameScene, imageNamed: "angry-face");
            newEnemy.position.x = self.position.x;
            newEnemy.position.y = newEnemy.size.height * CGFloat(placeToSpawn);
            gameScene.addChild(newEnemy);
            
            for i in -1...1 {
                if (i != placeToSpawn) {
                    let newObstacle = Obstacle();
                    newObstacle.generateObstacle(scene: gameScene, imageNamed: "sad-face");
                    newObstacle.position.x = self.position.x;
                    newObstacle.position.y = newObstacle.size.height * CGFloat(i);
                    
                    RRGameManager.shared.getEnemyManager().registerObstacle(obstacle: newObstacle);
                    gameScene.addChild(newObstacle);
                }
            }
            
            RRGameManager.shared.getEnemyManager().registerEnemy(enemy: newEnemy);
            
            lastSpawnPos = self.position.x;
        }
    }
}
