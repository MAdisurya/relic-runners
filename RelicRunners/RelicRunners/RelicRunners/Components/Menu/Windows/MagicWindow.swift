//
//  MagicWindow.swift
//  RelicRunners
//
//  Created by Mario Adisurya on 19/02/19.
//  Copyright © 2019 Mario Adisurya. All rights reserved.
//

import SpriteKit

class MagicWindow: ItemWindow {
    
    private let m_MagicModel = RRMagic();
    
    override init(inventoryWindow: InventoryWindow) {
        super.init(inventoryWindow: inventoryWindow);
        
        self.m_ItemType = .magic;
        
        // Get current equipped sword slot
        // Must be called after generateWeaponSlots()
        for i in 0..<m_ItemArray.count {
            if (m_ItemArray[i].getItemName() == RRGameManager.shared.getInventoryManager().retrieveMagic()) {
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
        
        // Add magic into magic array
        for i in 0..<m_MagicModel.magicArray.count {
            let magicSlot = ItemSlot(name: m_MagicModel.magicArray[i], itemType: .magic, itemWindow: self);
            magicSlot.texture = SKTexture(imageNamed: m_MagicModel.magicArray[i]);
            magicSlot.texture?.filteringMode = .nearest;
            
            m_ItemArray.append(magicSlot);
            
            // Add magic slot to window
            self.addChild(magicSlot);
        }
        
        positionSlots();
    }
}
