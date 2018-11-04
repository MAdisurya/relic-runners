//
//  Projectile.swift
//  RelicRunners
//
//  Created by Mario Adisurya on 4/11/18.
//  Copyright © 2018 Mario Adisurya. All rights reserved.
//

import SpriteKit

class Projectile: SKSpriteNode {
    
    private let m_Speed = 10;
    
    func getSpeed() -> Int {
        return m_Speed;
    }
    
    func generateProjectile(character: Character, imageNamed image: String) -> Void {
        self.texture = SKTexture(imageNamed: image);
        self.size = CGSize(width: character.size.width / 4, height: character.size.height / 4);
    }
}
