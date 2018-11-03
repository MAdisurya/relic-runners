//
//  Character.swift
//  RelicRunners
//
//  Created by Mario Adisurya on 3/11/18.
//  Copyright © 2018 Mario Adisurya. All rights reserved.
//

import SpriteKit

class Character: SKSpriteNode, RREventListener {
    
    private var m_CharacterType: CharacterTypes!;
    
    init(type characterType: CharacterTypes) {
        super.init(texture: SKTexture(), color: UIColor(), size: SKTexture().size());
        
        self.m_CharacterType = characterType;
        
        RRGameManager.shared.getEventManager().registerEventListener(listener: self);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented");
    }
    
    func generateCharacter(scene: SKScene, imageNamed image: String) -> Void {
        self.texture = SKTexture(imageNamed: image);
        self.size = CGSize(width: scene.size.width / 3.0, height: scene.size.width / 3.0);
    }
    
    func listen(event: String) {
        if (event == "swipeUp") {
            let action = SKAction.move(by: CGVector(dx: 0, dy: self.size.height), duration: 0.5);
            self.run(action);
        } else if (event == "swipeDown") {
            let action = SKAction.move(by: CGVector(dx: -0, dy: -self.size.height), duration: 0.5);
            self.run(action);
        }
    }
}
