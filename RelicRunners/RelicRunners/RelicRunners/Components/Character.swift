//
//  Character.swift
//  RelicRunners
//
//  Created by Mario Adisurya on 3/11/18.
//  Copyright © 2018 Mario Adisurya. All rights reserved.
//

import SpriteKit

class Character: SKSpriteNode, RREventListener {
    
    var m_CharacterType: CharacterTypes!;
    var gameScene: GameScene!;
    
    var m_CurrentLane = 0;
    var m_Dead = false;
    var m_MoveAmount: CGFloat!;
    
    internal var m_Speed: Double = 0.5;
    internal let m_GoldAmount: Int = Int.random(in: 1...5);
    
    // Default values
    internal var defaultSpeed: Double!;
    
    init(type characterType: CharacterTypes) {
        super.init(texture: SKTexture(), color: UIColor(), size: CGSize(width: 128, height: 128));
        
        self.m_CharacterType = characterType;
        self.m_MoveAmount = self.size.width * 0.8;
        
        // Assign default values
        self.defaultSpeed = m_Speed;
        
        RRGameManager.shared.getEventManager().registerEventListener(listener: self);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented");
    }
    
    func generateCharacter(scene: GameScene, imageNamed image: String) -> Void {
        self.gameScene = scene;
        self.texture = SKTexture(imageNamed: image);
        self.texture?.filteringMode = .nearest;
        self.size = CGSize(width: 128, height: 128);
        self.position = CGPoint(x: 0, y: 0);
        self.zPosition = 2.5;
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 64, height: 32));
        self.physicsBody?.isDynamic = true;
        self.physicsBody?.affectedByGravity = false;
        self.physicsBody?.collisionBitMask = 0;
        
        if (m_CharacterType == CharacterTypes.player) {
            self.physicsBody?.categoryBitMask = CategoryBitMask.player;
            self.physicsBody?.contactTestBitMask = CategoryBitMask.enemy | CategoryBitMask.obstacle;
        } else {
            self.physicsBody?.categoryBitMask = CategoryBitMask.enemy;
            self.physicsBody?.contactTestBitMask = CategoryBitMask.weapon | CategoryBitMask.player;
        }
    }
    
    func shootProjectile() {
        let projectile = Weapon(imageName: "arrow");
        projectile.generate(character: self);
        self.addChild(projectile);
        
        let action = SKAction.move(by: CGVector(dx: projectile.getDistance(), dy: 0), duration: projectile.getSpeed());
        projectile.run(action) {
            projectile.destroy();
        }
    }
    
    func die() {
        m_Dead = true;
        self.physicsBody?.categoryBitMask = 0;
        
        let upAction = SKAction.move(by: CGVector(dx: 0, dy: 64), duration: 0.1);
        let fallAction = SKAction.move(by: CGVector(dx: 0, dy: -gameScene.size.width), duration: 0.5);
        
        self.run(upAction) {
            self.run(fallAction) {
                self.destroy();
                if (self.m_CharacterType == CharacterTypes.player) {
                    RRGameManager.shared.getEventManager().broadcastEvent(event: "gameOver");
                }
            }
        }
    }
    
    func die(completion: @escaping () -> Void) {
        m_Dead = true;
        self.physicsBody?.categoryBitMask = 0;
        
        let upAction = SKAction.move(by: CGVector(dx: 0, dy: 64), duration: 0.1);
        let fallAction = SKAction.move(by: CGVector(dx: 0, dy: -gameScene.size.width), duration: 0.5);
        
        self.run(upAction) {
            completion();
            
            self.run(fallAction) {
                self.destroy();
                if (self.m_CharacterType == CharacterTypes.player) {
                    RRGameManager.shared.getEventManager().broadcastEvent(event: "gameOver");
                }
            }
        }
    }
    
    func destroy() {
        self.removeFromParent();
    }
    
    func animateInFromLeft() {
        let move = SKAction.move(to: CGPoint(x: -gameScene.size.width / 3, y: 0), duration: 0.5);
        self.run(move);
    }
    
    func animateInFromRight() {
        let move = SKAction.move(to: CGPoint(x: gameScene.size.width / 3, y: 0), duration: 0.5);
        self.run(move);
    }
    
    func listen(event: String) {
         if (m_CharacterType == CharacterTypes.enemy) {
            if (event == "enemyHit") {
                die() {
                    // Add to game score
                    RRGameManager.shared.getScoreManager().addScore(amount: 1);
                    // Update score label
                    self.gameScene.updateScoreLabel(score: String(RRGameManager.shared.getScoreManager().getScore()));
                    
                    // Add to gold
                    RRGameManager.shared.getScoreManager().addGold(amount: self.m_GoldAmount);
                    // Update gold label
                    self.gameScene.updateGoldLabel(gold: String(RRGameManager.shared.getScoreManager().getGold()));
                }
            }
        }
    }
    
    func listen<T>(event: inout T) {
        
    }
}
