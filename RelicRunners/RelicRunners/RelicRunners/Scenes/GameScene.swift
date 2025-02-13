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
    private lazy var m_MenuUI = MenuUI(gameScene: self);
    
    private let gameCamera = Camera();
    private let m_Spawner = Spawner();
    private let m_Player = Player(type: .player);
    private let m_Boss = Mechazoid(type: .enemy);
    
    private let m_HealthBar = HealthBar();
    private let m_ScoreLabel = SKLabelNode();
    private let m_GoldLabel = SKLabelNode();
    private let m_PauseButton = SKSpriteNode();
    
    private let m_PauseOverlay = PauseOverlay();
    private let m_PlayOverlay = RROverlay();
    
    private var m_MoveAmount: CGFloat = 160;
    
    private var m_StartTime: Double = 0; // Used for deducting from current time - custom timer
    
    // Getters
    func getSpawner() -> Spawner {
        return m_Spawner;
    }
    
    func getPlayer() -> Player {
        return m_Player;
    }
    
    func getCamera() -> Camera {
        return gameCamera;
    }
    
    func getHealthBar() -> HealthBar {
        return m_HealthBar;
    }
    
    func getMoveAmount() -> CGFloat {
        return m_MoveAmount;
    }
    
    func loadScene() {
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
        for fgWall in infiniteScroller.getFGWalls() {
            self.addChild(fgWall);
        }
        
        // Generate the MenuUI elements
        m_MenuUI.generateTitle(sceneSize: self.size);
        m_MenuUI.generateTapLabel(sceneSize: self.size);
        // Add MenuUI elements to the camera
        gameCamera.addChild(m_MenuUI);
        
        // Generate the HealthBar
        m_HealthBar.generate(position: CGPoint(x: -432, y: 224), health: m_Player.m_Health);
        
        // Generate Pause Button
        m_PauseButton.position = CGPoint(x: 0, y: 224);
        m_PauseButton.zPosition = 10;
        m_PauseButton.size = CGSize(width: 64, height: 64);
        m_PauseButton.texture = SKTexture(imageNamed: "pause-button");
        m_PauseButton.name = "pause-button";
        
        // Overlays
        m_PauseOverlay.generate(name: "pause-overlay", zPos: 12, color: UIColor.black);
        m_PlayOverlay.generate(name: "play-overlay", zPos: 9);
        
        m_PauseOverlay.alpha = 0.4;
        
        gameCamera.addChild(m_PlayOverlay);
        
        // Generate the enemy and obstacle spawner
        m_Spawner.generateSpawner(scene: self);
        // Add Spawner to the scene
        self.addChild(m_Spawner);
        
        // Generate the player character
        m_Player.generateCharacter(scene: self, imageNamed: "archer", enemyName: "player");
        m_Player.position.x = -self.size.width;
        
        // Generate the boss
        m_Boss.generateCharacter(scene: self, imageNamed: "skeleton", enemyName: "mechazoid");
        
        self.physicsWorld.contactDelegate = self;
        
        RRGameManager.shared.getEventManager().registerEventListener(listener: self);
    }
    
    override func didMove(to view: SKView) {
        loadScene();
        // Setup Gesture Recognizers
        if let view = self.view {
            RRGameManager.shared.getInputManager().setupTapGesture(view: view, scene: self, action: #selector(tap));
            RRGameManager.shared.getInputManager().setupSwipeDownGesture(view: view, scene: self, action: #selector(swipeDown));
            RRGameManager.shared.getInputManager().setupSwipeUpGesture(view: view, scene: self, action: #selector(swipeUp))
        }
        
        // Setup Music
        RRGameManager.shared.getSoundManager().playBackgroundMusic(name: "robot.wav");
        self.addChild(RRGameManager.shared.getSoundManager().getAudioNode());
        
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
        m_Spawner.position.x = gameCamera.position.x + self.size.width;
        // Spawn enemies, obstacles, points, bosses
        if (RRGameManager.shared.getGameState() == .PLAY) {
            m_Spawner.spawn();
            m_Spawner.spawnBoss(boss: m_Boss);
            m_Boss.attack();
            
            // Spikes
//            for spike in m_Spawner.getSpikeManager() {
//                spike.open();
//                spike.close();
//            }
        }
        
        for b in RRGameManager.shared.getBehaviours()
        {
            b.update(currentTime - m_StartTime); // current - start to find out delta time
        }
        
        RRGameManager.shared.getGarbageCollector().garbageCollection(scene: self, camera: gameCamera);
        
        m_StartTime = currentTime;
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
            
            if var enemy = contact.bodyA.node as? Character {
                RRGameManager.shared.getEventManager().broadcastEvent(event: &enemy);
            }
            
            if var enemy = contact.bodyB.node as? Character {
                RRGameManager.shared.getEventManager().broadcastEvent(event: &enemy);
            }
            
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!;
        let location = touch.location(in: self);
        let touchedNode = self.atPoint(location);
        
        if let button = touchedNode as? MenuButton {
            button.openWindow();
            
            return;
        }
        
        if var button = touchedNode as? CloseButton {
            RRGameManager.shared.getEventManager().broadcastEvent(event: &button);
            
            return;
        }
        
        if let itemSlot = touchedNode as? ItemSlot {
            itemSlot.equip();
            
            return;
        }
        
        if (touchedNode.name == "pause-button") {
            // If pause button is tapped, pause the game
            RRGameManager.shared.getEventManager().broadcastEvent(event: "pauseGame");
            return;
        }
        
        if (touchedNode.name == "back-to-menu") {
            // If back to menu button is tapped, then end game and go back to menu
            // Unpause game
            RRGameManager.shared.getEventManager().broadcastEvent(event: "playGame");
            // Kill player to reset game
            m_Player.die();
            
            return;
        }
        
        if (touchedNode.name == "pause-overlay") {
            RRGameManager.shared.getEventManager().broadcastEvent(event: "playGame");
            return;
        }
        
        if (touchedNode.name == "play-overlay") {
            // Only broadcast tap event if menu window is closed
            RRGameManager.shared.getEventManager().broadcastEvent(event: "menuTap");
            m_PlayOverlay.removeFromParent();
            
            if (RRGameManager.shared.getGameState() == .END) {
                gameCamera.addChild(m_PauseButton);
                gameCamera.addChild(m_HealthBar);
            }
            
            return;
        }
    }
    
    func listen(event: String) {
        if (event == "gameOver") {
            // Set game state to pause
            RRGameManager.shared.setGameState(state: .END);
            // Store persistant values
            RRGameManager.shared.getScoreManager().storeScore();
            RRGameManager.shared.getScoreManager().storeGold();
            // Set game camera speed back to default
            gameCamera.resetCameraSpeed();
            // Add UI back to the game camera
            gameCamera.addChild(m_MenuUI.m_Title);
            gameCamera.addChild(m_MenuUI.m_TapLabel);
            gameCamera.addChild(m_PlayOverlay);
            // Remove Pause button from UI
            m_PauseButton.removeFromParent();
            // Remove health bar from UI
            m_HealthBar.removeFromParent();
            
            // Despawn boss if boss is spawned and not dead
            if (!m_Boss.m_Dead && m_Spawner.isBossSpawned()) {
                // Reset all boss weapons
                RRGameManager.shared.getEventManager().broadcastEvent(event: "resetBossWeapons");
                m_Boss.animateOutRight() {
                    // Remove boss from game scene
                    self.m_Boss.m_State = .HIDING;
                    self.m_Boss.resetPhase();
                    self.m_Boss.destroy();
                    self.m_Spawner.setBossSpawned(spawned: false);
                };
            }
            
            m_MenuUI.animateIn() {
                RRGameManager.shared.getGarbageCollector().destroyAll();
                self.m_MenuUI.blink(node: self.m_MenuUI.m_TapLabel);
            };
        }
        
        if (event == "pauseGame") {
            let wait = SKAction.wait(forDuration: 0.01);
            
            // Set game state to pause
            RRGameManager.shared.setGameState(state: .PAUSE);
            RRGameManager.shared.getSoundManager().pause();
            gameCamera.addChild(m_PauseOverlay);
            // Pause the game
            self.run(wait) {
                self.view?.isPaused = true;
            }
        }
        
        if (event == "playGame") {
            // Set game state to play
            RRGameManager.shared.setGameState(state: .PLAY);
            RRGameManager.shared.getSoundManager().play();
            // Unpause the game
            self.view?.isPaused = false;
            
            m_PauseOverlay.removeFromParent();
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
