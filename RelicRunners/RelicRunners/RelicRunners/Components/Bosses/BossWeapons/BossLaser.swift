//
//  BossLaser.swift
//  RelicRunners
//
//  Created by Mario Adisurya on 19/12/18.
//  Copyright © 2018 Mario Adisurya. All rights reserved.
//

import SpriteKit

class BossLaser: BossWeapon {
    
    private let m_Laser = SKSpriteNode();
    
    override init(imageName image: String, speed: Double, distance: CGFloat) {
        super.init(imageName: image, speed: speed, distance: distance);
        
        m_DefaultTexture = SKTexture(imageNamed: image);
        
        // Laser
        m_Laser.color = UIColor.red;
        m_Laser.size = CGSize(width: self.m_Distance, height: 64);
        m_Laser.anchorPoint = CGPoint(x: 1, y: 0.5);
        m_Laser.physicsBody = SKPhysicsBody(rectangleOf: m_Laser.size, center: CGPoint(x: -distance / 2, y: 0));
        m_Laser.physicsBody?.isDynamic = false;
        m_Laser.physicsBody?.categoryBitMask = CategoryBitMask.obstacle;
        m_Laser.physicsBody?.contactTestBitMask = CategoryBitMask.player;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func fire() {
        if (m_WeaponCooldown > 0) {
            super.fire();
            
            let prefire = SKAction.wait(forDuration: 1.25);
            let fireDuration = SKAction.wait(forDuration: 0.75);
            
            self.texture = SKTexture();
            
            self.run(prefire) {
                self.addChild(self.m_Laser);
                self.texture = self.m_DefaultTexture;
                
                self.run(fireDuration) {
                    self.m_Laser.removeFromParent();
                }
            }
        }
    }
    
    override func listen(event: String) {
        super.listen(event: event);
    }
}
