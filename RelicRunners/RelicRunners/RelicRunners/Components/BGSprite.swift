//
//  Background.swift
//  RelicRunners
//
//  Created by Mario Adisurya on 29/10/18.
//  Copyright © 2018 Mario Adisurya. All rights reserved.
//

import SpriteKit

class BGSprite: SKSpriteNode {
    
    func generateBackground(scene: SKScene, imageNamed image: String, name: String) -> Void {
        self.name = name;
        self.texture = SKTexture(imageNamed: image);
    }
}
