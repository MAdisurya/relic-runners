//
//  PlayerAnimation.swift
//  RelicRunners
//
//  Created by Mario Adisurya on 16/02/19.
//  Copyright © 2019 Mario Adisurya. All rights reserved.
//

import SpriteKit

class PlayerAnimation: Animation {
    
    let m_RunAtlas = SKTextureAtlas(named: "archer-run-vampire");
    
    override init()
    {
        super.init();
        
        // Pre-allocate memory for the player animations
        for textureName in m_RunAtlas.textureNames
        {
            m_RunAtlas.textureNamed(textureName).filteringMode = .nearest;
            m_Textures.append(m_RunAtlas.textureNamed(textureName));
        }
    }
    
    override func run(speed: Double) -> SKAction {
        let run = SKAction.animate(with: m_Textures, timePerFrame: speed);
        
        return SKAction.repeatForever(run);
    }
    
    
}
