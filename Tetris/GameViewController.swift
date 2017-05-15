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

class GameViewController: UIViewController, SwiftrisDelegate ,UIGestureRecognizerDelegate{
    
    var scene : GameScene!
    var swiftris : Swiftris!
    var panPointReference : CGPoint?

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    
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
       
        swiftris.delegate = self
        swiftris.beginGame()
        
        // present the scene
        //print("present the scene")
        skView.presentScene(scene)
        
        
        /*
            scene.addPreviewShapeToScene(shape: swiftris.nextShape!){
            self.swiftris.nextShape?.moveTo(column: StartingColumn, row: StartingRow)
            self.scene.movePreviewShape(shape: self.swiftris.nextShape!){
                let nextShapes = self.swiftris.newShape()
                self.scene.startTicking()
                self.scene.addPreviewShapeToScene(shape: nextShapes.nextShape! ){}
            }
        }
         */
    }

 

    @IBAction func didTap(_ sender: UITapGestureRecognizer) {
        swiftris.rotateShape()
    }
    
    
    @IBAction func didPan(_ sender: UIPanGestureRecognizer) {
        //print("didPan")
        let currentPoint = sender.translation(in: self.view)
        //print("\(currentPoint)")
        if let originalPoint = panPointReference{
            //print("originalPoint = panPointReference")
            if abs(currentPoint.x - originalPoint.x) > (BlockSize * 0.9){
                //print("currentPoint.x=\(currentPoint.x), originalPoint.x=\(originalPoint.x)")
                if sender.velocity(in: self.view).x > CGFloat(0){
                    //print("move shape right")
                    swiftris.moveShapeRight()
                    panPointReference = currentPoint
                }else{
                    //print("move shape left")
                    swiftris.moveShapeLeft()
                    panPointReference = currentPoint
                }
            }
        }else if sender.state == .began{
                panPointReference = currentPoint
        }
    }
    
    
    @IBAction func didSwipe(_ sender: UISwipeGestureRecognizer) {
        swiftris.dropShape()
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer is UISwipeGestureRecognizer{
            if otherGestureRecognizer is UIPanGestureRecognizer{
                return true
            }
        }else if gestureRecognizer is UIPanGestureRecognizer{
            if otherGestureRecognizer is UITapGestureRecognizer{
                return true
            }
        }
        return false
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func didTick(){
        swiftris.letShapeFall()
        //swiftris.fallingShape?.lowerShapeByOneRow()
        //scene.redrawShape(shape: swiftris.fallingShape!, completion: {})
    }
    
    func nextShape(){
        let newShapes = swiftris.newShape()
        guard let fallingShape = newShapes.fallingShape else {
            return
        }
        self.scene.addPreviewShapeToScene(shape: newShapes.nextShape!){}
        self.scene.movePreviewShape(shape: fallingShape){
            self.view.isUserInteractionEnabled = true
            self.scene.startTicking()
        }
    }
    
    func gameDidBegin(swiftris: Swiftris) {
        levelLabel.text = "\(swiftris.level)"
        scoreLabel.text = "\(swiftris.score)"
        scene.tickLengthMillis = TickLengthLevelOne
        
        if swiftris.nextShape != nil && swiftris.nextShape!.blocks[0].sprite == nil {
            scene.addPreviewShapeToScene(shape: swiftris.nextShape!){
                self.nextShape()
            }
        }else{
            nextShape()
        }
    }
    
    func gameDidEnd(swiftris: Swiftris) {
        view.isUserInteractionEnabled = false
        scene.stopTicking()
        
        //scene.playSound(sound: "Sounds/gameover.mp3")
        scene.animateCollapseingLines(LinesToRemove: swiftris.removeAllBlocks(), fallenBlocks: swiftris.removeAllBlocks()){
            swiftris.beginGame()
        }
    }
    
    func gameDidLevelUp(swiftris: Swiftris) {
        levelLabel.text = "\(swiftris.level)"
        if scene.tickLengthMillis >= 100{
            scene.tickLengthMillis -= 100
        }else if scene.tickLengthMillis > 50{
            scene.tickLengthMillis -= 50
        }
        //scene.playSound(sound: "Sounds/levelup.mp3")
    }
    
    func gameShapeDidDrop(swiftris: Swiftris) {
        scene.stopTicking()
        scene.redrawShape(shape: swiftris.fallingShape!){
            swiftris.letShapeFall()
        }
        
        //scene.playSound(sound: "Sounds/drop.mp3")
    }
    
    func gameShapeDidLand(swiftris: Swiftris) {
        scene.stopTicking()
        //nextShape()
        self.view.isUserInteractionEnabled = false
        let removedLines = swiftris.removeCompletedLines()
        if removedLines.linesRemoved.count > 0{
            self.scoreLabel.text = "\(swiftris.score)"
            scene.animateCollapseingLines(LinesToRemove: removedLines.linesRemoved, fallenBlocks: removedLines.fallenBlocks){
                self.gameShapeDidLand(swiftris: swiftris)
            }
            //scene.playSound(sound: "Sounds/bomb.mp3")
        }else{
            nextShape()
        }
    }
    
    func gameShapeDidMove(swiftris: Swiftris) {
        scene.redrawShape(shape: swiftris.fallingShape!){}
    }
}
