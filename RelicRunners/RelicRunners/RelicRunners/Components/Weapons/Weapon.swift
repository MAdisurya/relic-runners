//
//  Weapon.swift
//  RelicRunners
//
//  Created by Mario Adisurya on 1/12/18.
//  Copyright © 2018 Mario Adisurya. All rights reserved.
//

import SpriteKit

class Weapon: SKSpriteNode, RREventListener {
    
    internal var m_Speed: Double!;
    internal var m_Distance: CGFloat!;
    
    init(imageName image: String, speed: Double = 0.5, distance: CGFloat = 1180) {
        super.init(texture: SKTexture(imageNamed: image), color: UIColor(), size: CGSize(width: 64, height: 64));
        
        self.m_Speed = speed;
        self.m_Distance = distance;
        
        self.zPosition = 3.0;
        
        RRGameManager.shared.getEventManager().registerEventListener(listener: self);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getSpeed() -> Double {
        return m_Speed;
    }
    
    func getDistance() -> CGFloat {
        return m_Distance;
    }
    
    func generate(character: Character) {
        self.size = CGSize(width: character.size.width / 2, height: character.size.height / 2);
        self.position = CGPoint(x: character.size.width / 4, y: 0);
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 64, height: 64));
        self.physicsBody?.isDynamic = false;
        self.physicsBody?.categoryBitMask = CategoryBitMask.weapon;
        self.physicsBody?.contactTestBitMask = CategoryBitMask.enemy | CategoryBitMask.boss;
        
        self.texture?.filteringMode = .nearest;
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
    
    func listen<T>(event: inout T) {
        
    }
}
