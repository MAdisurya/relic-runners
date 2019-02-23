//
//  BigExplosionAnimation.swift
//  RelicRunners
//
//  Created by Mario Adisurya on 23/02/19.
//  Copyright © 2019 Mario Adisurya. All rights reserved.
//

import SpriteKit

class BigExplosionAnimation: Animation {
    
    let m_ExplosionAtlas = SKTextureAtlas(named: "big-explosion");
    
    func explode(speed: Double) -> SKAction {
        for textureName in m_ExplosionAtlas.textureNames {
            m_ExplosionAtlas.textureNamed(textureName).filteringMode = .nearest;
            m_Textures.append(m_ExplosionAtlas.textureNamed(textureName));
        }
        
        let run = SKAction.animate(with: m_Textures, timePerFrame: speed);
        
        return SKAction.repeatForever(run);
    }
}
