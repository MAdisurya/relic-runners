//
//  Animation.swift
//  RelicRunners
//
//  Created by Mario Adisurya on 16/02/19.
//  Copyright © 2019 Mario Adisurya. All rights reserved.
//

import SpriteKit

class Animation {
    
    internal var m_Textures: [SKTexture] = [];
    
    // Functions declaration / Animations
    func idle(speed: Double) -> SKAction { return SKAction(); }
    func run(speed: Double) -> SKAction { return SKAction(); }
    func attack(speed: Double) -> SKAction { return SKAction(); }
    func die(speed: Double) -> SKAction { return SKAction(); }
}
