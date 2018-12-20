//
//  Mechazoid.swift
//  RelicRunners
//
//  Created by Mario Adisurya on 18/12/18.
//  Copyright © 2018 Mario Adisurya. All rights reserved.
//

import SpriteKit

class Mechazoid: Boss {
    
    private var m_Lasers: [BossLaser] = [];
    private var m_Mines: [BossMine] = [];
    
    override init(type characterType: CharacterTypes) {
        super.init(type: characterType);
        
        m_Health = 20;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func generateCharacter(scene: GameScene, imageNamed image: String) {
        super.generateCharacter(scene: scene, imageNamed: image);
        
        // Add weapons to weapons array
        for i in -1..<2 {
            let laser = BossLaser(imageName: "angry-face", speed: 0.5, distance: 1180);
            let mine = BossMine(imageName: "angry-face", speed: 0.5, distance: 1180);
            
            laser.position = CGPoint(x: 0, y: (gameScene.getMoveAmount() * CGFloat(i)) - laser.size.height);
            mine.position = CGPoint(x: 0, y: (gameScene.getMoveAmount() * CGFloat(i)) - mine.size.height);
            
            // Populate the weapons array
            m_Lasers.append(laser);
            m_Mines.append(mine);
            
            // Add weapons to the weapon holders
            m_WeaponHolders[0].addChild(laser);
//            m_WeaponHolders[1].addChild(laser);
//            m_WeaponHolders[2].addChild(laser);
        }
    }
    
    override func attackPhaseOne() {
        // Laser Barrage
        let randomNum = Int.random(in: 0..<m_Lasers.count);

        m_Lasers[randomNum].fire();
    }
    
    override func attackPhaseTwo() {
        // Minefield
        attackPhaseOne(); // To be removed
    }
    
    override func attackPhaseThree() {
        // Laser Minefield Barrage
        attackPhaseOne(); // To be removed
    }
    
    override func updateHeldWeapon() {
//        super.updateHeldWeapon();
        self.removeAllChildren();
        self.addChild(m_WeaponHolders[0]);
    }
}
