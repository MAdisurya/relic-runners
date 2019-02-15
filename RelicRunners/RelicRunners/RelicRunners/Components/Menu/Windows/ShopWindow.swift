//
//  ShopWindow.swift
//  RelicRunners
//
//  Created by Mario Adisurya on 16/02/19.
//  Copyright © 2019 Mario Adisurya. All rights reserved.
//

import SpriteKit

class ShopWindow: MenuWindow {
    
    override init() {
        super.init();
        
        m_Background.texture = SKTexture(imageNamed: "shop-window");
        m_Background.texture?.filteringMode = .nearest;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
