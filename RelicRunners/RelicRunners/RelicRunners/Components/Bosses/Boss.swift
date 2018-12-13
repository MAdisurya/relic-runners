//
//  Boss.swift
//  RelicRunners
//
//  Created by Mario Adisurya on 26/11/18.
//  Copyright © 2018 Mario Adisurya. All rights reserved.
//

import SpriteKit

class Boss: Character {
    
    internal var m_Health = 20;
    internal let m_ScoreAmount = 1;
    internal let m_SpawnScoreRequirement = 10;
    
    override func generateCharacter(scene: GameScene, imageNamed image: String) {
        super.generateCharacter(scene: scene, imageNamed: image);
        
        self.size = CGSize(width: 256, height: 256);
        self.xScale = 0.75;
        self.yScale = 0.75;
        
        self.physicsBody?.categoryBitMask = CategoryBitMask.boss;
        self.physicsBody?.contactTestBitMask = CategoryBitMask.weapon | CategoryBitMask.player;
    }
    
    override func listen(event: String) {
        if (event == "bossHit") {
            if (m_Health > 1) {
                // Subtract health
                m_Health -= 1;
            } else {
                die() {
                    // Add to game score
                    RRGameManager.shared.getScoreManager().addScore(amount: self.m_ScoreAmount);
                    // Update score label
//                    self.gameScene.updateScoreLabel(score: String(RRGameManager.shared.getScoreManager().getScore()));
                    // Update bossSpawned
                    self.gameScene.getSpawner().setBossSpawned(spawned: false);
                }
            }
        }
    }
}
