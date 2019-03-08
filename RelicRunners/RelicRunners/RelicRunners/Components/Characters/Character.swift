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
    
    internal var m_Health = 0;
    internal var m_MaxHealth = 0;
    internal var m_Speed: Double = 0.5;
    internal var m_Invinsible = false;
    internal let m_GoldAmount: Int = Int.random(in: 1...5);
    
    internal var m_Animation: Animation = Animation();
    
    // Default values
    internal var defaultSpeed: Double!;
    
    // Getters
    func getAnimation() -> Animation {
        return m_Animation;
    }
    
    // Setters
    func setAnimation(anim: Animation) {
        m_Animation = anim;
    }
    
    init(type characterType: CharacterTypes) {
        super.init(texture: SKTexture(), color: UIColor(), size: CGSize(width: 176, height: 176));
        
        self.m_CharacterType = characterType;
        
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
        self.size = CGSize(width: 256, height: 256);
        self.position = CGPoint(x: 0, y: 0);
        self.zPosition = 2.5;
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 64, height: 64), center: CGPoint(x: 0, y: -32));
        self.physicsBody?.isDynamic = true;
        self.physicsBody?.affectedByGravity = false;
        self.physicsBody?.collisionBitMask = 0;
        self.physicsBody?.categoryBitMask = CategoryBitMask.enemy;
        self.physicsBody?.contactTestBitMask = CategoryBitMask.weapon | CategoryBitMask.player;
        
        m_MaxHealth = m_Health;
    }
    
    func shootProjectile() {
        let projectile = Weapon(imageName: "arrow");
        let arrowAtlas = SKTextureAtlas(named: "arrows");
        var textures: [SKTexture] = [];
        projectile.generate(character: self);
        self.addChild(projectile);
        
        // Loop through each texture in atlas and append to SKTexture array
        for textureName in arrowAtlas.textureNames {
            // Set each texture in atlas filtering mode to nearest
            arrowAtlas.textureNamed(textureName).filteringMode = .nearest;
            // Append the texture from atlas into texture array
            textures.append(arrowAtlas.textureNamed(textureName));
        }
        
        let move = SKAction.move(by: CGVector(dx: projectile.getDistance(), dy: 0), duration: projectile.getSpeed());
        let projectileAnimation = SKAction.animate(with: textures, timePerFrame: 0.1);
        let repeatAnim = SKAction.repeatForever(projectileAnimation);
        
        projectile.run(repeatAnim);
        
        projectile.run(move) {
            projectile.destroy();
        }
    }
    
    func die() {
        m_Dead = true;
        self.physicsBody?.categoryBitMask = 0;
        
        // Gold indicator to pop up after character death
        if (m_CharacterType == CharacterTypes.enemy) {
            let m_GoldIndicator = UIIndicator();
            m_GoldIndicator.generate(pos: self.position, imageName: "coin-tails", text: "+" + String(m_GoldAmount));
            gameScene.addChild(m_GoldIndicator);
            m_GoldIndicator.animate() {
                m_GoldIndicator.destroy();
            };
        }
        
        let upAction = SKAction.move(by: CGVector(dx: 0, dy: 64), duration: 0.1);
        let fallAction = SKAction.move(by: CGVector(dx: 0, dy: -gameScene.size.width), duration: 0.5);
        
        self.removeAllActions();
        
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
        
        // Gold indicator to pop up after character death
        if (m_CharacterType == CharacterTypes.enemy) {
            let m_GoldIndicator = UIIndicator();
            m_GoldIndicator.generate(pos: self.position, imageName: "coin-tails", text: "+" + String(m_GoldAmount));
            gameScene.addChild(m_GoldIndicator);
            m_GoldIndicator.animate() {
                m_GoldIndicator.destroy();
            };
        }
        
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
        let move = SKAction.move(to: CGPoint(x: -gameScene.size.width / 3, y: self.position.y), duration: 0.5);
        self.run(move);
    }
    
    func animateInFromRight() {
        let move = SKAction.move(to: CGPoint(x: gameScene.size.width / 3, y: self.position.y), duration: 0.5);
        self.run(move);
    }
    
    func animateInFromLeft(completion: @escaping () -> Void) {
        let move = SKAction.move(to: CGPoint(x: -gameScene.size.width / 3, y: self.position.y), duration: 0.5);
        self.run(move) {
            completion();
        };
    }
    
    func animateInFromRight(completion: @escaping () -> Void) {
        let move = SKAction.move(to: CGPoint(x: gameScene.size.width / 3, y: self.position.y), duration: 0.5);
        self.run(move) {
            completion();
        };
    }
    
    func animateOutLeft() {
        let move = SKAction.move(to: CGPoint(x: -gameScene.size.width, y: self.position.y), duration: 0.5);
        self.run(move);
    }
    
    func animateOutLeft(completion: @escaping () -> Void) {
        let move = SKAction.move(to: CGPoint(x: -gameScene.size.width, y: self.position.y), duration: 0.5);
        self.run(move) {
            completion();
        };
    }
    
    func animateOutRight() {
        let move = SKAction.move(to: CGPoint(x: gameScene.size.width, y: 0), duration: 0.5);
        self.run(move);
    }
    
    func animateOutRight(completion: @escaping () -> Void) {
        let move = SKAction.move(to: CGPoint(x: gameScene.size.width, y: 0), duration: 0.5);
        self.run(move) {
            completion();
        };
    }
    
    func listen(event: String) {
         if (m_CharacterType == CharacterTypes.enemy) {
            if (event == "enemyHit") {
                die() {
                    // Add to game score
                    RRGameManager.shared.getScoreManager().addScore(amount: 1);
                    // Update score label
//                    self.gameScene.updateScoreLabel(score: String(RRGameManager.shared.getScoreManager().getScore()));
                    
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
