//
//  ArmourWindow.swift
//  RelicRunners
//
//  Created by Mario Adisurya on 19/02/19.
//  Copyright © 2019 Mario Adisurya. All rights reserved.
//

import SpriteKit

class ArmourWindow: ItemWindow {
    
    private let m_ArmourModel = RRArmour();
    
    override init(inventoryWindow: InventoryWindow) {
        super.init(inventoryWindow: inventoryWindow);
        
        self.m_ItemType = .armour;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func generateWeaponSlots() {
        super.generateWeaponSlots();
        
        // Add armour to armour array
        for i in 0..<m_ArmourModel.armourArray.count {
            let armourSlot = ItemSlot(name: m_ArmourModel.armourArray[i], itemType: .armour);
            armourSlot.texture = SKTexture(imageNamed: m_ArmourModel.armourArray[i]);
            armourSlot.texture?.filteringMode = .nearest;
            
            m_ItemArray.append(armourSlot);
            
            // Add armour slot to window
            self.addChild(armourSlot);
        }
        
        positionSlots();
    }
}
