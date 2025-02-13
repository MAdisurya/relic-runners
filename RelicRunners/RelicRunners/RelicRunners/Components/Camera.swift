//
//  CameraManager.swift
//  RelicRunners
//
//  Created by Mario Adisurya on 29/10/18.
//  Copyright © 2018 Mario Adisurya. All rights reserved.
//

import SpriteKit

class Camera: SKCameraNode {
    
    private var moveSpeed: CGFloat = 5;
    private var heldMoveSpeed: CGFloat = 0;
    private var maxMoveSpeed: CGFloat = 10;
    
    let defaultSpeed: CGFloat = 5;
    
    // Getters
    func getCameraSpeed() -> CGFloat {
        return moveSpeed;
    }
    
    func getHeldMoveSpeed() -> CGFloat {
        return heldMoveSpeed;
    }
    
    // Setters
    func setCameraSpeed(speed: CGFloat) {
        if (moveSpeed < maxMoveSpeed) {
            moveSpeed = speed;
            heldMoveSpeed = speed;
        }
    }
    
    func resetCameraSpeed() {
        moveSpeed = defaultSpeed;
    }
    
    func generateCamera(scene: SKScene) -> Void {
        // Generate the camera properties
        self.position = CGPoint(x: 256, y: 0);
        
        self.xScale = 1.25;
        self.yScale = 1.25;
    }
    
    func moveCamera() -> Void {
        self.position = CGPoint(x: self.position.x + moveSpeed, y: 0);
    }
    
    func stopCamera() -> Void {
        moveSpeed = 0;
    }
    
    func shake(forDuration duration: CGFloat) {
        let shake = SKAction.shake(duration: duration, ampX: 70, ampY: 70);
        self.run(shake);
        
        for child in self.children {
            child.run(shake);
        }
    }
}
