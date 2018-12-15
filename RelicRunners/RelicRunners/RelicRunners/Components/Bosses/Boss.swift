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
    internal let m_SpawnScoreRequirement = 1;
    
    override func generateCharacter(scene: GameScene, imageNamed image: String) {
        super.generateCharacter(scene: scene, imageNamed: image);
        
        self.size = CGSize(width: 512, height: 512);
        self.xScale = 0.85;
        self.yScale = 0.85;
        
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
                    // Move camera
                    self.gameScene.getCamera().setCameraSpeed(speed: self.gameScene.getCamera().getHeldMoveSpeed());
                }
            }
        }
    }
}
