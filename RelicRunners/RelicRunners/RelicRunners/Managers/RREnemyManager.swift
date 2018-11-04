//
//  RREnemyManager.swift
//  RelicRunners
//
//  Created by Mario Adisurya on 5/11/18.
//  Copyright © 2018 Mario Adisurya. All rights reserved.
//

import SpriteKit

class RREnemyManager {
    
    private var enemyRegister: [Character] = [];
    
    func registerEnemy(enemy: Character) {
        if (enemy.m_CharacterType == CharacterTypes.enemy) {
            enemyRegister.append(enemy);
        }
    }
    
    func garbageCollection(scene: SKScene, camera: Camera) {
        for enemy in enemyRegister {
            if (camera.position.x > enemy.position.x + scene.size.width) {
                enemy.destroy();
            }
        }
    }
}
