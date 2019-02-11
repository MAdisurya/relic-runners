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
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func generateWeaponSlots() {
        super.generateWeaponSlots();
        
        // Add the swords into the items array
        for i in 0..<m_SwordsModel.swordsArray.count {
            let swordSlot = ItemSlot(name: m_SwordsModel.swordsArray[i], itemType: .sword, pos: CGPoint(x: 0, y: (128 + 16) * -i));
            swordSlot.texture = SKTexture(imageNamed: m_SwordsModel.swordsArray[i]);
            swordSlot.texture?.filteringMode = .nearest;
            m_ItemArray.append(swordSlot);
            
            // Add the sword slot into the window
            self.addChild(swordSlot);
        }
    }
    
    override func openWindowHandler() {
        super.openWindowHandler();
        
        print("Currently equipped sword is: " + RRGameManager.shared.getInventoryManager().retrieveSword());
    }
    
    override func listen<T>(event: inout T) {
        if let closeButton = event as? CloseButton {
            // Compare memory address of close buttons to make sure it is sword windows close button
            if (Unmanaged.passUnretained(closeButton).toOpaque() == Unmanaged.passUnretained(m_CloseButton).toOpaque()) {
                m_CloseButton.closeWindow() {
                    // Store equipped sword in persistent memory
                    RRGameManager.shared.getInventoryManager().storeItems(itemType: .sword);
                }
            }
        }
    }
}
