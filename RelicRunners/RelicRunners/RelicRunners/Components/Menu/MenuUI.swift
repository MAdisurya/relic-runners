//
//  MenuUI.swift
//  RelicRunners
//
//  Created by Mario Adisurya on 21/11/18.
//  Copyright © 2018 Mario Adisurya. All rights reserved.
//

import SpriteKit

class MenuUI: SKNode, RREventListener {
    
    private var gameScene: GameScene!;
    
    let m_Title = SKSpriteNode();
    let m_TapLabel = SKLabelNode();
    
    var m_SettingsButton: MenuButton!;
    
    private var allowedToTap = true;
    
    init(gameScene: GameScene) {
        super.init();
        
        self.position = CGPoint(x: 0, y: 0);
        
        self.gameScene = gameScene;
        // Initialize menu buttons
        self.m_SettingsButton = MenuButton(image: "coin-tails", windowSize: gameScene.size, name: "settings-button");
        // Set menu buttons positions
        self.m_SettingsButton.position = CGPoint(x: -gameScene.size.width * 0.4, y: gameScene.size.width / 4);
        
        // Add components to Menu UI
        self.addChild(m_Title);
        self.addChild(m_TapLabel);
        self.addChild(m_SettingsButton);
        
        RRGameManager.shared.getEventManager().registerEventListener(listener: self);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented");
    }
    
    func generateTitle(sceneSize: CGSize) {
        m_Title.position = CGPoint(x: 0, y: sceneSize.width / 5);
        m_Title.zPosition = 10.0;
        m_Title.size = CGSize(width: sceneSize.width / 3, height: sceneSize.width / 8);
        m_Title.texture = SKTexture(imageNamed: "relicrunners-title");
    }
    
    func generateTapLabel(sceneSize: CGSize) {
        m_TapLabel.zPosition = 10.0;
        m_TapLabel.text = "Tap to Start";
        m_TapLabel.fontName = "Silkscreen";
        m_TapLabel.fontSize = 36;
        m_TapLabel.position = CGPoint(x: 0, y: -m_TapLabel.fontSize / 2);
        
        blink(node: m_TapLabel);
    }
    
    func blink(node: SKNode) {
        let fadeOut = SKAction.fadeOut(withDuration: 0.01);
        let wait = SKAction.wait(forDuration: 1);
        let fadeIn = SKAction.fadeIn(withDuration: 0.01);
        let sequence = SKAction.sequence([wait, fadeOut, wait, fadeIn]);
        let repeatForever = SKAction.repeatForever(sequence);
        
        node.run(repeatForever);
    }
    
    func animateIn(completion: @escaping () -> Void) {
        let upAnim = SKAction.move(by: CGVector(dx: 0, dy: m_Title.size.width * 2), duration: 1);
        let downAnim = SKAction.move(by: CGVector(dx: 0, dy: -m_Title.size.width * 2), duration: 1);
        
        m_Title.removeAllActions();
        m_TapLabel.removeAllActions();
        m_Title.run(downAnim);
        m_TapLabel.run(upAnim) {
            completion();
        };
    }
    
    func animateOut(completion: @escaping () -> Void) {
        let upAnim = SKAction.move(by: CGVector(dx: 0, dy: m_Title.size.width * 2), duration: 1);
//        let downAnim = SKAction.move(by: CGVector(dx: 0, dy: -m_Title.size.width * 2), duration: 1);
        let fadeOut = SKAction.fadeOut(withDuration: 0.01);
        
        m_Title.removeAllActions();
        m_TapLabel.removeAllActions();
        m_TapLabel.run(fadeOut);
        m_SettingsButton.run(upAnim);
        m_Title.run(upAnim) {
            completion();
        };
    }
    
    func listen(event: String) {
        if (event == "tap") {
            if (RRGameManager.shared.getGameState() == .PAUSE && allowedToTap) {
                // Reset Player and animate in
                gameScene.getPlayer().reset();
                gameScene.getPlayer().animateInFromLeft();
                
                // Reset Health Bar
                gameScene.getHealthBar().reset();
                
                // Reset the score
                RRGameManager.shared.getScoreManager().resetScore();
                self.gameScene.updateScoreLabel(score: String(RRGameManager.shared.getScoreManager().getScore()));
                
                // Disable taps
                allowedToTap = false;
                
                animateOut() {
                    RRGameManager.shared.setGameState(state: .PLAY);
                    self.allowedToTap = true;
                    self.m_Title.removeFromParent();
                    self.m_TapLabel.removeFromParent();
                };
            }
        }
    }
    
    func listen<T>(event: inout T) {
        
    }
}
