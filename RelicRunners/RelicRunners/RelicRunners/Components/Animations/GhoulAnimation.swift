//
//  GhoulAnimation.swift
//  RelicRunners
//
//  Created by Mario Adisurya on 23/02/19.
//  Copyright © 2019 Mario Adisurya. All rights reserved.
//

import SpriteKit

class GhoulAnimation: Animation {
    
    let m_IdleAtlas = SKTextureAtlas(named: "ghoul-idle");
    
    override func idle(speed: Double) -> SKAction {
        for textureName in m_IdleAtlas.textureNames {
            m_IdleAtlas.textureNamed(textureName).filteringMode = .nearest;
            m_Textures.append(m_IdleAtlas.textureNamed(textureName));
        }
        
        let run = SKAction.animate(with: m_Textures, timePerFrame: speed);
        
        return SKAction.repeatForever(run);
    }
}
