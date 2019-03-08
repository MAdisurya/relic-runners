//
//  WispEnemy.swift
//  RelicRunners
//
//  Created by Mario Adisurya on 8/03/19.
//  Copyright © 2019 Mario Adisurya. All rights reserved.
//

import SpriteKit

class Wisp: Character {
    
    override init(type characterType: CharacterTypes = .enemy) {
        super.init(type: characterType);
        
        self.m_Health = 1;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func generateCharacter(scene: GameScene, imageNamed image: String) {
        super.generateCharacter(scene: scene, imageNamed: image);
        
        // Uncomment when Wisp animation implemented!
//        self.run(m_Animation.idle(speed: 0.1));
    }
}
