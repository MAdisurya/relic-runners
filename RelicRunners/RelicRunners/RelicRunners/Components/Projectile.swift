//
//  Projectile.swift
//  RelicRunners
//
//  Created by Mario Adisurya on 4/11/18.
//  Copyright © 2018 Mario Adisurya. All rights reserved.
//

import SpriteKit

class Projectile: SKSpriteNode, RREventListener {
    
    private let m_Speed: Double = 0.5;
    
    func getSpeed() -> Double {
        return m_Speed;
    }
    
    func generateProjectile(character: Character, imageNamed image: String) -> Void {
        self.texture = SKTexture(imageNamed: image);
        self.size = CGSize(width: character.size.width / 4, height: character.size.height / 4);
        self.zPosition = 2.0;
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 64, height: 64));
        self.physicsBody?.isDynamic = false;
        self.physicsBody?.categoryBitMask = CategoryBitMask.projectile;
        self.physicsBody?.contactTestBitMask = CategoryBitMask.enemy;
    }
    
    func destroy() {
        self.removeFromParent();
    }
    
    func listen(event: String) {
        if (event == "projectileDestroyed") {
            destroy();
        }
    }
}
