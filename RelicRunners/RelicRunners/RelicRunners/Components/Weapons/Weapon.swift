//
//  Weapon.swift
//  RelicRunners
//
//  Created by Mario Adisurya on 1/12/18.
//  Copyright © 2018 Mario Adisurya. All rights reserved.
//

import SpriteKit

class Weapon: SKSpriteNode, RREventListener {
    
    internal let m_Speed: Double = 0.5;
    internal var m_ImageName: String = "arrow";
    
    init() {
        super.init(texture: SKTexture(), color: UIColor(), size: CGSize(width: 64, height: 64));
        
        RRGameManager.shared.getEventManager().registerEventListener(listener: self);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getSpeed() -> Double {
        return m_Speed;
    }
    
    func getImageName() -> String {
        return m_ImageName;
    }
    
    func generate(character: Character, imageNamed image: String) {
        self.texture = SKTexture(imageNamed: image);
        self.size = CGSize(width: character.size.width / 4, height: character.size.height / 4);
        self.zPosition = 2.0;
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 64, height: 64));
        self.physicsBody?.isDynamic = false;
        self.physicsBody?.categoryBitMask = CategoryBitMask.weapon;
        self.physicsBody?.contactTestBitMask = CategoryBitMask.enemy | CategoryBitMask.boss;
    }
    
    func destroy() {
        self.removeFromParent();
    }
    
    func listen(event: String) {
        // Handle weapon destroyed
        if (event == "weaponDestroyed") {
            destroy();
        }
    }
}
