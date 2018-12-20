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
        self.size = CGSize(width: 256, height: 256);
        self.zPosition = 1.0;
        self.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 64, height: 32));
        self.physicsBody?.isDynamic = false;
        self.physicsBody?.categoryBitMask = CategoryBitMask.obstacle;
        self.texture?.filteringMode = .nearest;
    }
    
    func destroy() {
        self.removeFromParent();
    }
}
