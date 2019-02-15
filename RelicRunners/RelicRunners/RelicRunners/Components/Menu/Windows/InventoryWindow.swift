//
//  LoadoutWindow.swift
//  RelicRunners
//
//  Created by Mario Adisurya on 24/01/19.
//  Copyright © 2019 Mario Adisurya. All rights reserved.
//

import SpriteKit

class InventoryWindow: MenuWindow {
    
    private var m_SwordSlot: MenuButton!;
    private var m_RangedSlot: MenuButton!;
    private var m_MagicSlot: MenuButton!;
    private var m_ArmourSlot: MenuButton!;
    
    private var m_SwordWindow: SwordWindow!;
    private var m_RangedWindow: RangedWindow!;
    
    private var m_Doll = SKSpriteNode(imageNamed: "doll");
    
    private let m_SlotSize = CGSize(width: 128, height: 128);
    
    override init() {
        super.init();
        
        self.setBackground(name: "menu-window");
        
        self.m_SwordWindow = SwordWindow(inventoryWindow: self);
        self.m_RangedWindow = RangedWindow(inventoryWindow: self);
        
        #warning ("Need to refactor, create class for slots")
        
        // Initialize slot buttons
        self.m_SwordSlot = MenuButton(image: "sword-slot", name: "sword-slot");
        self.m_RangedSlot = MenuButton(image: "ranged-slot", name: "ranged-slot");
        self.m_MagicSlot = MenuButton(image: "magic-slot", name: "magic-slot");
        self.m_ArmourSlot = MenuButton(image: "armour-slot", name: "armour-slot");
        
        self.m_SwordSlot.setWindow(window: m_SwordWindow);
        self.m_RangedSlot.setWindow(window: m_RangedWindow);
        self.m_MagicSlot.getWindow().setBackground(name: "items-window");
        self.m_ArmourSlot.getWindow().setBackground(name: "items-window");
        
        self.m_SwordSlot.size = m_SlotSize;
        self.m_RangedSlot.size = m_SlotSize;
        self.m_MagicSlot.size = m_SlotSize;
        self.m_ArmourSlot.size = m_SlotSize;
//        self.m_Doll.size = CGSize(width: 576, height: 520);
        self.m_Doll.size = CGSize(width: 288, height: 260);
        
        self.m_SwordSlot.position = CGPoint(x: -192, y: -176);
        self.m_RangedSlot.position = CGPoint(x: 192, y: -176);
        self.m_MagicSlot.position = CGPoint(x: -192, y: 176);
        self.m_ArmourSlot.position = CGPoint(x: 192, y: 176);
        self.m_Doll.position = CGPoint(x: 0, y: 0 );
        
        self.m_Doll.zPosition = 10;
        self.m_Doll.texture?.filteringMode = .nearest;
        
        // Add slots to window
        self.addChild(m_SwordSlot);
        self.addChild(m_RangedSlot);
        self.addChild(m_MagicSlot);
        self.addChild(m_ArmourSlot);
        self.addChild(m_Doll);
        
        self.update();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update() {
        // Update the item slots
        self.m_SwordSlot.texture = SKTexture(imageNamed: RRGameManager.shared.getInventoryManager().retrieveSword());
        self.m_RangedSlot.texture = SKTexture(imageNamed: RRGameManager.shared.getInventoryManager().retrieveRanged());
    }
}
