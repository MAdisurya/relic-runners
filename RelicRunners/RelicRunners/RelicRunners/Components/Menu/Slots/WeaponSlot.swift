//
//  ItemSlot.swift
//  RelicRunners
//
//  Created by Mario Adisurya on 5/02/19.
//  Copyright © 2019 Mario Adisurya. All rights reserved.
//

import SpriteKit

class WeaponSlot: SKSpriteNode {
    
    internal var m_WeaponName: String!;
    
    // Getters
    func getWeaponName() -> String {
        return m_WeaponName;
    }
    
    // Setters
    func setWeaponName(name: String) {
        m_WeaponName = name;
    }
    
    init(name: String, pos position: CGPoint = CGPoint(x: 0, y: 0)) {
        super.init(texture: SKTexture(), color: UIColor.clear, size: CGSize());
        
        self.m_WeaponName = name;
        
        self.size = CGSize(width: 128, height: 128);
        self.position = position;
        self.color = UIColor.blue;
        
        self.texture?.filteringMode = .nearest;
        self.zPosition = 10;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
