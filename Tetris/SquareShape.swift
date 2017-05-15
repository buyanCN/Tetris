//
//  SquareShape.swift
//  Tetris
//
//  Created by buyan on 2017/5/11.
//  Copyright © 2017年 buyan. All rights reserved.
//

class SquareShape:Shape{
    
    /*
        |0|1|
        |2|3|
     
     marks the row/column indicator for the shape
    */
    // the square shape will not rotate
    override var blockRowColumnPositions: [Orientation: Array<(columnDiff: Int, rowDiff: Int)>]{
        return[
            Orientation.Zero : [(0,0), (1,0), (0,1), (1,1)],
            Orientation.OneEighty : [(0,0), (1,0), (0,1), (1,1)],
            Orientation.Ninety : [(0,0), (1,0), (0,1), (1,1)],
            Orientation.TwoSeventy : [(0,0), (1,0), (0,1), (1,1)]
        ]
    }
    
    override var bottomBlocksForOrientations: [Orientation : Array<Block>]{
        return [
            Orientation.Zero : [blocks[ThirdBlockIndex], blocks[FourthBlockIndex]],
            Orientation.OneEighty : [blocks[ThirdBlockIndex], blocks[FourthBlockIndex]],
            Orientation.Ninety : [blocks[ThirdBlockIndex], blocks[FourthBlockIndex]],
            Orientation.TwoSeventy : [blocks[ThirdBlockIndex], blocks[FourthBlockIndex]]
        ]
    }
    
    
}
