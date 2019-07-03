//
//  RRLevelManager.swift
//  RelicRunners
//
//  Created by Mario Adisurya on 3/07/19.
//  Copyright © 2019 Mario Adisurya. All rights reserved.
//

import SpriteKit

enum SceneManagerError: Error
{
    case InvalidScene;
    case NullReference;
}

class RRSceneManager
{
    public var currentScene: SKScene!;
    public var previousScene: SKScene? = nil;
    
    private var m_AllScenes: [String: SKScene] = [:];
    
    public func registerScene(_SceneName: String, _Scene: SKScene)
    {
        m_AllScenes[_SceneName] = _Scene;
    }
    
    public func goToScene(_Scene: SKScene) throws
    {
        if (currentScene == nil)
        {
            print("RRLevelManager.currentScene is nil!");
            throw SceneManagerError.NullReference;
        }
        
        let reveal = SKTransition.fade(withDuration: 1);
        
        currentScene.view?.presentScene(_Scene, transition: reveal);
        
        previousScene = currentScene;
        currentScene = _Scene;
    }
    
    public func goToScene(_SceneName: String) throws
    {
        if (currentScene == nil)
        {
            print("RRLevelManager.currentScene is nil!");
            throw SceneManagerError.NullReference;
        }
        
        let reveal = SKTransition.fade(withDuration: 1);
        
        guard let scene = m_AllScenes[_SceneName] else
        {
            print("The scene with name " + _SceneName + " doesn't exist in RRSceneManager.m_AllScenes");
            throw SceneManagerError.InvalidScene;
        }
        
        currentScene.view?.presentScene(scene, transition: reveal);
        
        previousScene = currentScene;
        currentScene = scene;
    }
}
