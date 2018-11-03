//
//  RREventListener.swift
//  RelicRunners
//
//  Created by Mario Adisurya on 3/11/18.
//  Copyright © 2018 Mario Adisurya. All rights reserved.
//

import Foundation

protocol RREventListener {
    
    // Will be invoked whenever an event is broadcast
    func listen(event: String) -> Void;
}
