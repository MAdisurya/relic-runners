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
    override init()
    {
        super.init();

        RRGameManager.shared.getSceneManager().registerScene(_SceneName: self.name!, _Scene: self);
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }
    
    //    func goToScene(scene: SKScene) {
    //        let reveal = SKTransition.reveal(with: .left, duration: 1);
    //
    //        self.view?.presentScene(scene, transition: reveal);
    //    }
}
