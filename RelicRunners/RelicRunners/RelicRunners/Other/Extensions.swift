//
//  Extensions.swift
//  RelicRunners
//
//  Created by Mario Adisurya on 17/12/18.
//  Copyright © 2018 Mario Adisurya. All rights reserved.
//

import SpriteKit

extension SKAction {
    class func shake(duration: CGFloat, ampX: Int = 25, ampY: Int = 25) -> SKAction {
        let numOfShakes = (duration / 0.015) / 2;
        var actionsArray: [SKAction] = [];
        
        for _ in 1...Int(numOfShakes) {
            let dx = CGFloat(arc4random_uniform(UInt32(ampX))) - CGFloat(ampX / 2);
            let dy = CGFloat(arc4random_uniform(UInt32(ampY))) - CGFloat(ampY / 2);
            let forward = SKAction.moveBy(x: dx, y: dy, duration: 0.015);
            let reverse = forward.reversed();
            actionsArray.append(forward);
            actionsArray.append(reverse);
        }
        
        return SKAction.sequence(actionsArray);
    }
}
