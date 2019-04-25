//
//  SpikeObstacle.swift
//  RelicRunners
//
//  Created by Mario Adisurya on 20/03/19.
//  Copyright © 2019 Mario Adisurya. All rights reserved.
//

import SpriteKit

class SpikeObstacle: Obstacle
{
    
    private var m_SpikeState: SpikeStates = .closed;
    
    private let m_SpikeAnim: SpikeAnimation = SpikeAnimation();
    
    private let _defaultWaitInterval: Double = 2;
    private var m_WaitInterval: Double = 2;
    
    // Getters
    func getSpikeState() -> SpikeStates
    {
        return m_SpikeState;
    }
    
    func getWaitInterval() -> Double
    {
        return m_WaitInterval;
    }
    
    // Setters
    func setSpikeState(state: SpikeStates)
    {
        m_SpikeState = state;
    }
    
    override func update(_ deltaTime: Double)
    {
        if (m_WaitInterval <= 0)
        {
            m_WaitInterval = _defaultWaitInterval;
        }
        
        if (m_SpikeState == .closed)
        {
            open();
        }
        else
        {
            close();
        }
        
        m_WaitInterval -= deltaTime;
    }
    
    // Handles opening of spike obstacle
    func open()
    {
        if (m_WaitInterval < _defaultWaitInterval)
        {
            return;
        }
        
        self.run(self.m_SpikeAnim.open(speed: 0.1));
        
        self.texture?.filteringMode = .nearest;
        
        self.physicsBody?.categoryBitMask = CategoryBitMask.obstacle;
        
        self.setSpikeState(state: .opened);
    }
    
    // Handles closing of spike obstacle
    func close()
    {
        if (m_WaitInterval < _defaultWaitInterval)
        {
            return;
        }
        
        self.run(self.m_SpikeAnim.close(speed: 0.1));
        
        self.texture?.filteringMode = .nearest;

        self.physicsBody?.categoryBitMask = 0;
        
        self.setSpikeState(state: .closed);
    }
}
