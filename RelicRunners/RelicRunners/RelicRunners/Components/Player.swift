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
    
    private var m_PowerUpType: PowerUpTypes = .multiStrike;
    
    override func generateCharacter(scene: GameScene, imageNamed image: String) {
        super.generateCharacter(scene: scene, imageNamed: image);
    }
    
    override func listen(event: String) {
        super.listen(event: event);
        
        if (m_CharacterType == CharacterTypes.player) {
            // Set zPosition to 1 if on the top lane to make sure character is behind obstacles
            self.zPosition = (m_CurrentLane == 1) ? 1.0 : 2.5;
            
            if (event == "swipeUp") {
                // Handle swipe up event
                if (m_CurrentLane < 1) {
                    m_CurrentLane += 1;
                    let action = SKAction.move(by: CGVector(dx: 0, dy: m_MoveAmount), duration: 0.5);
                    self.run(action);
                }
            } else if (event == "swipeDown") {
                // Handle swipe down event
                if (m_CurrentLane > -1) {
                    m_CurrentLane -= 1;
                    let action = SKAction.move(by: CGVector(dx: -0, dy: -m_MoveAmount), duration: 0.5);
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
                die();
            }
        }
    }
}
