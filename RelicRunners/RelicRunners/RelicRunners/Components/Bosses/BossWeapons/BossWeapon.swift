//
//  BossWeapon.swift
//  RelicRunners
//
//  Created by Mario Adisurya on 20/12/18.
//  Copyright © 2018 Mario Adisurya. All rights reserved.
//

import SpriteKit

class BossWeapon: Weapon {
    
    internal var m_WeaponCooldown: Double = 1;
    internal var m_DefaultTexture = SKTexture();
    
    override init(imageName image: String, speed: Double, distance: CGFloat) {
        super.init(imageName: image, speed: speed, distance: distance);
        
        self.size = CGSize(width: 64, height: 64);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func resetWeaponCooldown() {
        let weaponCooldown = m_WeaponCooldown;
        m_WeaponCooldown = 0;
        
        let wait = SKAction.wait(forDuration: weaponCooldown);
        
        self.run(wait) {
            self.m_WeaponCooldown = weaponCooldown;
        }
    }
    
    func fire() {
        resetWeaponCooldown();
    }
    
    override func listen(event: String) {
        if (event == "resetBossWeapons") {
            self.removeAllActions();
            self.removeAllChildren();
            self.texture = m_DefaultTexture;
            m_WeaponCooldown = 1;
        }
    }
}
