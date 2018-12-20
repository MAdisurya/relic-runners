//
//  Player.swift
//  RelicRunners
//
//  Created by Mario Adisurya on 1/12/18.
//  Copyright © 2018 Mario Adisurya. All rights reserved.
//

import SpriteKit

class Player: Character {
    
    // Power ups
    private var m_PowerUpType: PowerUpTypes = .none;
    
    // Getters
    func getPowerUpType() -> PowerUpTypes {
        return m_PowerUpType;
    }
    
    // Setters
    func setPowerUpType(powerUpType type: PowerUpTypes) {
        m_PowerUpType = type;
    }
    
    override init(type characterType: CharacterTypes) {
        super.init(type: characterType);
        
        m_Health = 3;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func generateCharacter(scene: GameScene, imageNamed image: String) {
        super.generateCharacter(scene: scene, imageNamed: image);
        
        self.size = CGSize(width: 400, height: 400);
        self.anchorPoint = CGPoint(x: 0.5, y: 0.3);
        self.physicsBody?.categoryBitMask = CategoryBitMask.player
        self.physicsBody?.contactTestBitMask = CategoryBitMask.enemy | CategoryBitMask.obstacle | CategoryBitMask.boss;
        
        self.xScale = 0.85;
        self.yScale = 0.85;
        
        // Sprite animations
        let atlas = SKTextureAtlas(named: "archer-run");
        var textures: [SKTexture] = [];
        
        for textureName in atlas.textureNames {
            atlas.textureNamed(textureName).filteringMode = .nearest;
            textures.append(atlas.textureNamed(textureName));
        }
        
        let run = SKAction.animate(with: textures, timePerFrame: 0.1);
        let runForever = SKAction.repeatForever(run);
        
        self.run(runForever);
    }
    
    func reset() {
        self.physicsBody?.categoryBitMask = CategoryBitMask.player;
        self.position = CGPoint(x: -gameScene.size.width, y: 0);
        self.zPosition = 2.5;
        self.m_Health = m_MaxHealth;
        self.m_CurrentLane = 0;
        self.m_PowerUpType = .none;
        self.gameScene.camera?.addChild(self);
    }
    
    override func listen(event: String) {
        super.listen(event: event);
        
        if (m_CharacterType == CharacterTypes.player && RRGameManager.shared.getGameState() == .PLAY) {
            // Set zPosition to 1 if on the top lane to make sure character is behind obstacles
            self.zPosition = (m_CurrentLane == 1) ? 1.0 : 2.5;
            // Double player speed if power up type is speedUp
            m_Speed = (m_PowerUpType == .speedUp) ? 0.25 : defaultSpeed;
            
            if (event == "swipeUp") {
                // Handle swipe up event
                if (m_CurrentLane < 1) {
                    m_CurrentLane += 1;
                    let action = SKAction.move(by: CGVector(dx: 0, dy: gameScene.getMoveAmount() * self.xScale), duration: m_Speed);
                    self.run(action);
                }
            } else if (event == "swipeDown") {
                // Handle swipe down event
                if (m_CurrentLane > -1) {
                    m_CurrentLane -= 1;
                    let action = SKAction.move(by: CGVector(dx: -0, dy: -gameScene.getMoveAmount() * self.xScale), duration: m_Speed);
                    self.run(action);
                }
            } else if (event == "tap") {
                // Handle tap event
                if (RRGameManager.shared.getGameState() == .PLAY) {
                    // Attack based on power up type
                    switch (m_PowerUpType) {
                        case .multiStrike:
                            let multiStrike = MultiStrike(character: self);
                            multiStrike.execute(spreadAmount: 192);
                            break;
                        default:
                            shootProjectile();
                            break;
                    }
                }
            } else if (event == "playerHit") {
                if (m_PowerUpType != .invinciblility && !m_Invinsible) {
                    // Shake Camera
                    gameScene.getCamera().shake(forDuration: 0.25);
                    // Subtract from healthbar
                    gameScene.getHealthBar().subtractHealth(amount: 1);
                    
                    if (m_Health > 1) {
                        m_Health -= 1;
                        
                        // Iframe
                        m_Invinsible = true;
                        let duration = SKAction.wait(forDuration: 1);
                        self.run(duration) {
                            self.m_Invinsible = false;
                        }
                    } else {
                        die();
                    }
                }
            }
        }
    }
    
    override func listen<T>(event: inout T) {
        super.listen(event: &event);
        
        // Listen to Power up broadcasts
        if let powerUp = event as? PowerUpDrop {
            m_PowerUpType = powerUp.getPowerUpType();
            
            // Handle Invincibility power-up
            if (m_PowerUpType == .invinciblility) {
                let wait = SKAction.wait(forDuration: 10);
                self.run(wait) {
                    self.m_PowerUpType = .none;
                }
            }
        }
        
        // Listen to Game State broadcasts
        if let gameState = event as? GameState {
            if (gameState == .LEVEL_COMPLETE) {
                // Actions
                let wait = SKAction.wait(forDuration: 1);
                let runOff = SKAction.move(by: CGVector(dx: gameScene.size.width, dy: 0), duration: 3);
                let sequence = SKAction.sequence([wait, runOff]);
                
                self.run(sequence) {
                    self.destroy();
                };
            }
        }
    }
}
