//
//  RRGameManager.swift
//  RelicRunners
//
//  Created by Mario Adisurya on 3/11/18.
//  Copyright © 2018 Mario Adisurya. All rights reserved.
//

import Foundation

class RRGameManager {
    
    static let shared = RRGameManager();
    
    private init() {}
    
    // Initialize instances of all managers
    let m_EventManager = RREventManager();
    let m_InputManager = RRInputManager();
    
    // Getter functions for Managers
    func getEventManager() -> RREventManager {
        return m_EventManager;
    }
    
    func getInputManager() -> RRInputManager {
        return m_InputManager;
    }
}
