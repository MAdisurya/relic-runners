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
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func generateWeaponSlots() {
        super.generateWeaponSlots();
        
        // Add magic into magic array
        for i in 0..<m_MagicModel.magicArray.count {
            let magicSlot = ItemSlot(name: m_MagicModel.magicArray[i], itemType: .magic);
            magicSlot.texture = SKTexture(imageNamed: m_MagicModel.magicArray[i]);
            magicSlot.texture?.filteringMode = .nearest;
            
            m_ItemArray.append(magicSlot);
            
            // Add magic slot to window
            self.addChild(magicSlot);
        }
        
        positionSlots();
    }
}
