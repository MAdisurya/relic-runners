//
//  InputManager.swift
//  RelicRunners
//
//  Created by Mario Adisurya on 3/11/18.
//  Copyright © 2018 Mario Adisurya. All rights reserved.
//

import Foundation
import GameplayKit

class RRInputManager {
    
    private var tapGestureRecognizer = UITapGestureRecognizer();
    private var swipeDownGestureRecognizer = UISwipeGestureRecognizer();
    private var swipeUpGestureRecognizer = UISwipeGestureRecognizer();
    
    func setupTapGesture(view: SKView, scene: SKScene, action: Selector) {
        tapGestureRecognizer = UITapGestureRecognizer(target: scene, action: action);
        tapGestureRecognizer.numberOfTapsRequired = 1;
        view.addGestureRecognizer(tapGestureRecognizer);
    }
    
    func setupSwipeDownGesture(view: SKView, scene: SKScene, action: Selector) {
        swipeDownGestureRecognizer = UISwipeGestureRecognizer(target: scene, action: action);
        swipeDownGestureRecognizer.direction = .down;
        swipeDownGestureRecognizer.numberOfTouchesRequired = 1;
        view.addGestureRecognizer(swipeDownGestureRecognizer);
    }
    
    func setupSwipeUpGesture(view: SKView, scene: SKScene, action: Selector) {
        swipeUpGestureRecognizer = UISwipeGestureRecognizer(target: scene, action: action);
        swipeUpGestureRecognizer.direction = .up;
        swipeUpGestureRecognizer.numberOfTouchesRequired = 1;
        view.addGestureRecognizer(swipeUpGestureRecognizer);
    }
}
