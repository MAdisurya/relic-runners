//
//  CloseButton.swift
//  RelicRunners
//
//  Created by Mario Adisurya on 15/01/19.
//  Copyright © 2019 Mario Adisurya. All rights reserved.
//

import SpriteKit

class CloseButton: SKSpriteNode {
    
    private var m_Window: MenuWindow!;
    
    init(image imageNamed: String, window: MenuWindow) {
        super.init(texture: SKTexture(imageNamed: imageNamed), color: UIColor.clear, size: CGSize(width: 48, height: 48));
        
        self.m_Window = window;
        self.zPosition = 12;
        self.texture?.filteringMode = .nearest;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented");
    }
    
    func closeWindow() {
        // Remove the window from the UI
        m_Window?.removeFromParent();
    }
}
