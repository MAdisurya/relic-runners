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
    
    override init(inventoryWindow: InventoryWindow) {
        super.init(inventoryWindow: inventoryWindow);
        
        self.m_ItemType = .sword;
        
        // Get current equipped sword slot
        // Must be called after generateWeaponSlots()
        for i in 0..<m_ItemArray.count {
            if (m_ItemArray[i].getItemName() == RRGameManager.shared.getInventoryManager().retrieveSword()) {
                m_EquippedItemSlot = m_ItemArray[i];
                m_ItemArray[i].enableBorder();
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func generateWeaponSlots() {
        super.generateWeaponSlots();
        
        // Add the swords into the items array
        for i in 0..<m_SwordsModel.swordsArray.count {
            let swordSlot = ItemSlot(name: m_SwordsModel.swordsArray[i], itemType: .sword, itemWindow: self);
            swordSlot.texture = SKTexture(imageNamed: m_SwordsModel.swordsArray[i]);
            swordSlot.texture?.filteringMode = .nearest;
            m_ItemArray.append(swordSlot);
            
            // Add the sword slot into the window
            self.addChild(swordSlot);
        }
        
        positionSlots();
    }
    
    override func openWindowHandler() {
        super.openWindowHandler();
    }
}
