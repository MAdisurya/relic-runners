//
//  PauseOverlay.swift
//  RelicRunners
//
//  Created by Mario Adisurya on 2/02/19.
//  Copyright © 2019 Mario Adisurya. All rights reserved.
//

import SpriteKit

class PauseOverlay: RROverlay {
    
    let m_MenuLabel = SKLabelNode();
    
    override func generate(name: String, zPos: CGFloat, color: UIColor) {
        super.generate(name: name, zPos: zPos, color: color);
        
        self.m_MenuLabel.text = "Back To Menu";
        self.m_MenuLabel.fontName = "Silkscreen Bold";
        self.m_MenuLabel.fontSize = 64;
        self.m_MenuLabel.position = CGPoint(x: 0, y: 0);
        self.m_MenuLabel.zPosition = 13;
        self.m_MenuLabel.name = "back-to-menu";
        
        self.addChild(m_MenuLabel);
    }
}
