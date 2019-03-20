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
        for i in 0..<m_SpikeAtlas.textureNames.count {
            m_SpikeAtlas.textureNamed("spike-\(i)").filteringMode = .nearest;
            m_Textures.append(m_SpikeAtlas.textureNamed("spike-\(i)"));
        }
        
        let run = SKAction.animate(with: m_Textures, timePerFrame: speed);
        
        return run;
    }
    
    func close(speed: Double) -> SKAction {
        for i in 0..<m_SpikeAtlas.textureNames.count {
            m_SpikeAtlas.textureNamed("spike-\(i)").filteringMode = .nearest;
            m_Textures.append(m_SpikeAtlas.textureNamed("spike-\(i)"));
        }
        
        let run = SKAction.animate(with: m_Textures.reversed(), timePerFrame: speed);
        
        return run;
    }
    
    func openClose(interval: Double) -> SKAction {
        let wait = SKAction.wait(forDuration: interval);
        let sequence = SKAction.sequence([wait, open(speed: 0.1), wait, close(speed: 0.1)]);
        
        return SKAction.repeatForever(sequence);
    }
}
