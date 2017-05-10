//
//  GameViewController.swift
//  Tetris
//
//  Created by buyan on 2017/5/10.
//  Copyright © 2017年 buyan. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    var scene : GameScene!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // configure the view.
        print("confiture the view")
        let skView = view as! SKView
        skView.isMultipleTouchEnabled = false
        
        // create and configure the scene
        print("create and configure the scene")
        scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .aspectFit
        
        // present the scene
        print("present the scene")
        skView.presentScene(scene)
        }

 

   

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
