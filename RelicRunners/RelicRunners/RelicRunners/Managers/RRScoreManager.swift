//
//  RRScoreManager.swift
//  RelicRunners
//
//  Created by Mario Adisurya on 19/11/18.
//  Copyright © 2018 Mario Adisurya. All rights reserved.
//

import Foundation

class RRScoreManager {
    
    private var m_Score = 0;
    
    func getScore() -> Int {
        return m_Score;
    }
    
    func addScore(amount: Int) {
        m_Score += amount;
    }
    
    func storeScore() {
        let userDefaults = UserDefaults.standard;
        
        // Store score in user default
        userDefaults.set(m_Score, forKey: "rr-game-score");
    }
    
    func retrieveScore() -> Int {
        let userDefaults = UserDefaults.standard;
        
        return userDefaults.integer(forKey: "rr-game-score");
    }
}
