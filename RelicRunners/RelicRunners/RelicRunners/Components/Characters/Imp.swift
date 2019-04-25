//
//  Imp.swift
//  RelicRunners
//
//  Created by Mario Adisurya on 15/03/19.
//  Copyright © 2019 Mario Adisurya. All rights reserved.
//

import SpriteKit

class Imp: Character
{
    let m_Projectile = Weapon(speed: 2, distance: -1180);
    
    let m_Cooldown: Double = 1.0;
    
    private let m_ProjAnim = BlueProjectilAnimation();
    private let m_Anim = ImpAnimation();
    
    override init(type characterType: CharacterTypes = .enemy)
    {
        super.init(type: characterType);
        
        self.m_Health = 1;
        self.m_Projectile.size = CGSize(width: 196, height: 128);
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func generateCharacter(scene: GameScene, imageNamed image: String, enemyName name: String)
    {
        super.generateCharacter(scene: scene, imageNamed: image, enemyName: name);
        
        self.run(m_Anim.idle(speed: 0.1));
    }
    
    override func shootProjectile(projectile p: Weapon, cooldown: Double)
    {
        super.shootProjectile(projectile: p, cooldown: cooldown);
        
        p.run(m_ProjAnim.animate(speed: 0.2));
    }
}
