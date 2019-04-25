//
//  ItemSlot.swift
//  RelicRunners
//
//  Created by Mario Adisurya on 5/02/19.
//  Copyright © 2019 Mario Adisurya. All rights reserved.
//

import SpriteKit

class ItemSlot: SKSpriteNode {
    
    internal var m_ItemName: String!;
    internal var m_ItemType: ItemTypes = .none;
    internal var m_ItemWindow: ItemWindow!;
    
    private let m_Border: SKSpriteNode = SKSpriteNode(imageNamed: "item-border");
    
    // Getters
    func getItemName() -> String {
        return m_ItemName;
    }
    
    func getItemType() -> ItemTypes {
        return m_ItemType;
    }
    
    // Setters
    func setItemName(name: String) {
        m_ItemName = name;
    }
    
    func setItemType(type: ItemTypes) {
        m_ItemType = type;
    }
    
    init(name: String, itemType type: ItemTypes, itemWindow: ItemWindow, pos position: CGPoint = CGPoint(x: 0, y: 0)) {
        super.init(texture: SKTexture(), color: UIColor.clear, size: CGSize());
        
        self.m_ItemName = name;
        self.m_ItemType = type;
        self.m_ItemWindow = itemWindow;
        
        self.size = CGSize(width: 128, height: 128);
        self.position = position;
        self.color = UIColor.blue;
        
        self.texture?.filteringMode = .nearest;
        self.zPosition = 10;
        
        // Setup item slot border
        self.m_Border.name = "border";
        self.m_Border.size = CGSize(width: 160, height: 160);
        self.m_Border.position = CGPoint(x: 8, y: 0);
        self.m_Border.zPosition = -1;
        self.m_Border.texture?.filteringMode = .nearest;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func enableBorder() {
        self.addChild(m_Border);
    }
    
    func disableBorder() {
        m_Border.removeFromParent();
    }
    
    func equip() {
        RRGameManager.shared.getInventoryManager().equipItem(itemType: m_ItemType, itemName: m_ItemName);
        
        m_ItemWindow.changeEquippedItemSlot(itemSlot: self);
    }
}
