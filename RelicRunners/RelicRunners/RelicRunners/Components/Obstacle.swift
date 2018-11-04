//
//  Obstacle.swift
//  RelicRunners
//
//  Created by Mario Adisurya on 5/11/18.
//  Copyright © 2018 Mario Adisurya. All rights reserved.
//

import SpriteKit

class Obstacle: SKSpriteNode {
    
    func generateObstacle(scene: SKScene, imageNamed image: String) {
        self.texture = SKTexture(imageNamed: image);
        self.size = CGSize(width: scene.size.width / 7, height: scene.size.width / 7);
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size);
        self.physicsBody?.isDynamic = false;
        self.physicsBody?.categoryBitMask = CategoryBitMask.obstacle;
    }
    
    func destroy() {
        self.removeFromParent();
    }
}
