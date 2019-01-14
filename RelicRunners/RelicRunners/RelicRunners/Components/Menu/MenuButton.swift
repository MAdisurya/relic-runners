//
//  MenuButton.swift
//  RelicRunners
//
//  Created by Mario Adisurya on 14/01/19.
//  Copyright © 2019 Mario Adisurya. All rights reserved.
//

import SpriteKit

class MenuButton: SKSpriteNode {
    
    let m_Window = SKSpriteNode();
    
    init(image imageNamed: String, windowSize: CGSize, name: String) {
        super.init(texture: SKTexture(imageNamed: imageNamed), color: UIColor.clear, size: CGSize(width: 64, height: 64));
        
        self.zPosition = 10;
        self.texture?.filteringMode = .nearest;
        self.name = name;
        
        m_Window.size = windowSize;
        m_Window.position = CGPoint(x: 0, y: -windowSize.height / 2);
        m_Window.color = UIColor.green;
        m_Window.zPosition = 12;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented");
    }
    
    func openWindow() {
        // Add window to MenuUI
        self.parent?.addChild(m_Window);
    }
    
    func closeWindow() {
        // Remove window from MenuUI
        m_Window.removeFromParent();
    }
}
