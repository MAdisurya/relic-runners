//
//  SwordWindow.swift
//  RelicRunners
//
//  Created by Mario Adisurya on 5/02/19.
//  Copyright © 2019 Mario Adisurya. All rights reserved.
//

import SpriteKit

class SwordWindow: ItemWindow {
    
    private let m_SwordsModel = RRSwords();
    
    override init() {
        super.init();
        
        generateWeaponSlots();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func generateWeaponSlots() {
        // Add the swords into the items array
        for i in 0..<m_SwordsModel.m_SwordsArray.count {
            let swordSlot = WeaponSlot(name: m_SwordsModel.m_SwordsArray[i], pos: CGPoint(x: 0, y: (128 + 16) * -i));
            m_ItemArray.append(swordSlot);
            
            // Add the sword slot into the window
            self.addChild(swordSlot);
        }
    }
}
