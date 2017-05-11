//
//  LShape.swift
//  Tetris
//
//  Created by buyan on 2017/5/11.
//  Copyright © 2017年 buyan. All rights reserved.
//

class LShape:Shape{
    
    /*
     zero: !0!
           |1|
           |2|3|
     
     ninety: | ! ! |
             |2|1|0|
             |3|
     
     one eighty: |3!2!
                   |1|
                   |0|
     
     two seventy: | ! !3|
                  |0|1|2|
     
     */
    
    override var blockRowColumnPositions: [Orientation : Array<(columnDiff: Int, rowDiff: Int)>]{
        return [
            Orientation.Zero : [(0,0), (0,1), (0,2), (1,2)],
            Orientation.Ninety : [(1,1), (0,1), (-1,1), (-1,2)],
            Orientation.OneEighty : [(0,2), (0,1), (0,0), (-1,0)],
            Orientation.TwoSeventy : [(-1,1), (0,1), (1,1), (1,0)]
        ]
    }
    
    override var bottomBlocksForOrientations: [Orientation : Array<Block>]{
        return [
            Orientation.Zero : [blocks[ThirdBlockIndex], blocks[FourthBlockIndex]],
            Orientation.Ninety : [blocks[FirstBlockIndex], blocks[SecondBlockIndex], blocks[FourthBlockIndex]],
            Orientation.OneEighty : [blocks[FirstBlockIndex], blocks[FourthBlockIndex]],
            Orientation.TwoSeventy : [blocks[FirstBlockIndex], blocks[SecondBlockIndex], blocks[ThirdBlockIndex]]
        ]
    }
}
