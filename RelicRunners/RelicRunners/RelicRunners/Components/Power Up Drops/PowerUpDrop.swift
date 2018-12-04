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
        super.init(texture: SKTexture(), color: UIColor(), size: CGSize(width: 64, height: 64));
        
        self.zPosition = 1;
        
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
    
    func destroy() {
        self.removeFromParent();
    }
}
