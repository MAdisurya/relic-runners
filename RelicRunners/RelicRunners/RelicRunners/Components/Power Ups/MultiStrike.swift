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
            let newWeapon = Weapon(imageName: "arrow-1");
            
            // Generate the weapon
            newWeapon.generate(character: m_Character);
            
            // Add weapon to character
            m_Character.addChild(newWeapon);
            
            // Actions
            let strike = SKAction.move(by: CGVector(dx: newWeapon.getDistance(), dy: spread * CGFloat(i-1)), duration: newWeapon.getSpeed());
            
            // Run action
            newWeapon.run(strike) {
                // Destroy after action complete
                newWeapon.destroy();
            }
        }
    }
}
