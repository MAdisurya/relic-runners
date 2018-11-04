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
    
    func generateSpawner(scene: SKScene) -> Void {
        self.gameScene = scene;
    }
    
    func spawnEnemy() -> Void {
        if (self.position.x >= lastSpawnPos + 640) {
            let newEnemy = Character(type: .enemy);
            
            newEnemy.generateCharacter(scene: gameScene, imageNamed: "angry-face");
            newEnemy.position.x = self.position.x;
            gameScene.addChild(newEnemy);
            
            RRGameManager.shared.getEnemyManager().registerEnemy(enemy: newEnemy);
            
            lastSpawnPos = self.position.x;
        }
    }
}
