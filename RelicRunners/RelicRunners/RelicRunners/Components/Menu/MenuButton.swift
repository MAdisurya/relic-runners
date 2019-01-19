//
//  MenuButton.swift
//  RelicRunners
//
//  Created by Mario Adisurya on 14/01/19.
//  Copyright © 2019 Mario Adisurya. All rights reserved.
//

import SpriteKit

class MenuButton: SKSpriteNode {
    
    private var m_Window: MenuWindow!;
    
    init(image imageNamed: String, windowSize: CGSize, name: String) {
        super.init(texture: SKTexture(imageNamed: imageNamed), color: UIColor.clear, size: CGSize(width: 64, height: 64));
        
        self.zPosition = 10;
        self.texture?.filteringMode = .nearest;
        self.name = name;
        
        // Initialize menu window
        m_Window = MenuWindow(windowSize: CGSize(width: 728, height: 740));
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented");
    }
    
    func openWindow() {
        // Add window to MenuUI
        self.parent?.addChild(m_Window);
    }
    
    func setBackground(color: UIColor) {
        m_Window.getBackground().color = color;
    }
}
