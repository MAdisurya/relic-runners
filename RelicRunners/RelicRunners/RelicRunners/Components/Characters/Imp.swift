//
//  Imp.swift
//  RelicRunners
//
//  Created by Mario Adisurya on 15/03/19.
//  Copyright © 2019 Mario Adisurya. All rights reserved.
//

import SpriteKit

class Imp: Character {
    
    let m_Projectile = Weapon(imageName: "imp-projectile-0", speed: 2, distance: -1180)
    
    let m_Cooldown: Double = 1.0;
    
    override init(type characterType: CharacterTypes = .enemy) {
        super.init(type: characterType);
        
        self.m_Health = 1;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func generateCharacter(scene: GameScene, imageNamed image: String) {
        super.generateCharacter(scene: scene, imageNamed: image);
    }
}
