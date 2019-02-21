//
//  RangedWindow.swift
//  RelicRunners
//
//  Created by Mario Adisurya on 16/02/19.
//  Copyright © 2019 Mario Adisurya. All rights reserved.
//

import SpriteKit

class RangedWindow: ItemWindow {
    
    private let m_RangedModel = RRRanged();
    
    override init(inventoryWindow: InventoryWindow) {
        super.init(inventoryWindow: inventoryWindow);
        
        self.m_ItemType = .ranged;
        
        // Get current equipped sword slot
        // Must be called after generateWeaponSlots()
        for i in 0..<m_ItemArray.count {
            if (m_ItemArray[i].getItemName() == RRGameManager.shared.getInventoryManager().retrieveRanged()) {
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
        
        // Add ranged into ranged array
        for i in 0..<m_RangedModel.rangedArray.count {
            let rangedSlot = ItemSlot(name: m_RangedModel.rangedArray[i], itemType: .ranged, itemWindow: self);
            rangedSlot.texture = SKTexture(imageNamed: m_RangedModel.rangedArray[i]);
            rangedSlot.texture?.filteringMode = .nearest;
            m_ItemArray.append(rangedSlot);
            
            // Add the ranged slot to the window
            self.addChild(rangedSlot);
        }
        
        positionSlots();
    }
}
