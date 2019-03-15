//
//  FireWispAnimation.swift
//  RelicRunners
//
//  Created by Mario Adisurya on 15/03/19.
//  Copyright © 2019 Mario Adisurya. All rights reserved.
//

import SpriteKit

class FireWispAnimation: Animation {
    
    let m_RunAtlas = SKTextureAtlas(named: "fire-move");
    
    override func run(speed: Double) -> SKAction {
        for i in 0..<m_RunAtlas.textureNames.count {
            m_RunAtlas.textureNamed("fire-move-\(i)").filteringMode = .nearest;
            m_Textures.append(m_RunAtlas.textureNamed("fire-move-\(i)"));
        }
        
        let run = SKAction.animate(with: m_Textures, timePerFrame: speed)
        
        return SKAction.repeatForever(run);
    }
}
