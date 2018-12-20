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
            let laser = BossLaser(imageName: "laser", speed: 0.5, distance: 1180);
            let mine = BossMine(imageName: "mine", speed: 0.5, distance: 1180);
            
            laser.position = CGPoint(x: 0, y: (gameScene.getMoveAmount() * CGFloat(i)) - laser.size.height);
            mine.position = CGPoint(x: 0, y: (gameScene.getMoveAmount() * CGFloat(i)) - mine.size.height);
            
            // Populate the weapons array
            m_Lasers.append(laser);
            m_Mines.append(mine);
        }
    }
    
    override func attackPhaseOne() {
        // Laser Barrage
        let randomNum = Int.random(in: 0..<m_Lasers.count);
        
        m_Lasers[randomNum].fire();
    }
    
    override func attackPhaseTwo() {
        // Minefield
    }
    
    override func attackPhaseThree() {
        // Laser Minefield Barrage
    }
    
    override func updateHeldWeapon() {
        super.updateHeldWeapon();
        
        switch (m_CurrentPhase) {
        case 1:
            for laser in m_Lasers {
                m_WeaponsHolder.addChild(laser);
            }
            break;
        case 2:
            for mine in m_Mines {
                m_WeaponsHolder.addChild(mine);
            }
            break;
        default:
            break;
        }
    }
}
