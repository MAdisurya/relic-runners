//
//  RRSoundManager.swift
//  RelicRunners
//
//  Created by Mario Adisurya on 22/01/19.
//  Copyright © 2019 Mario Adisurya. All rights reserved.
//

import SpriteKit
import AVKit

class RRSoundManager {
    private var m_AudioNode = SKAudioNode();
    
    // Getters
    func getAudioNode() -> SKAudioNode {
        return m_AudioNode;
    }
    
    func playSound(name soundName: String) {
        let soundAction = SKAction.playSoundFileNamed(soundName, waitForCompletion: false);
        stop();
        m_AudioNode.run(soundAction);
    }
    
    func playBackgroundMusic(name musicName: String) {
        m_AudioNode = SKAudioNode(fileNamed: musicName);
        play();
    }
    
    func play() {
        let playAction = SKAction.play();
        m_AudioNode.run(playAction);
    }
    
    func stop() {
        let stopAction = SKAction.stop();
        m_AudioNode.run(stopAction);
    }
    
    func pause() {
        let pauseAction = SKAction.pause();
        m_AudioNode.run(pauseAction);
    }
    
    func mute() {
        let muteVolume = SKAction.changeVolume(to: 0, duration: 0.01);
        m_AudioNode.run(muteVolume);
    }
}
