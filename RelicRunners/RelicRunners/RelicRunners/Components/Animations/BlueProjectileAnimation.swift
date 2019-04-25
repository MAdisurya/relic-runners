//
//  BlueProjectileAnimation.swift
//  RelicRunners
//
//  Created by Mario Adisurya on 25/04/19.
//  Copyright © 2019 Mario Adisurya. All rights reserved.
//

import SpriteKit

class BlueProjectilAnimation: Animation
{
    let m_BlueAtlas = SKTextureAtlas(named: "blue-projectile");
    
    override init()
    {
        super.init();
        
        // Populate m_Textures list with blue projectile sprites
        for i in 0..<m_BlueAtlas.textureNames.count
        {
            let name = m_BlueAtlas.textureNames[i];
            
            m_BlueAtlas.textureNamed(name).filteringMode = .nearest;
            m_Textures.append(m_BlueAtlas.textureNamed(name));
        }
    }
    
    func animate(speed: Double) -> SKAction
    {
        let run = SKAction.animate(with: m_Textures, timePerFrame: speed);
        
        return SKAction.repeatForever(run);
    }
}
