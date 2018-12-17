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
    internal var m_MaxHealth = 20;
    internal var m_SpawnScoreRequirement = 10;
    internal var m_DefaultScoreRequirement = 10;
    internal var m_CurrentPhase = 1;
    internal let m_ScoreAmount = 1;
    
    override func generateCharacter(scene: GameScene, imageNamed image: String) {
        super.generateCharacter(scene: scene, imageNamed: image);
        
        self.size = CGSize(width: 448, height: 448);
        self.xScale = 0.85;
        self.yScale = 0.85;
        
        self.physicsBody?.categoryBitMask = CategoryBitMask.boss;
        self.physicsBody?.contactTestBitMask = CategoryBitMask.weapon | CategoryBitMask.player;
        
        m_MaxHealth = m_Health;
        m_DefaultScoreRequirement = m_SpawnScoreRequirement;
    }
    
    override func listen(event: String) {
        if (event == "bossHit") {
            if (m_Health > 1) {
                // Subtract health
                m_Health -= 1;
            } else {
                if (m_CurrentPhase < 3) {
                    // Boss will run away
                    // Reset Health, increase score requirement, increase phase
                    m_Health = m_MaxHealth;
                    m_CurrentPhase += 1;
                    m_SpawnScoreRequirement = m_DefaultScoreRequirement * m_CurrentPhase;
                    
                    // Animate boss away and remove from scene
                    animateOutRight() {
                        self.destroy();
                        self.gameScene.getSpawner().setBossSpawned(spawned: false);
                        // Move camera
                        self.gameScene.getCamera().setCameraSpeed(speed: self.gameScene.getCamera().getHeldMoveSpeed());
                    }
                } else {
                    die() {
                        // Add to game score
                        RRGameManager.shared.getScoreManager().addScore(amount: self.m_ScoreAmount);
                        // Update score label
    //                    self.gameScene.updateScoreLabel(score: String(RRGameManager.shared.getScoreManager().getScore()));
                        // Update bossSpawned
                        self.gameScene.getSpawner().setBossSpawned(spawned: false);
                        // Move camera
                        self.gameScene.getCamera().setCameraSpeed(speed: self.gameScene.getCamera().getHeldMoveSpeed());
                    }
                }
            }
        }
    }
}
