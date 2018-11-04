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
    private var distanceTillNextSpawn: CGFloat = 960;
    
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
            
            RRGameManager.shared.getEnemyManager().registerEnemy(enemy: newEnemy);
            
            lastSpawnPos = self.position.x;
        }
    }
}
