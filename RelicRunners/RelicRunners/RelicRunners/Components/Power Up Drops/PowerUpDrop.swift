//
//  PowerUpDrop.swift
//  RelicRunners
//
//  Created by Mario Adisurya on 4/12/18.
//  Copyright © 2018 Mario Adisurya. All rights reserved.
//

import SpriteKit

class PowerUpDrop: SKSpriteNode {
    
    internal var m_PowerUpType: PowerUpTypes = .none;
    
    init(powerUpType type: PowerUpTypes) {
        super.init(texture: SKTexture(), color: UIColor(), size: CGSize(width: 72, height: 72));
        
        self.zPosition = 0.8;
        // Set anchor point to top of power up drop
        self.anchorPoint = CGPoint(x: 0.5, y: 1);
        
        // Set up physics body for triggers
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size);
        self.physicsBody?.isDynamic = true;
        self.physicsBody?.affectedByGravity = false;
        self.physicsBody?.collisionBitMask = 0;
        self.physicsBody?.categoryBitMask = CategoryBitMask.powerUp;
        self.physicsBody?.contactTestBitMask = CategoryBitMask.player;
        
        self.m_PowerUpType = type;
        
        // Set texture based on power up type
        switch (m_PowerUpType) {
        case .multiStrike:
            self.texture = SKTexture(imageNamed: "multistrike-powerup");
            break;
        case .speedUp:
            self.texture = SKTexture(imageNamed: "speedup-powerup");
            break;
        case .damageBoost:
            self.texture = SKTexture(imageNamed: "damageboost-powerup");
            break;
        case .invinciblility:
            self.texture = SKTexture(imageNamed: "invincibility-powerup");
            break;
        default:
            break;
        }
        
        self.texture?.filteringMode = .nearest;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Getters
    func getPowerUpType() -> PowerUpTypes {
        return m_PowerUpType;
    }
    
    func destroy() {
        self.removeFromParent();
    }
}
