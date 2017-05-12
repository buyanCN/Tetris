//
//  Shape.swift
//  Tetris
//
//  Created by buyan on 2017/5/11.
//  Copyright © 2017年 buyan. All rights reserved.
//

import SpriteKit

let NumOrientations: UInt32 = 4

enum Orientation: Int,CustomStringConvertible{
    case Zero=0, Ninety, OneEighty, TwoSeventy
    var description: String{
        switch self{
        case .Zero: return "0"
        case .Ninety: return "90"
        case .OneEighty: return "180"
        case .TwoSeventy: return "270"
        }
    }
    
    static func random()->Orientation{
        return Orientation(rawValue:Int(arc4random_uniform(NumOrientations)))!
    }
    
    static func rotate(orientation:Orientation, clockwise: Bool)->Orientation{
        var rotated = orientation.rawValue + (clockwise ? 1 : -1)
        if rotated > Orientation.TwoSeventy.rawValue{
            rotated = Orientation.Zero.rawValue
        }else if rotated < 0{
            rotated = Orientation.TwoSeventy.rawValue
        }
        
        return Orientation(rawValue: rotated)!
    }
    
}

// the number of total shape varieties
let NumShapeTypes:UInt32 =  7

// shape indexs
let FirstBlockIndex:Int = 0
let SecondBlockIndex:Int = 1
let ThirdBlockIndex:Int = 2
let FourthBlockIndex:Int  = 3

class Shape : Hashable, CustomStringConvertible{
    
    // the color of shape
    let color:BlockColor
    
    // the blocks comprising the shape
    var blocks = Array<Block>()
    
    // the current orientation of the shape
    var orientation:Orientation
    
    // the column and row representing the shape's anchor point
    var column, row : Int
    
    // required overrides
    // subclasses must override this property
    var blockRowColumnPositions: [Orientation:Array<(columnDiff: Int, rowDiff: Int)>]{
        return [:]
    }
    
    // subclasses must override this property
    var bottomBlocksForOrientations: [Orientation: Array<Block>]{
        return [:]
    }
    
    var bottomBlocks: Array<Block>{
        guard let bottomBlocks = bottomBlocksForOrientations[orientation] else {
            return []
        }
        return bottomBlocks
    }
    
    // Hashvalue
    var hashValue: Int{
        return blocks.reduce(0){$0.hashValue ^ $1.hashValue}
    }
    
    
    // CustomStringConvertible
    var description: String{
        return "\(color) block facing \(orientation): \(blocks[FirstBlockIndex]), \(blocks[SecondBlockIndex]), \(blocks[ThirdBlockIndex]), \(blocks[FourthBlockIndex])"
    }
    
    init(column:Int, row:Int, color:BlockColor, orientation:Orientation){
        self.color = color
        self.column = column
        self.row = row
        self.orientation = orientation
        initializeBlocks()
    }
    
    convenience init(column:Int, row:Int){
        self.init(column: column, row: row, color: BlockColor.random(), orientation: Orientation.random())
    }
    
    final func initializeBlocks(){
        guard  let blockRowColumnTranslation = blockRowColumnPositions[orientation] else {
            return
        }
        blocks = blockRowColumnTranslation.map{(diff)->Block in
            return Block(column:column+diff.columnDiff, row: row+diff.rowDiff, color: color)
        }
        
    }
    
    final func rotateBlocks(orientation : Orientation){
        guard let blockRowColumnTranslation:Array<(columnDiff:Int, rowDiff:Int)> = blockRowColumnPositions[orientation] else{
            return
        }
        
        for(idx, diff) in blockRowColumnTranslation.enumerated(){
            blocks[idx].column = column + diff.columnDiff
            blocks[idx].row = row + diff.rowDiff
        }
    }
    
    final func lowerShapeByOneRow(){
        shiftBy(columns: 0, rows:1)
    }
    
    final func shiftBy(columns: Int, rows: Int){
        self.column += columns
        self.row += rows
        for block in blocks{
            block.column += columns
            block.row += rows
        }
    }
    
    final func moveTo(column: Int, row: Int){
        self.column = column
        self.row = row
        rotateBlocks(orientation: orientation)
    }
    
    final class func random(startingColumn: Int, startingRow: Int)->Shape{
        switch Int(arc4random_uniform(NumShapeTypes)){
        case 0: return SquareShape(column: startingColumn, row: startingRow)
        case 1: return LineShape(column: startingColumn, row: startingRow)
        case 2: return TShape(column: startingColumn, row: startingRow)
        case 3: return LShape(column: startingColumn, row: startingRow)
        case 4: return JShape(column: startingColumn, row: startingRow)
        case 5: return SShape(column: startingColumn, row: startingRow)
        default: return ZShape(column: startingColumn, row: startingRow)
        }
    }

    static func == (lhs: Shape, rhs: Shape)->Bool{
        return lhs.row == rhs.row && lhs.column == rhs.column
    }

}
