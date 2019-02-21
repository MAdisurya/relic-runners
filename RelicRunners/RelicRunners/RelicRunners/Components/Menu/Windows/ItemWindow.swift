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
    internal var m_ItemType: ItemTypes = .none;
    
    internal var m_InventoryWindow: InventoryWindow!;
    
    internal var m_EquippedItemSlot: ItemSlot!;
    
    init(inventoryWindow: InventoryWindow) {
        super.init();
        
        self.m_InventoryWindow = inventoryWindow;
        
        self.m_Background.texture = SKTexture(imageNamed: "items-window");
        self.m_Background.texture?.filteringMode = .nearest;
        
        self.generateWeaponSlots();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func generateWeaponSlots() { }
    
    func positionSlots() {
        for i in -2...2 {
            let item = m_ItemArray[i + 2];
            
            if (i % 2 == 0) {
                // Handles i = -2 and i = 2
                item.position = CGPoint(x: -232, y: 64 * i);
            } else {
                // Handles i = -1 and i = 1
                item.position = CGPoint(x: 232, y: 128 * i);
            }
            
            if (i == 0) {
                item.position = CGPoint(x: 0, y: 0);
            }
        }
    }
    
    override func listen<T>(event: inout T) {
        if let closeButton = event as? CloseButton {
            // Compare memory address of close buttons to make sure it is correct windows close button
            if (Unmanaged.passUnretained(closeButton).toOpaque() == Unmanaged.passUnretained(m_CloseButton).toOpaque()) {
                m_CloseButton.closeWindow() {
                    // Store equipped item in persistent memory
                    RRGameManager.shared.getInventoryManager().storeItems(itemType: self.m_ItemType);
                    
                    // Update the Inventory Window
                    self.m_InventoryWindow.update();
                }
            }
        }
    }
}
