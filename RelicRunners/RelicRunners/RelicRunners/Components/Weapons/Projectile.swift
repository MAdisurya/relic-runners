//
//  Projectile.swift
//  RelicRunners
//
//  Created by Mario Adisurya on 4/11/18.
//  Copyright © 2018 Mario Adisurya. All rights reserved.
//

import SpriteKit

class Projectile: Weapon {
    
    override init() {
        super.init();
        
        m_ImageName = "arrow";
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
