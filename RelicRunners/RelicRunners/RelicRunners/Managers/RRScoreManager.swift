//
//  RRScoreManager.swift
//  RelicRunners
//
//  Created by Mario Adisurya on 19/11/18.
//  Copyright © 2018 Mario Adisurya. All rights reserved.
//

import SpriteKit

class RRScoreManager {
    
    private var m_Score = 0;
    
    func getScore() -> Int {
        return m_Score;
    }
    
    func addScore(amount: Int) {
        m_Score += amount;
    }
    
    func resetScore() {
        m_Score = 0;
    }
    
    func storeScore() {
        // Only store score if current score is greater than stored score
        if (m_Score > retrieveScore()) {
            let userDefaults = UserDefaults.standard;
            
            // Store score in user default
            userDefaults.set(m_Score, forKey: "rr-game-score");
        }
    }
    
    func retrieveScore() -> Int {
        let userDefaults = UserDefaults.standard;
        
        return userDefaults.integer(forKey: "rr-game-score");
    }
}
