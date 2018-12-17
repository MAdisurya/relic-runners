//
//  Boss.swift
//  RelicRunners
//
//  Created by Mario Adisurya on 26/11/18.
//  Copyright © 2018 Mario Adisurya. All rights reserved.
//

import SpriteKit

class Boss: Character {
    
    internal var m_SpawnScoreRequirement = 10;
    internal var m_DefaultScoreRequirement = 10;
    internal var m_CurrentPhase = 1;
    internal let m_ScoreAmount = 1;
    
    override init(type characterType: CharacterTypes) {
        super.init(type: characterType);
        
        m_Health = 20;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func generateCharacter(scene: GameScene, imageNamed image: String) {
        super.generateCharacter(scene: scene, imageNamed: image);
        
        self.size = CGSize(width: 448, height: 448);
        self.xScale = 0.85;
        self.yScale = 0.85;
        
        self.physicsBody?.categoryBitMask = CategoryBitMask.boss;
        self.physicsBody?.contactTestBitMask = CategoryBitMask.weapon | CategoryBitMask.player;
        
        m_DefaultScoreRequirement = m_SpawnScoreRequirement;
    }
    
    override func die(completion: @escaping () -> Void) {
        if (m_Dead) {
            return;
        }
        
        m_Dead = true;
        self.physicsBody?.categoryBitMask = 0;
        
        // White flash screen
        let whiteFlash = SKSpriteNode();
        whiteFlash.size = gameScene.size;
        whiteFlash.zPosition = 12;
        whiteFlash.color = UIColor.white;
        whiteFlash.alpha = 0;
        gameScene.camera?.addChild(whiteFlash);
        
        // Treasure box placeholder (remove later)
        let treasureBox = SKSpriteNode();
        treasureBox.size = CGSize(width: 128, height: 128);
        treasureBox.position = CGPoint(x: gameScene.size.width / 4, y: 0);
        treasureBox.zPosition = 1;
        treasureBox.color = UIColor.blue;
        
        // Actions
        let fadeIn = SKAction.fadeIn(withDuration: 0.2);
        let fadeOut = SKAction.fadeOut(withDuration: 2);
        
        whiteFlash.run(fadeIn) {
            self.destroy();
            self.gameScene.camera?.addChild(treasureBox);
            // Set game state to level complete
            RRGameManager.shared.setGameState(state: .LEVEL_COMPLETE);

            whiteFlash.run(fadeOut) {
                whiteFlash.removeFromParent();
                completion();
                
                var gameState = RRGameManager.shared.getGameState();
                RRGameManager.shared.getEventManager().broadcastEvent(event: &gameState);
            }
        }
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
                    }
                }
            }
        }
    }
}
