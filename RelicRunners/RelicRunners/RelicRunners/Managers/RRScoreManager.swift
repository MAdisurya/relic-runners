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
    private var m_Gold = 0;
    
    func getScore() -> Int {
        return m_Score;
    }
    
    func getGold() -> Int {
        return m_Gold;
    }
    
    func addScore(amount: Int) {
        m_Score += amount;
    }
    
    func addGold(amount: Int) {
        m_Gold += amount;
    }
    
    func subtractGold(amount: Int) {
        m_Gold -= amount;
    }
    
    func resetScore() {
        m_Score = 0;
    }
    
    func resetGold() {
        m_Gold = 0;
    }
    
    func storeScore() {
        // Only store score if current score is greater than stored score
        if (m_Score > retrieveScore()) {
            let userDefaults = UserDefaults.standard;
            
            // Store score in user default
            userDefaults.set(m_Score, forKey: "rr-game-score");
        }
    }
    
    func storeGold() {
        let userDefaults = UserDefaults.standard;
        
        // Store Gold in user default
        userDefaults.set(m_Gold, forKey: "rr-game-gold");
    }
    
    func retrieveScore() -> Int {
        let userDefaults = UserDefaults.standard;
        
        return userDefaults.integer(forKey: "rr-game-score");
    }
    
    func retrieveGold() -> Int {
        let userDefaults = UserDefaults.standard;
        
        return userDefaults.integer(forKey: "rr-game-gold");
    }
}
