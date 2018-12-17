//
//  RRGameManager.swift
//  RelicRunners
//
//  Created by Mario Adisurya on 3/11/18.
//  Copyright © 2018 Mario Adisurya. All rights reserved.
//

import Foundation

public enum GameState {
    case PLAY
    case PAUSE
    case LEVEL_COMPLETE
}

class RRGameManager {
    
    static let shared = RRGameManager();
    
    private init() {}
    
    // Initialize instance of GameState
    private var gameState: GameState = .PAUSE;
    
    // Initialize instances of all managers
    private let m_EventManager = RREventManager();
    private let m_InputManager = RRInputManager();
    private let m_ScoreManager = RRScoreManager();
    private let m_GarbageCollector = RRGarbageCollector();
    
    func getGameState() -> GameState {
        return gameState;
    }
    
    func setGameState(state: GameState) {
        gameState = state;
    }
    
    // Getter functions for Managers
    func getEventManager() -> RREventManager {
        return m_EventManager;
    }
    
    func getInputManager() -> RRInputManager {
        return m_InputManager;
    }
    
    func getScoreManager() -> RRScoreManager {
        return m_ScoreManager;
    }
    
    func getGarbageCollector() -> RRGarbageCollector {
        return m_GarbageCollector;
    }
}
