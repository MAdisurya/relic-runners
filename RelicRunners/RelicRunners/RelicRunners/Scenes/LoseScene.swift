//
//  LoseScene.swift
//  RelicRunners
//
//  Created by Mario Adisurya on 5/11/18.
//  Copyright © 2018 Mario Adisurya. All rights reserved.
//

import SpriteKit

class LoseScene: BaseScene {
    
    var playAgainButton: SKLabelNode!
    
    override func didMove(to view: SKView) {
        playAgainButton = self.childNode(withName: "play-again-button") as? SKLabelNode;
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!;
        let location = touch.location(in: self);
        let touchedNode = self.atPoint(location);
        
        if (touchedNode.name == playAgainButton.name) {
            if let newScene = SKScene(fileNamed: "GameScene") {
                newScene.scaleMode = .aspectFill;
                goToScene(scene: newScene);
            }
        }
    }
}
