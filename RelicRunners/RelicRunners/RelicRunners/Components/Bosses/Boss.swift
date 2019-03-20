//
//  Boss.swift
//  RelicRunners
//
//  Created by Mario Adisurya on 26/11/18.
//  Copyright © 2018 Mario Adisurya. All rights reserved.
//

import SpriteKit

public enum BossStates {
    case HIDING
    case ATTACKING
}

class Boss: Character {
    
    internal var m_SpawnScoreRequirement = 10;
    internal var m_DefaultScoreRequirement = 10;
    internal var m_CurrentPhase = 1;
    internal var m_AttackInterval: Double = 1;
    internal var m_State: BossStates = .HIDING;
    internal var m_WeaponHolders: [BossWeaponHolder] = [];
    internal let m_ScoreAmount = 1;
    internal let m_WeaponsAmount = 3;
    
    internal let m_DeathExplosionAnim = BigExplosionAnimation();
    
    override init(type characterType: CharacterTypes) {
        super.init(type: characterType);
        
        m_Health = 20;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func generateCharacter(scene: GameScene, imageNamed image: String, enemyName name: String) {
        super.generateCharacter(scene: scene, imageNamed: image, enemyName: name);
        
        self.size = CGSize(width: 448, height: 448);
        self.xScale = 0.85;
        self.yScale = 0.85;
        
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size);
        self.physicsBody?.isDynamic = true;
        self.physicsBody?.affectedByGravity = false;
        self.physicsBody?.categoryBitMask = CategoryBitMask.boss;
        self.physicsBody?.contactTestBitMask = CategoryBitMask.weapon | CategoryBitMask.player;
        self.physicsBody?.collisionBitMask = 0;
        
        // Populate the weapon holders array
        for _ in 0..<m_WeaponsAmount {
            let weaponHolder = BossWeaponHolder(position: CGPoint(x: -self.size.width / 2, y: 0));
            m_WeaponHolders.append(weaponHolder);
        }
        
        m_DefaultScoreRequirement = m_SpawnScoreRequirement;
    }
    
    func resetAttackInterval() {
        let attackInterval = m_AttackInterval;
        m_AttackInterval = 0;
        
        let wait = SKAction.wait(forDuration: attackInterval);
        
        self.run(wait) {
            self.m_AttackInterval = attackInterval;
        }
    }
    
    func attack() {
        if (m_State != .ATTACKING || m_AttackInterval <= 0 || m_Dead) {
            return;
        }
        
        switch (m_CurrentPhase) {
        case 1:
            attackPhaseOne();
            break;
        case 2:
            attackPhaseTwo();
            break;
        case 3:
            attackPhaseThree();
            break;
        default:
            break;
        }
        
        resetAttackInterval();
    }
    
    func attackPhaseOne() {
        
    }
    
    func attackPhaseTwo() {
        
    }
    
    func attackPhaseThree() {
        
    }
    
    func updateHeldWeapon() {
        self.removeAllChildren();
        
        if (m_CurrentPhase > 0 && m_WeaponHolders.count > 0) {
            self.addChild(m_WeaponHolders[m_CurrentPhase - 1]);
        }
    }
    
    func resetPhase() {
        m_CurrentPhase = 1;
    }
    
    override func die(completion: @escaping () -> Void) {
        if (m_Dead) {
            return;
        }
        
        m_Dead = true;
        self.physicsBody?.categoryBitMask = 0;
        
        // Explosion
        let explosion = SKSpriteNode(imageNamed: "explosionV006effect001");
        explosion.size = self.size;
        explosion.zPosition = 12;
        self.addChild(explosion);
        
        // White flash screen
        let whiteFlash = SKSpriteNode();
        whiteFlash.size = gameScene.size;
        whiteFlash.zPosition = 12;
        whiteFlash.color = UIColor.white;
        whiteFlash.alpha = 0;
        gameScene.camera?.addChild(whiteFlash);
        
        // Treasure box placeholder (remove later)
        let treasureBox = SKSpriteNode(imageNamed: "chest-pixel");
        treasureBox.size = CGSize(width: 128, height: 128);
        treasureBox.position = CGPoint(x: gameScene.size.width / 4, y: 0);
        treasureBox.zPosition = 1;
        
        // Actions
        let fadeIn = SKAction.fadeIn(withDuration: 0.2);
        let fadeOut = SKAction.fadeOut(withDuration: 2);
        let wait = SKAction.wait(forDuration: 3);
        
        explosion.run(m_DeathExplosionAnim.explode(speed: 0.2));
        
        whiteFlash.run(SKAction.sequence([wait, fadeIn])) {
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
                    // Boss will hide
                    // Reset Health, increase score requirement, increase phase
                    m_Health = m_MaxHealth;
                    m_CurrentPhase += 1;
                    m_SpawnScoreRequirement = m_DefaultScoreRequirement * m_CurrentPhase;
                    
                    // Animate boss away and remove from scene
                    animateOutRight() {
                        self.destroy();
                        self.gameScene.getSpawner().setBossSpawned(spawned: false);
                        self.m_State = .HIDING;
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
