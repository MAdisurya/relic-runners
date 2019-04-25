//
//  ImpAnimation.swift
//  RelicRunners
//
//  Created by Mario Adisurya on 25/04/19.
//  Copyright © 2019 Mario Adisurya. All rights reserved.
//

import SpriteKit

class ImpAnimation: Animation
{
    private let m_Idle = SKTextureAtlas(named: "imp-idle");
    private let m_Attack = SKTextureAtlas(named: "imp-attack");
    
    private var m_AttackTextures: [SKTexture] = [];
    
    override init()
    {
        super.init();
        
        // Populate m_Textures with imp idle textures
        for i in 0..<m_Idle.textureNames.count
        {
            let name = m_Idle.textureNames[i];
            
            m_Idle.textureNamed(name).filteringMode = .nearest;
            m_Textures.append(m_Idle.textureNamed(name));
        }
        
        // Populate m_AttackTextures with imp attack textures
        for i in 0..<m_Attack.textureNames.count
        {
            let name = m_Attack.textureNames[i];
            
            m_Attack.textureNamed(name).filteringMode = .nearest;
            m_AttackTextures.append(m_Attack.textureNamed(name));
        }
    }
    
    override func idle(speed: Double) -> SKAction
    {
        let idle = SKAction.animate(with: m_Textures, timePerFrame: speed);
        
        return SKAction.repeatForever(idle);
    }
    
    override func attack(speed: Double) -> SKAction
    {
        return SKAction.animate(with: m_AttackTextures, timePerFrame: speed);
    }
}
