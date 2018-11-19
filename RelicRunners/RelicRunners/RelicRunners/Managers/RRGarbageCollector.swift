//
//  RREnemyManager.swift
//  RelicRunners
//
//  Created by Mario Adisurya on 5/11/18.
//  Copyright © 2018 Mario Adisurya. All rights reserved.
//

import SpriteKit

class RRGarbageCollector {
    
    private var enemyRegister: [Character] = [];
    private var obstacleRegister: [Obstacle] = [];
    
    func registerEnemy(enemy: Character) {
        if (enemy.m_CharacterType == CharacterTypes.enemy) {
            enemyRegister.append(enemy);
        }
    }
    
    func registerObstacle(obstacle: Obstacle) {
        obstacleRegister.append(obstacle);
    }
    
    func garbageCollection(scene: SKScene, camera: Camera) {
        for enemy in enemyRegister {
            if (camera.position.x > enemy.position.x + scene.size.height) {
                enemy.destroy();
            }
        }
        
        for obstacle in obstacleRegister {
            if (camera.position.x > obstacle.position.x + scene.size.height) {
                obstacle.destroy();
            }
        }
    }
}
