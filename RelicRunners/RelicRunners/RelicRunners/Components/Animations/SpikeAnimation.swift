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
    
    override init()
    {
        super.init();
        
        // Add spikes into m_Textures list
        for i in 0..<m_SpikeAtlas.textureNames.count {
            m_SpikeAtlas.textureNamed("spike-\(i)").filteringMode = .nearest;
            m_Textures.append(m_SpikeAtlas.textureNamed("spike-\(i)"));
        }
    }
    
    func open(speed: Double) -> SKAction {
        let run = SKAction.animate(with: m_Textures, timePerFrame: speed);
        
        return run;
    }
    
    func close(speed: Double) -> SKAction {
        let run = SKAction.animate(with: m_Textures.reversed(), timePerFrame: speed);
        
        return run;
    }
    
    func openClose(interval: Double) -> SKAction {
        let wait = SKAction.wait(forDuration: interval);
        let sequence = SKAction.sequence([open(speed: 0.1), wait, close(speed: 0.1), wait]);
        
        return SKAction.repeatForever(sequence);
    }
}
