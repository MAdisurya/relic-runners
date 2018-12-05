//
//  CategoryBitMask.swift
//  RelicRunners
//
//  Created by Mario Adisurya on 5/11/18.
//  Copyright © 2018 Mario Adisurya. All rights reserved.
//

enum CategoryBitMask {
    static let player: UInt32 = 0b0001;
    static let enemy: UInt32 = 0b0010;
    static let weapon: UInt32 = 0b0100;
    static let obstacle: UInt32 = 0b1000;
    static let boss: UInt32 = 0b1010;
    static let powerUp: UInt32 = 0b1100;
}
