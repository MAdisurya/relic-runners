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
    
    private let m_SlotSize = CGSize(width: 128, height: 128);
    
    override init(windowSize: CGSize) {
        super.init(windowSize: windowSize);
        
        setBackground(name: "menu-window");
        
        #warning ("Need to refactor, create class for slots")
        
        // Initialize slot buttons
        self.m_SwordSlot = MenuButton(image: "sword-slot", windowSize: windowSize, name: "sword-slot");
        self.m_RangedSlot = MenuButton(image: "ranged-slot", windowSize: windowSize, name: "ranged-slot");
        self.m_MagicSlot = MenuButton(image: "magic-slot", windowSize: windowSize, name: "magic-slot");
        self.m_ArmourSlot = MenuButton(image: "armour-slot", windowSize: windowSize, name: "armour-slot");
        
        self.m_SwordSlot.getWindow().setBackground(name: "items-window");
        self.m_RangedSlot.getWindow().setBackground(name: "items-window");
        self.m_MagicSlot.getWindow().setBackground(name: "items-window");
        self.m_ArmourSlot.getWindow().setBackground(name: "items-window");
        
        self.m_SwordSlot.size = m_SlotSize;
        self.m_RangedSlot.size = m_SlotSize;
        self.m_MagicSlot.size = m_SlotSize;
        self.m_ArmourSlot.size = m_SlotSize;
        
        self.m_SwordSlot.position = CGPoint(x: -192, y: -176);
        self.m_RangedSlot.position = CGPoint(x: 192, y: -176);
        self.m_MagicSlot.position = CGPoint(x: -192, y: 176);
        self.m_ArmourSlot.position = CGPoint(x: 192, y: 176ß);
        
        // Add slots to window
        self.addChild(m_SwordSlot);
        self.addChild(m_RangedSlot);
        self.addChild(m_MagicSlot);
        self.addChild(m_ArmourSlot);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
