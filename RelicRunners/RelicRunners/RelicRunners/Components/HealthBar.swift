//
//  HealthBar.swift
//  RelicRunners
//
//  Created by Mario Adisurya on 18/12/18.
//  Copyright © 2018 Mario Adisurya. All rights reserved.
//

import SpriteKit

class HealthBar: SKNode {
    var m_Health: Int!;
    var m_MaxHealth: Int!;
    var m_HeartsArray: [SKSpriteNode] = [];
    
    override init() {
        super.init();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func generate(position pos: CGPoint, health: Int) {
        self.position = pos;
        self.m_Health = health;
        self.m_MaxHealth = health;
    }
    
    func reset() {
        m_Health = m_MaxHealth;
        
        // Remove any remaining hearts in the UI and hearts array
        if (m_HeartsArray.count > 0) {
            for i in 0..<m_HeartsArray.count {
                m_HeartsArray[i].removeFromParent();
            }
            
            m_HeartsArray.removeAll();
        }
        
        // Generate hearts and put in hearts array
        for i in 0..<m_Health {
            let heart = SKSpriteNode(imageNamed: "heart");
            heart.size = CGSize(width: 64, height: 64);
            heart.position = CGPoint(x: (heart.size.width * CGFloat(i)) + 8, y: 0);
            heart.zPosition = 10;
            m_HeartsArray.append(heart);
            
            self.addChild(heart);
        }
    }
    
    func subtractHealth(amount: Int) {
        if (m_HeartsArray.count >= amount) {
            for _ in 0..<amount {
                let heart = m_HeartsArray.removeLast();
                heart.removeFromParent();
            }
        }
    }
    
    func addHealth(amount: Int) {
        
    }
}
