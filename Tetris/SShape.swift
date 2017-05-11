//
//  SShape.swift
//  Tetris
//
//  Created by buyan on 2017/5/11.
//  Copyright © 2017年 buyan. All rights reserved.
//

class SShape:Shape{
    /*
     zero and one eighty:
           !0! |
           |1|2|
           | |3|
     
     ninety and two seventy:
             ! !1|0|
             |3|2| |
    
     */
    
    override var blockRowColumnPositions: [Orientation : Array<(columnDiff: Int, rowDiff: Int)>]{
        return [
            Orientation.Zero : [(0,0), (0,1), (1,1), (1,2)],
            Orientation.Ninety : [(2,0), (1,0), (1,1), (0,1)],
            Orientation.OneEighty : [(0,0), (0,1), (1,1), (1,2)],
            Orientation.TwoSeventy : [(2,0), (1,0), (1,1), (0,1)]
        ]
    }
    
    override var bottomBlocksForOrientations: [Orientation : Array<Block>]{
        return [
            Orientation.Zero : [blocks[SecondBlockIndex], blocks[FourthBlockIndex]],
            Orientation.Ninety : [blocks[FirstBlockIndex], blocks[ThirdBlockIndex], blocks[FourthBlockIndex]],
            Orientation.OneEighty : [blocks[SecondBlockIndex], blocks[FourthBlockIndex]],
            Orientation.TwoSeventy : [blocks[FirstBlockIndex], blocks[ThirdBlockIndex], blocks[FourthBlockIndex]]
        ]
    }
}
