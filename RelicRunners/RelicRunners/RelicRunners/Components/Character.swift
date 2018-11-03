//
//  Character.swift
//  RelicRunners
//
//  Created by Mario Adisurya on 3/11/18.
//  Copyright © 2018 Mario Adisurya. All rights reserved.
//

import SpriteKit

class Character: SKSpriteNode {
    
    func generateCharacter(imageNamed image: String) -> Void {
        self.texture = SKTexture(imageNamed: image);
    }
}
