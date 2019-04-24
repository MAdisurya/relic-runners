//
//  RRBehaviour.swift
//  RelicRunners
//
//  Created by Mario Adisurya on 24/04/19.
//  Copyright © 2019 Mario Adisurya. All rights reserved.
//

import SpriteKit

class RRBehaviour: SKSpriteNode
{
    private var _id = 0;
    
    // Getters
    func getId() -> Int
    {
        return _id;
    }
    
    // Setters
    func setId(id: Int)
    {
        _id = id;
    }
    
    // Method that is called in update function of GameScene - called every frame
    func update(_ deltaTime: Double)
    {
        
    }
}


