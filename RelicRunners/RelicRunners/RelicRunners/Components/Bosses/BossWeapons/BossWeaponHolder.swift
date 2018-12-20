//
//  BossWeaponHolder.swift
//  RelicRunners
//
//  Created by Mario Adisurya on 20/12/18.
//  Copyright © 2018 Mario Adisurya. All rights reserved.
//

import SpriteKit

class BossWeaponHolder: SKNode {
    
    init(position pos: CGPoint) {
        super.init();
        
        self.position = pos;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
