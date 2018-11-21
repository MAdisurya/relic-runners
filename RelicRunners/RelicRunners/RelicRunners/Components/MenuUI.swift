//
//  MenuUI.swift
//  RelicRunners
//
//  Created by Mario Adisurya on 21/11/18.
//  Copyright © 2018 Mario Adisurya. All rights reserved.
//

import SpriteKit

class MenuUI: RREventListener {
    
    let m_Title = SKSpriteNode();
    let m_TapLabel = SKLabelNode();
    
    init() {
        RRGameManager.shared.getEventManager().registerEventListener(listener: self);
    }
    
    func generateTitle(sceneSize: CGSize) {
        m_Title.position = CGPoint(x: 0, y: sceneSize.width / 5);
        m_Title.zPosition = 10.0;
        m_Title.size = CGSize(width: sceneSize.width / 3, height: sceneSize.width / 8);
        m_Title.texture = SKTexture(imageNamed: "relicrunners-title");
    }
    
    func generateTapLabel(sceneSize: CGSize) {
        m_TapLabel.position = CGPoint(x: 0, y: -sceneSize.width / 4);
        m_TapLabel.zPosition = 10.0;
        m_TapLabel.text = "Tap to Start";
        m_TapLabel.fontName = "Silkscreen";
        m_TapLabel.fontSize = 36;
        
        let fadeOut = SKAction.fadeOut(withDuration: 0.01);
        let wait = SKAction.wait(forDuration: 1);
        let fadeIn = SKAction.fadeIn(withDuration: 0.01);
        let sequence = SKAction.sequence([fadeOut, wait, fadeIn, wait]);
        let repeatForever = SKAction.repeatForever(sequence);
        
        m_TapLabel.run(repeatForever);
    }
    
    func listen(event: String) {
        if (event == "tap") {
            if (RRGameManager.shared.getGameState() == .PAUSE) {
                let upAnim = SKAction.move(by: CGVector(dx: 0, dy: m_Title.size.width * 2), duration: 1);
                let downAnim = SKAction.move(by: CGVector(dx: 0, dy: -m_Title.size.width * 2), duration: 1);
                
                m_Title.removeAllActions();
                m_TapLabel.removeAllActions();
                m_Title.run(upAnim);
                m_TapLabel.run(downAnim) {
                    RRGameManager.shared.setGameState(state: .PLAY);
                };
            }
        }
    }
}
