//
//  RRInventoryManager.swift
//  RelicRunners
//
//  Created by Mario Adisurya on 11/02/19.
//  Copyright © 2019 Mario Adisurya. All rights reserved.
//

import SpriteKit

class RRInventoryManager {
    
    var m_EquippedSword: String? = "fire-sword";
    var m_EquippedRanged: String? = "fire-bow";
    var m_EquippedMagic: String? = "fire-staff";
    var m_EquippedArmour: String? = "fire-armour";
    
    private let m_UserDefaults = UserDefaults.standard;
    
    init() {
        self.m_EquippedSword = retrieveSword();
        self.m_EquippedRanged = retrieveRanged();
        self.m_EquippedMagic = retrieveMagic();
        self.m_EquippedArmour = retrieveArmour();
    }
    
    func equipItem(itemType type: ItemTypes, itemName name: String) {
        // Assign item names based on item type
        
        switch (type) {
            case (ItemTypes.sword):
                m_EquippedSword = name;
                break;
            case (ItemTypes.ranged):
                m_EquippedRanged = name;
                break;
            case (ItemTypes.magic):
                m_EquippedMagic = name;
                break;
            case (ItemTypes.armour):
                m_EquippedArmour = name;
                break;
            default:
                break;
        }
    }
    
    func storeItems(itemType type: ItemTypes) {
        // Store items in persistent memory
        
        switch (type) {
            case (ItemTypes.sword):
                m_UserDefaults.set(m_EquippedSword, forKey: "rr-equipped-sword");
                break;
            case (ItemTypes.ranged):
                m_UserDefaults.set(m_EquippedRanged, forKey: "rr-equipped-ranged");
                break;
            case (ItemTypes.magic):
                m_UserDefaults.set(m_EquippedMagic, forKey: "rr-equipped-magic");
                break;
            case (ItemTypes.armour):
                m_UserDefaults.set(m_EquippedArmour, forKey: "rr-equipped-armour");
                break;
            default:
                break;
        }
    }
    
    func retrieveSword() -> String {
        return m_UserDefaults.string(forKey: "rr-equipped-sword") ?? "sword1";
    }
    
    func retrieveRanged() -> String {
        return m_UserDefaults.string(forKey: "rr-equipped-ranged") ?? "ranged1";
    }
    
    func retrieveMagic() -> String {
        return m_UserDefaults.string(forKey: "rr-equipped-magic") ?? "magic1";
    }
    
    func retrieveArmour() -> String {
        return m_UserDefaults.string(forKey: "rr-equipped-armour") ?? "armour1";
    }
}
