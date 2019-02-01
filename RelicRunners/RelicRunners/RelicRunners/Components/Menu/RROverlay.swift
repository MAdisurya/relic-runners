//
//  RROverlay.swift
//  RelicRunners
//
//  Created by Mario Adisurya on 31/01/19.
//  Copyright © 2019 Mario Adisurya. All rights reserved.
//

import SpriteKit

class RROverlay: SKSpriteNode {
    
    func generate(name: String, zPos: CGFloat, color: UIColor = UIColor.clear) {
        self.name = name;
        self.zPosition = zPos;
        self.color = color;
        
        self.position = CGPoint(x: 0, y: 0);
        self.size = RRGameManager.shared.getGlobalSceneSize();
    }
}
