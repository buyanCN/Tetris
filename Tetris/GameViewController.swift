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
    var swiftris : Swiftris!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // configure the view.
        //print("confiture the view")
        let skView = view as! SKView
        skView.isMultipleTouchEnabled = false
        
        // create and configure the scene
        //print("create and configure the scene")
        scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .aspectFit
        
        scene.tick = didTick
        swiftris = Swiftris()
        swiftris.beginGame()
        
        // present the scene
        //print("present the scene")
        skView.presentScene(scene)
        
        
        scene.addPreviewShapeToScene(shape: swiftris.nextShape!){
            self.swiftris.nextShape?.moveTo(column: StartingColumn, row: StartingRow)
            self.scene.movePreviewShape(shape: self.swiftris.nextShape!){
                let nextShapes = self.swiftris.newShape()
                self.scene.startTicking()
                self.scene.addPreviewShapeToScene(shape: nextShapes.nextShape! ){}
            }
        }
    }

 

   

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func didTick(){
        swiftris.fallingShape?.lowerShapeByOneRow()
        scene.redRawShape(shape: swiftris.fallingShape!, completion: {})
    }
}
