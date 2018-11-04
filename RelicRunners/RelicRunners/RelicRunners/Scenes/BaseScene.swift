//
//  BaseScene.swift
//  RelicRunners
//
//  Created by Mario Adisurya on 5/11/18.
//  Copyright © 2018 Mario Adisurya. All rights reserved.
//

import SpriteKit

class BaseScene: SKScene {
    
    func goToScene(scene: SKScene) {
        let reveal = SKTransition.reveal(with: .left, duration: 1);
        
        self.view?.presentScene(scene, transition: reveal);
    }
}
