//
//  MultiStrike.swift
//  RelicRunners
//
//  Created by Mario Adisurya on 1/12/18.
//  Copyright © 2018 Mario Adisurya. All rights reserved.
//

import SpriteKit

class MultiStrike: PowerUp {
    
    let m_WeaponsCount = 3;
    
    func execute(spreadAmount spread: CGFloat) {
        for i in 0..<m_WeaponsCount {
            // Register weapon into weapons array
            let newWeapon = Projectile();
            
            // Generate the weapon
            newWeapon.generate(character: m_Character, imageNamed: newWeapon.getImageName());
            
            // Add weapon to character
            m_Character.addChild(newWeapon);
            
            // Actions
            let strike = SKAction.move(by: CGVector(dx: 1180, dy: spread * CGFloat(i-1)), duration: newWeapon.getSpeed());
            
            // Run action
            newWeapon.run(strike) {
                // Destroy after action complete
                newWeapon.destroy();
            }
        }
    }
}
