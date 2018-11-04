//
//  CameraManager.swift
//  RelicRunners
//
//  Created by Mario Adisurya on 29/10/18.
//  Copyright © 2018 Mario Adisurya. All rights reserved.
//

import SpriteKit

class Camera: SKCameraNode {
    
//    private var gameScene: SKScene!
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    init(scene: SKScene) {
//        super.init();
//
//        self.gameScene = scene;
//    }
    private let moveSpeed: CGFloat = 10;
    
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
