//
//  GameScene.swift
//  RelicRunners
//
//  Created by Mario Adisurya on 29/10/18.
//  Copyright © 2018 Mario Adisurya. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: BaseScene, SKPhysicsContactDelegate, RREventListener {
    
    private lazy var infiniteScroller = InfiniteScroller(scene: self);
    
    private let gameCamera = Camera();
    private let m_Spawner = Spawner();
    private let m_Player = Character(type: .player);
    
    override func sceneDidLoad() {
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
        
        // Generate the enemy and obstacle spawner
        m_Spawner.generateSpawner(scene: self);
        // Add Spawner to the scene
        self.addChild(m_Spawner);
        
        // Generate the player character
        m_Player.generateCharacter(scene: self, imageNamed: "archer");
        // Add the player character to the scene
        gameCamera.addChild(m_Player);
        
        self.physicsWorld.contactDelegate = self;
        
        RRGameManager.shared.getEventManager().registerEventListener(listener: self);
    }
    
    override func didMove(to view: SKView) {
        // Setup Gesture Recognizers
        if let view = self.view {
            RRGameManager.shared.getInputManager().setupTapGesture(view: view, scene: self, action: #selector(tap));
            RRGameManager.shared.getInputManager().setupSwipeDownGesture(view: view, scene: self, action: #selector(swipeDown));
            RRGameManager.shared.getInputManager().setupSwipeUpGesture(view: view, scene: self, action: #selector(swipeUp))
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        gameCamera.moveCamera();
        // Check to move BG Wall
        if (gameCamera.position.x >= gameCamera.position.x - self.size.width) {
            infiniteScroller.checkToMoveBG();
        }
        
        // Update spawner position every frame to follow camera;
        m_Spawner.position.x = gameCamera.position.x + (self.size.height / 2);
        // Spawn enemies
        m_Spawner.spawnEnemy();
        
        RRGameManager.shared.getEnemyManager().garbageCollection(scene: self, camera: gameCamera);
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if (contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask == CategoryBitMask.player | CategoryBitMask.enemy) {
            RRGameManager.shared.getEventManager().broadcastEvent(event: "playerDestroyed");
        }
        if (contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask == CategoryBitMask.player | CategoryBitMask.obstacle) {
            RRGameManager.shared.getEventManager().broadcastEvent(event: "playerDestroyed");
        }
        if (contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask == CategoryBitMask.projectile | CategoryBitMask.enemy) {
            RRGameManager.shared.getEventManager().broadcastEvent(event: "enemyDestroyed");
            RRGameManager.shared.getEventManager().broadcastEvent(event: "projectileDestroyed");
        }
    }
    
    func listen(event: String) {
        if (event == "gameOver") {
            if let nextScene = SKScene(fileNamed: "LoseScene") {
                nextScene.scaleMode = .aspectFill;
                goToScene(scene: nextScene);
            }
        }
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
