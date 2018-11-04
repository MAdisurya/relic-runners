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
    var gameScene: SKScene!;
    
    init(type characterType: CharacterTypes) {
        super.init(texture: SKTexture(), color: UIColor(), size: CGSize(width: 100, height: 100));
        
        self.m_CharacterType = characterType;
        
        RRGameManager.shared.getEventManager().registerEventListener(listener: self);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented");
    }
    
    func generateCharacter(scene: SKScene, imageNamed image: String) -> Void {
        self.gameScene = scene;
        self.texture = SKTexture(imageNamed: image);
        self.size = CGSize(width: gameScene.size.width / 7, height: gameScene.size.width / 7);
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 64, height: 64));
        self.physicsBody?.isDynamic = true;
        self.physicsBody?.affectedByGravity = false;
        self.physicsBody?.collisionBitMask = 0;
        
        if (m_CharacterType == CharacterTypes.player) {
            self.physicsBody?.categoryBitMask = CategoryBitMask.player;
            self.physicsBody?.contactTestBitMask = CategoryBitMask.enemy | CategoryBitMask.obstacle;
        } else {
            self.physicsBody?.categoryBitMask = CategoryBitMask.enemy;
            self.physicsBody?.contactTestBitMask = CategoryBitMask.projectile | CategoryBitMask.player;
        }
    }
    
    func shootProjectile() {
        let projectile = Projectile();
        projectile.generateProjectile(character: self, imageNamed: "bullet-bill");
        self.addChild(projectile);
        
        let action = SKAction.move(by: CGVector(dx: gameScene.size.width, dy: 0), duration: projectile.getSpeed());
        projectile.run(action) {
            projectile.destroy();
        }
    }
    
    func destroy() {
        self.removeFromParent();
    }
    
    func listen(event: String) {
        if (m_CharacterType == CharacterTypes.player) {
            if (event == "swipeUp") {
                if (self.position.y <= 50) {
                    let action = SKAction.move(by: CGVector(dx: 0, dy: self.size.height), duration: 0.5);
                    self.run(action);
                }
            } else if (event == "swipeDown") {
                if (self.position.y >= -50) {
                    let action = SKAction.move(by: CGVector(dx: -0, dy: -self.size.height), duration: 0.5);
                    self.run(action);
                }
            } else if (event == "tap") {
                shootProjectile();
            } else if (event == "playerDestroyed") {
                destroy();
            }
        } else {
            if (event == "enemyDestroyed") {
                destroy();
            }
        }
    }
}
