//
//  SwordWindow.swift
//  RelicRunners
//
//  Created by Mario Adisurya on 5/02/19.
//  Copyright © 2019 Mario Adisurya. All rights reserved.
//

import SpriteKit

class ItemWindow: MenuWindow {
    
    internal var m_ItemArray: [ItemSlot] = [];
    
    override init() {
        super.init();
        
        self.m_Background.texture = SKTexture(imageNamed: "items-window");
        self.m_Background.texture?.filteringMode = .nearest;
        
        self.generateWeaponSlots();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func generateWeaponSlots() { }
}
