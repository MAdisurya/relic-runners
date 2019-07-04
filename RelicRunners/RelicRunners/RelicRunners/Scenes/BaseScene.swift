//
//  BaseScene.swift
//  RelicRunners
//
//  Created by Mario Adisurya on 5/11/18.
//  Copyright © 2018 Mario Adisurya. All rights reserved.
//

import SpriteKit

class BaseScene: SKScene
{
    override func didMove(to view: SKView)
    {
        super.didMove(to: view);
        
        RRGameManager.shared.getSceneManager().registerScene(_SceneName: self.name!, _Scene: self);
    }
}
