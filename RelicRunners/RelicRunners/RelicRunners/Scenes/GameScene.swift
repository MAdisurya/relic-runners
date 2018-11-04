//
//  GameScene.swift
//  RelicRunners
//
//  Created by Mario Adisurya on 29/10/18.
//  Copyright © 2018 Mario Adisurya. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private let gameCamera = Camera();
    private lazy var infiniteScroller = InfiniteScroller(scene: self);
    
    let m_Player = Character(type: .player);
    
    override func didMove(to view: SKView) {
        // Setup Gesture Recognizers
        if let view = self.view {
            RRGameManager.shared.getInputManager().setupTapGesture(view: view, scene: self, action: #selector(tap));
            RRGameManager.shared.getInputManager().setupSwipeDownGesture(view: view, scene: self, action: #selector(swipeDown));
            RRGameManager.shared.getInputManager().setupSwipeUpGesture(view: view, scene: self, action: #selector(swipeUp))
        }
        
        // Generate the camera and add to scene
        gameCamera.generateCamera(scene: self);
        self.addChild(gameCamera);
        
        // Set internal camera to new gameCamera
        self.camera = gameCamera;
        
        // Generate the Background
        infiniteScroller.generateBGSprites();
        // Add the BG walls to the scene
        for bgWall in infiniteScroller.getBGWalls() {
            self.addChild(bgWall);
        }
        
        m_Player.generateCharacter(scene: self, imageNamed: "happy-icon");
        self.addChild(m_Player);
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        gameCamera.moveCamera();
        // Check to move BG Wall
        if (gameCamera.position.x >= gameCamera.position.x - self.size.width) {
            infiniteScroller.checkToMoveBG();
        }
        
        // Set player to follow the camera every frame
        m_Player.position.x = gameCamera.position.x - (size.width / 3);
    }
    
    @objc func tap(sender: UITapGestureRecognizer) {
        RRGameManager.shared.getEventManager().broadcastEvent(event: "tap");
    }
    
    @objc func swipeDown(sender: UISwipeGestureRecognizer) {
        RRGameManager.shared.getEventManager().broadcastEvent(event: "swipeDown");
    }
    
    @objc func swipeUp(sender: UISwipeGestureRecognizer) {
        RRGameManager.shared.getEventManager().broadcastEvent(event: "swipeUp");
    }
}
