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
    
    private var bgFloors: [BGSprite] = [];
    private var bgWalls: [BGSprite] = [];
    private var fgWalls: [BGSprite] = [];
    
    // The 'section' or background currently being shown in the screen space
    private var sectionIndex: CGFloat = 0;
    
    init(scene: SKScene) {
        self.gameScene = scene;
    }
    
    func getBGFloors() -> [BGSprite] {
        return bgFloors;
    }
    
    func getBGWalls() -> [BGSprite] {
        return bgWalls;
    }
    
    func getFGWalls() -> [BGSprite] {
        return fgWalls;
    }
    
    func generateBGSprites() -> Void {
        // Loop to generate bgs for infinite background scrolling
        for i in 0...2 {
            let bgFloor = BGSprite();
            let bgWall = BGSprite();
            let fgWall = BGSprite();
            
            bgFloor.generateBackground(scene: gameScene, imageNamed: "relicrunners-floor", name: "bgfloor"+String(i));
            bgWall.generateBackground(scene: gameScene, imageNamed: "relicrunners-bgwall3", name: "bgwall"+String(i));
            fgWall.generateBackground(scene: gameScene, imageNamed: "relicrunners-front0", name: "fgwall"+String(i));
            
            // Set individual bg sizes
            bgFloor.size = CGSize(width: 1024, height: 576);
            bgWall.size = CGSize(width: 1024, height: 384);
//            bgWall.size = CGSize(width: 768, height: 320);
            fgWall.size = CGSize(width: 1024, height: 320);
            
            // Set individual bg positions
            bgFloor.position = CGPoint(x: (1024 * CGFloat(i)), y: -160);
            bgWall.position = CGPoint(x: (1024 * CGFloat(i)), y: 288);
            fgWall.position = CGPoint(x: (1024 * CGFloat(i)), y: -320);
            bgFloor.zPosition = -1;
            fgWall.zPosition = 8;
            
            bgWall.texture?.filteringMode = .nearest;
            bgFloor.texture?.filteringMode = .nearest;
            fgWall.texture?.filteringMode = .nearest;
            
            bgFloors.append(bgFloor);
            bgWalls.append(bgWall);
            fgWalls.append(fgWall);
        }
    }
    
    func checkToMoveBG() -> Void {
        // Loop through each BG Sprite
        for i in 0...2 {
            // If BG Sprite position is outside the screen space then move BG Sprite to end
            if (bgFloors[i].position.x < (gameScene.camera?.position.x)! - (gameScene.size.width * 1.5)) {
                sectionIndex += 1;
                moveBGWall(wall: bgFloors[i], to: CGPoint(x: gameScene.size.width * (sectionIndex+2), y: bgFloors[i].position.y));
                moveBGWall(wall: bgWalls[i], to: CGPoint(x: gameScene.size.width * (sectionIndex+2), y: bgWalls[i].position.y));
                moveBGWall(wall: fgWalls[i], to: CGPoint(x: gameScene.size.width * (sectionIndex+2), y: fgWalls[i].position.y));
            }
        }
    }
    
    func moveBGWall(wall: BGSprite, to location: CGPoint) -> Void {
        wall.position = location;
    }
}
