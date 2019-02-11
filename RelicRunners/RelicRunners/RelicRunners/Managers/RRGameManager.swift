//
//  RRGameManager.swift
//  RelicRunners
//
//  Created by Mario Adisurya on 3/11/18.
//  Copyright © 2018 Mario Adisurya. All rights reserved.
//

import SpriteKit

public enum GameState {
    case PLAY
    case PAUSE
    case END
    case LEVEL_COMPLETE
}

class RRGameManager {
    
    static let shared = RRGameManager();
    
    private init() {}
    
    // Initialize instance of GameState
    private var gameState: GameState = .END;
    
    private var m_GlobalSceneSize = CGSize(width: 1280, height: 720);
    
    // Initialize instances of all managers
    private let m_EventManager = RREventManager();
    private let m_InputManager = RRInputManager();
    private let m_ScoreManager = RRScoreManager();
    private let m_SoundManager = RRSoundManager();
    private let m_InventoryManager = RRInventoryManager();
    private let m_GarbageCollector = RRGarbageCollector();
    
    func getGameState() -> GameState {
        return gameState;
    }
    
    func getGlobalSceneSize() -> CGSize {
        return m_GlobalSceneSize;
    }
    
    func setGameState(state: GameState) {
        gameState = state;
    }
    
    func setGlobalSceneSize(size: CGSize) {
        m_GlobalSceneSize = size;
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
    
    func getSoundManager() -> RRSoundManager {
        return m_SoundManager;
    }
    
    func getInventoryManager() -> RRInventoryManager {
        return m_InventoryManager;
    }
    
    func getGarbageCollector() -> RRGarbageCollector {
        return m_GarbageCollector;
    }
}
