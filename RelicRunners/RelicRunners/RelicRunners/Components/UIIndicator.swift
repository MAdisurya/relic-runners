//
//  GoldIndicator.swift
//  RelicRunners
//
//  Created by Mario Adisurya on 6/12/18.
//  Copyright © 2018 Mario Adisurya. All rights reserved.
//

import SpriteKit

class UIIndicator: SKNode {
    
    private let m_Text = SKLabelNode();
    private let m_Icon = SKSpriteNode();
    
    // Getters
    func getText() -> SKLabelNode {
        return m_Text;
    }
    
    func getIcon() -> SKSpriteNode {
        return m_Icon;
    }
    
    func generate(pos: CGPoint, imageName image: String, text: String) {
        m_Icon.texture = SKTexture(imageNamed: image);
        m_Icon.texture?.filteringMode = .nearest;
        m_Text.fontName = "Silkscreen Bold";
        m_Text.fontSize = 64;
        m_Text.text = text;
        
        m_Icon.position = CGPoint(x: -64, y: 0);
        m_Icon.size = CGSize(width: 64, height: 64);
        m_Text.position = CGPoint(x: 64, y: -8);
        
        self.position = pos;
        self.zPosition = 9;
        
        // Add text and icon to UIIndicator
        self.addChild(m_Icon);
        self.addChild(m_Text);
    }
    
    func animate() {
        // Animate
        let rise = SKAction.move(by: CGVector(dx: 0, dy: 64), duration: 0.25);
        let fadeIn = SKAction.fadeIn(withDuration: 0.25);
        let fadeOut = SKAction.fadeOut(withDuration: 0.25);
        let sequence = SKAction.sequence([fadeIn, rise, fadeOut]);
        
        self.run(sequence);
    }
    
    func animate(completion: @escaping () -> Void) {
        // Animate with completion handler
        let rise = SKAction.move(by: CGVector(dx: 0, dy: 64), duration: 0.25);
        let fadeIn = SKAction.fadeIn(withDuration: 0.25);
        let fadeOut = SKAction.fadeOut(withDuration: 0.25);
        let sequence = SKAction.sequence([fadeIn, rise, fadeOut]);
        
        self.run(sequence) {
            completion();
        };
    }
    
    func destroy() {
        self.removeFromParent();
    }
}
