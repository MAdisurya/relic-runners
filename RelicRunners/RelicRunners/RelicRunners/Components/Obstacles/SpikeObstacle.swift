//
//  SpikeObstacle.swift
//  RelicRunners
//
//  Created by Mario Adisurya on 20/03/19.
//  Copyright © 2019 Mario Adisurya. All rights reserved.
//

import SpriteKit

class SpikeObstacle: Obstacle {
    
    private var m_SpikeState: SpikeStates = .closed;
    
    private let m_SpikeAnim: SpikeAnimation = SpikeAnimation();
    
    private var m_WaitInterval: Double = 2;
    
    // Getters
    func getSpikeState() -> SpikeStates {
        return m_SpikeState;
    }
    
    func getWaitInterval() -> Double {
        return m_WaitInterval;
    }
    
    // Setters
    func setSpikeState(state: SpikeStates) {
        m_SpikeState = state;
    }
    
    private func resetWaitInterval() {
        let waitInterval = m_WaitInterval;
        m_WaitInterval = (m_WaitInterval <= 0) ? m_WaitInterval : 0;
        
        self.run(SKAction.wait(forDuration: waitInterval)) {
            self.m_WaitInterval = waitInterval;
        }
    }
    
    // Handles opening of spike obstacle
    func open() {
        if (m_SpikeState != .closed || m_WaitInterval <= 0) {
            return;
        }
        
//        self.run(self.m_SpikeAnim.open(speed: 0.1));
        
        self.texture?.filteringMode = .nearest;
        self.texture = SKTexture(imageNamed: "spike-3");
        
        self.physicsBody?.categoryBitMask = CategoryBitMask.obstacle;
        
        self.setSpikeState(state: .opened);
        resetWaitInterval();
    }
    
    // Handles closing of spike obstacle
    func close() {
        if (m_SpikeState != .opened || m_WaitInterval <= 0) {
            return;
        }
        
//        self.run(self.m_SpikeAnim.close(speed: 0.1));
        
        self.texture?.filteringMode = .nearest;
        self.texture = SKTexture(imageNamed: "spike-0");
        
        self.physicsBody?.categoryBitMask = 0;
        
        self.setSpikeState(state: .closed);
        resetWaitInterval();
    }
}
