//
//  EventManager.swift
//  RelicRunners
//
//  Created by Mario Adisurya on 3/11/18.
//  Copyright © 2018 Mario Adisurya. All rights reserved.
//

import Foundation

class RREventManager {
    
    private var m_EventListeners: [RREventListener] = [];
    
    func registerEventListener(listener eventListener: RREventListener) -> Void {
        m_EventListeners.append(eventListener);
    }
    
    func broadcastEvent(event: String) {
        for eventListener in m_EventListeners {
            eventListener.listen(event: event);
        }
    }
    
    func broadcastEvent<T>(event: inout T) {
        for eventListener in m_EventListeners {
            eventListener.listen(event: &event);
        }
    }
}
