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
    private var maxMoveSpeed: CGFloat = 10;
    
    let defaultSpeed: CGFloat = 5;
    
    func getCameraSpeed() -> CGFloat {
        return moveSpeed;
    }
    
    func setCameraSpeed(speed: CGFloat) {
        if (moveSpeed < maxMoveSpeed) {
            moveSpeed = speed;
        }
    }
    
    func resetCameraSpeed() {
        moveSpeed = defaultSpeed;
    }
    
    func generateCamera(scene: SKScene) -> Void {
        // Generate the camera properties
        self.position = CGPoint(x: 0, y: 0);
        
        self.xScale = 1;
        self.yScale = 1;
    }
    
    func moveCamera() -> Void {
        self.position = CGPoint(x: self.position.x + moveSpeed, y: 0);
    }
}
