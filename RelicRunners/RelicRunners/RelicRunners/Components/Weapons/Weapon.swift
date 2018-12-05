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
    internal var m_ImageName: String!;
    
    init(imageName image: String, speed: Double = 0.5, distance: CGFloat = 1180) {
        super.init(texture: SKTexture(), color: UIColor(), size: CGSize(width: 64, height: 64));
        
        self.m_ImageName = image;
        self.m_Speed = speed;
        self.m_Distance = distance;
        
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
    
    func getImageName() -> String {
        return m_ImageName;
    }
    
    func generate(character: Character) {
        self.texture = SKTexture(imageNamed: m_ImageName);
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
    
    func listen<T>(event: inout T) {
        
    }
}
