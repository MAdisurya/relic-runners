//
//  MainMenuScene.swift
//  RelicRunners
//
//  Created by Mario Adisurya on 29/10/18.
//  Copyright © 2018 Mario Adisurya. All rights reserved.
//

import SpriteKit

class MainMenuScene: BaseScene {
    
    var playButton: SKLabelNode!;
    
    override func didMove(to view: SKView) {
        playButton = self.childNode(withName: "play-button") as? SKLabelNode;
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!;
        let location = touch.location(in: self);
        let touchedNode = self.atPoint(location);
        
        if (touchedNode.name == playButton.name) {
            if let newScene = SKScene(fileNamed: "GameScene") {
                newScene.scaleMode = .aspectFill;
//                goToScene(scene: newScene);
            }
        }
    }
}
