//
//  MenuWindow.swift
//  RelicRunners
//
//  Created by Mario Adisurya on 14/01/19.
//  Copyright © 2019 Mario Adisurya. All rights reserved.
//

import SpriteKit

class MenuWindow: SKNode, RREventListener {

    internal let m_Background = SKSpriteNode();
    internal var m_CloseButton: CloseButton!;
    
    // Getters
    func getBackground() -> SKSpriteNode {
        return m_Background;
    }
    
    override init() {
        super.init();
        
        let windowSize: CGSize = RRGameManager.shared.getGlobalSceneSize();
        
        self.zPosition = 11;
        
        // Set up background
        m_Background.texture = SKTexture(imageNamed: "menu-window");
        m_Background.color = UIColor.green;
        m_Background.size = windowSize;
        m_Background.position = CGPoint(x: 0, y: 0);
        m_Background.texture?.filteringMode = .nearest;
        
        // Set up close button
        m_CloseButton = CloseButton(image: "close-button", window: self);
        m_CloseButton.position = CGPoint(x: -windowSize.width * 0.4, y: windowSize.width / 4);
        
        // Add components to Menu Window
        self.addChild(m_Background);
        self.addChild(m_CloseButton);
        
        RRGameManager.shared.getEventManager().registerEventListener(listener: self);
    }
    
    func setBackground(name backgroundName: String) {
        m_Background.texture = SKTexture(imageNamed: backgroundName);
        m_Background.texture?.filteringMode = .nearest;
    }
    
    func setWindowSize(size: CGSize) {
        m_Background.size = size;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func openWindowHandler() {
        
    }
    
    func listen(event: String) {
        
    }
    
    func listen<T>(event: inout T) {
        if let closeButton = event as? CloseButton {
            closeButton.closeWindow();
        }
    }
}
