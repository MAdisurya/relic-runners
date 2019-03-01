//
//  SpikeAnimation.swift
//  RelicRunners
//
//  Created by Mario Adisurya on 2/03/19.
//  Copyright © 2019 Mario Adisurya. All rights reserved.
//

import SpriteKit

class SpikeAnimation: Animation {
    
    let m_SpikeAtlas = SKTextureAtlas(named: "spikes");
    
    func open(speed: Double) -> SKAction {
        for textureName in m_SpikeAtlas.textureNames {
            m_SpikeAtlas.textureNamed(textureName).filteringMode = .nearest;
            m_Textures.append(m_SpikeAtlas.textureNamed(textureName));
        }
        
        let run = SKAction.animate(with: m_Textures, timePerFrame: speed);
        
        return run;
    }
    
    func close(speed: Double) -> SKAction {
        for textureName in m_SpikeAtlas.textureNames {
            m_SpikeAtlas.textureNamed(textureName).filteringMode = .nearest;
            m_Textures.append(m_SpikeAtlas.textureNamed(textureName));
        }
        
        let run = SKAction.animate(with: m_Textures.reversed(), timePerFrame: speed);
        
        return run;
    }
}
