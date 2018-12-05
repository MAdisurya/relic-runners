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
    private lazy var m_MultiStrike = MultiStrike(character: self);
    
    // Weapons
//    private let arrow = Projectile();
    
    private var m_PowerUpType: PowerUpTypes = .none;
    
    // Getters
    func getPowerUpType() -> PowerUpTypes {
        return m_PowerUpType;
    }
    
    // Setters
    func setPowerUpType(powerUpType type: PowerUpTypes) {
        m_PowerUpType = type;
    }
    
    override func generateCharacter(scene: GameScene, imageNamed image: String) {
        super.generateCharacter(scene: scene, imageNamed: image);
    }
    
    override func listen(event: String) {
        super.listen(event: event);
        
        if (m_CharacterType == CharacterTypes.player) {
            // Set zPosition to 1 if on the top lane to make sure character is behind obstacles
            self.zPosition = (m_CurrentLane == 1) ? 1.0 : 2.5;
            // Double player speed if power up type is speedUp
            m_Speed = (m_PowerUpType == .speedUp) ? 0.25 : defaultSpeed;
            
            if (event == "swipeUp") {
                // Handle swipe up event
                if (m_CurrentLane < 1) {
                    m_CurrentLane += 1;
                    let action = SKAction.move(by: CGVector(dx: 0, dy: m_MoveAmount), duration: m_Speed);
                    self.run(action);
                }
            } else if (event == "swipeDown") {
                // Handle swipe down event
                if (m_CurrentLane > -1) {
                    m_CurrentLane -= 1;
                    let action = SKAction.move(by: CGVector(dx: -0, dy: -m_MoveAmount), duration: m_Speed);
                    self.run(action);
                }
            } else if (event == "tap") {
                // Handle tap event
                if (RRGameManager.shared.getGameState() == .PLAY) {
                    // Attack based on power up type
                    switch (m_PowerUpType) {
                        case .multiStrike:
                            m_MultiStrike.execute(spreadAmount: self.size.width * 1.5);
                            break;
                        default:
                            shootProjectile();
                            break;
                    }
                }
            } else if (event == "playerHit") {
                if (m_PowerUpType != .invinciblility) {
                    die();
                }
            }
        }
    }
    
    override func listen<T>(event: inout T) {
        super.listen(event: &event);
        
        // Listen to Power up broadcasts
        if let powerUp = event as? PowerUpDrop {
            m_PowerUpType = powerUp.getPowerUpType();
        }
    }
}
