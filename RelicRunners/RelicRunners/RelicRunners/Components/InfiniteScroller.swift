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
    private var fgRocks: [BGSprite] = [];
    
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
    
    func getFGRocks() -> [BGSprite] {
        return fgRocks;
    }
    
    func generateBGSprites() -> Void {
        // Loop to generate bgs for infinite background scrolling
        for i in 0...2 {
            let bgFloor = BGSprite();
            let bgWall = BGSprite();
            let fgRock = BGSprite();
            
            bgFloor.generateBackground(scene: gameScene, imageNamed: "relicrunners-floor3", name: "bgfloor"+String(i));
            bgWall.generateBackground(scene: gameScene, imageNamed: "relicrunners-bgwall3", name: "bgwall"+String(i));
            fgRock.generateBackground(scene: gameScene, imageNamed: "relicrunners-front0", name: "frontwall"+String(i));
            
            // Set individual bg sizes
            bgFloor.size = CGSize(width: gameScene.size.width * 1.25, height: gameScene.size.width * 0.65);
            bgWall.size = CGSize(width: gameScene.size.width * 1.25, height: gameScene.size.width * 0.5);
            fgRock.size = CGSize(width: gameScene.size.width * 1.25, height: gameScene.size.width * 0.25);
            
            // Set individual bg positions
            bgFloor.position = CGPoint(x: (gameScene.size.width * CGFloat(i) * 1.25), y: -gameScene.size.width * 0.2);
            bgWall.position = CGPoint(x: (gameScene.size.width * CGFloat(i) * 1.25), y: gameScene.size.width / 3);
            fgRock.position = CGPoint(x: (gameScene.size.width * CGFloat(i) * 1.25), y: -gameScene.size.width * 0.35);
            bgFloor.zPosition = -1;
            fgRock.zPosition = 8;
            
            bgWall.texture?.filteringMode = .nearest;
            bgFloor.texture?.filteringMode = .nearest;
            fgRock.texture?.filteringMode = .nearest;
            
            bgFloors.append(bgFloor);
            bgWalls.append(bgWall);
            fgRocks.append(fgRock);
        }
    }
    
    func checkToMoveBG() -> Void {
        // Loop through each BG Sprite
        for i in 0...2 {
            // If BG Sprite position is outside the screen space then move BG Sprite to end
            if (bgFloors[i].position.x < (gameScene.camera?.position.x)! - (gameScene.size.width * 1.75)) {
                sectionIndex += 1;
                moveBGWall(wall: bgFloors[i], to: CGPoint(x: (gameScene.size.width * 1.25) * (sectionIndex+2), y: bgFloors[i].position.y));
                moveBGWall(wall: bgWalls[i], to: CGPoint(x: (gameScene.size.width * 1.25) * (sectionIndex+2), y: bgWalls[i].position.y));
                moveBGWall(wall: fgRocks[i], to: CGPoint(x: (gameScene.size.width * 1.25) * (sectionIndex+2), y: fgRocks[i].position.y));
            }
        }
    }
    
    func moveBGWall(wall: BGSprite, to location: CGPoint) -> Void {
        wall.position = location;
    }
}
