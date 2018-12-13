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
    private lazy var m_MenuUI = MenuUI(player: m_Player);
    
    private let gameCamera = Camera();
    private let m_Spawner = Spawner();
    private let m_Player = Player(type: .player);
    private let m_Boss = Boss(type: .enemy);
    
    private let m_ScoreLabel = SKLabelNode();
    private let m_GoldLabel = SKLabelNode();
    
    // Getters
    func getSpawner() -> Spawner {
        return m_Spawner;
    }
    
    override func sceneDidLoad() {
        // Generate the camera and add to scene
        gameCamera.generateCamera(scene: self);
        self.addChild(gameCamera);
        
        // Set internal camera to new gameCamera
        self.camera = gameCamera;
        
        // Generate the Background
        infiniteScroller.generateBGSprites();
        // Add the bgs to the scene
        for bgWall in infiniteScroller.getBGWalls() {
            self.addChild(bgWall);
        }
        for bgFloor in infiniteScroller.getBGFloors() {
            self.addChild(bgFloor);
        }
        for fgRock in infiniteScroller.getFGRocks() {
            self.addChild(fgRock);
        }
        
        // Generate the MenuUI elements
        m_MenuUI.generateTitle(sceneSize: self.size);
        m_MenuUI.generateTapLabel(sceneSize: self.size);
        // Add MenuUI elements to the camera
        gameCamera.addChild(m_MenuUI.m_Title);
        gameCamera.addChild(m_MenuUI.m_TapLabel);
        
        // Generate the enemy and obstacle spawner
        m_Spawner.generateSpawner(scene: self);
        // Add Spawner to the scene
        self.addChild(m_Spawner);
        
        // Generate the player character
        m_Player.generateCharacter(scene: self, imageNamed: "archer");
        m_Player.position.x = -self.size.width;
        // Add the player character to the scene
//        gameCamera.addChild(m_Player);
        
        // Generate the boss
        m_Boss.generateCharacter(scene: self, imageNamed: "skeleton");
        
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
        
        // Setup the score label
//        m_ScoreLabel.zPosition = 10.0;
//        m_ScoreLabel.text = String(RRGameManager.shared.getScoreManager().retrieveScore());
//        m_ScoreLabel.fontName = "Silkscreen Bold";
//        m_ScoreLabel.fontSize = 96;
//        m_ScoreLabel.position = CGPoint(x: 0, y: -m_ScoreLabel.fontSize / 4);
//        gameCamera.addChild(m_ScoreLabel);
        
        // Setup the gold label
        RRGameManager.shared.getScoreManager().addGold(amount: RRGameManager.shared.getScoreManager().retrieveGold());
        m_GoldLabel.zPosition = 10.0;
        m_GoldLabel.text = String(RRGameManager.shared.getScoreManager().retrieveGold());
        m_GoldLabel.fontName = "Silkscreen Bold";
        m_GoldLabel.fontSize = 64;
        m_GoldLabel.fontColor = UIColor.yellow;
        m_GoldLabel.position = CGPoint(x: self.size.width / 3, y: self.size.width / 5);
        gameCamera.addChild(m_GoldLabel);
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        // Move the camera every frame
        gameCamera.moveCamera();
        // Check to move BG Wall
        if (gameCamera.position.x >= gameCamera.position.x - self.size.width) {
            infiniteScroller.checkToMoveBG();
        }
        
        // Check if should add to score
        if let point = self.childNode(withName: "point") {
            // Check if player has passed the point
            if (gameCamera.position.x - (self.size.width / 3) > point.position.x) {
                // Increase camera speed after score is increased
                gameCamera.setCameraSpeed(speed: gameCamera.getCameraSpeed() + (CGFloat(RRGameManager.shared.getScoreManager().getScore()) * 0.1))
                // Remove point from game scene
                point.removeFromParent();
            }
        }
        
        // Update spawner position every frame to follow camera
        m_Spawner.position.x = gameCamera.position.x + (self.size.height / 2);
        // Spawn enemies, obstacles, points, bosses
        if (RRGameManager.shared.getGameState() == .PLAY) {
            m_Spawner.spawn();
            m_Spawner.spawnBoss(boss: m_Boss);
        }
        
        RRGameManager.shared.getGarbageCollector().garbageCollection(scene: self, camera: gameCamera);
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if (contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask == CategoryBitMask.player | CategoryBitMask.enemy) {
            RRGameManager.shared.getEventManager().broadcastEvent(event: "playerHit");
        }
        if (contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask == CategoryBitMask.player | CategoryBitMask.obstacle) {
            RRGameManager.shared.getEventManager().broadcastEvent(event: "playerHit");
        }
        if (contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask == CategoryBitMask.player | CategoryBitMask.boss) {
            RRGameManager.shared.getEventManager().broadcastEvent(event: "playerHit");
        }
        if (contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask == CategoryBitMask.weapon | CategoryBitMask.enemy) {
            RRGameManager.shared.getEventManager().broadcastEvent(event: "enemyHit");
            RRGameManager.shared.getEventManager().broadcastEvent(event: "weaponDestroyed");
        }
        if (contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask == CategoryBitMask.weapon | CategoryBitMask.boss) {
            RRGameManager.shared.getEventManager().broadcastEvent(event: "bossHit");
            RRGameManager.shared.getEventManager().broadcastEvent(event: "weaponDestroyed");
        }
        if (contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask == CategoryBitMask.player | CategoryBitMask.powerUp)
        {
            if var powerUp = contact.bodyB.node as? PowerUpDrop {
                RRGameManager.shared.getEventManager().broadcastEvent(event: &powerUp);
                powerUp.destroy();
            }
        }
    }
    
    func updateScoreLabel(score: String) {
        // Set score label to score
        m_ScoreLabel.text = score;
    }
    
    func updateGoldLabel(gold: String) {
        // Set gold label to gold
        m_GoldLabel.text = gold;
    }
    
    func listen(event: String) {
        if (event == "gameOver") {
            // Set game state to pause
            RRGameManager.shared.setGameState(state: .PAUSE);
            // Store persistant values
            RRGameManager.shared.getScoreManager().storeScore();
            RRGameManager.shared.getScoreManager().storeGold();
            // Set game camera speed back to default
            gameCamera.resetCameraSpeed();
            // Add UI back to the game camera
            gameCamera.addChild(m_MenuUI.m_Title);
            gameCamera.addChild(m_MenuUI.m_TapLabel);
            
            // Despawn boss if boss is spawned and not dead
            if (!m_Boss.m_Dead && m_Spawner.isBossSpawned()) {
                m_Boss.animateOutRight() {
                    // Remove boss from game scene
                    self.m_Boss.destroy();
                    self.m_Spawner.setBossSpawned(spawned: false);
                };
            }
            
            m_MenuUI.animateIn() {
                RRGameManager.shared.getGarbageCollector().destroyAll();
                self.m_MenuUI.blink(node: self.m_MenuUI.m_TapLabel);
            };
        }
    }
    
    func listen<T>(event: inout T) {
        
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
