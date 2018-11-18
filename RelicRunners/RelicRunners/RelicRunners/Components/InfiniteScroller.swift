//
//  InfiniteScroller.swift
//  RelicRunners
//
//  Created by Mario Adisurya on 29/10/18.
//  Copyright © 2018 Mario Adisurya. All rights reserved.
//

import SpriteKit

class InfiniteScroller {
    
    private var gameScene: SKScene!;
    
    private var bgWalls: [BGSprite] = [];
    
    // The 'section' or background currently being shown in the screen space
    private var sectionIndex: CGFloat = 0;
    
    init(scene: SKScene) {
        self.gameScene = scene;
    }
    
    func getBGWalls() -> [BGSprite] {
        return bgWalls;
    }
    
    func generateBGSprites() -> Void {
        // Loop to generate 3 BGSprites for infinite background scrolling
        for i in 0...2 {
            let bgSprite = BGSprite();
            bgSprite.generateBackground(scene: gameScene, imageNamed: "background", name: "bg"+String(i));
            
            // Set individual bgSprite positions
            bgSprite.position = CGPoint(x: gameScene.size.width * CGFloat(i), y: 0);
            
            bgWalls.append(bgSprite);
        }
    }
    
    func checkToMoveBG() -> Void {
        // Loop through each BG Sprite
        for bgSprite in bgWalls {
            // If BG Sprite position is outside the screen space then move BG Sprite to end
            if (bgSprite.position.x < (gameScene.camera?.position.x)! - gameScene.size.width) {
                sectionIndex += 1;
                moveBGWall(wall: bgSprite, to: CGPoint(x: gameScene.size.width * (sectionIndex+2), y: 0));
            }
        }
    }
    
    func moveBGWall(wall: BGSprite, to location: CGPoint) -> Void {
        wall.position = location;
    }
}
