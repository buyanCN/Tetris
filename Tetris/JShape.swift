//
//  JShape.swift
//  Tetris
//
//  Created by buyan on 2017/5/11.
//  Copyright © 2017年 buyan. All rights reserved.
//

class JShape:Shape{
    
    /*
     Zero: ! !0|
           | |1|
           |3|2|
     
     ninety: !3! | |
             |2|1|0|
     
     one eighty: !2!3|
                 |1| |
                 |0| |
     
     two seventy: !0!1|2|
                  | | |3|
     
     
     */
    
    override var blockRowColumnPositions: [Orientation : Array<(columnDiff: Int, rowDiff: Int)>]{
        return [
            Orientation.Zero : [(1,0), (1,1), (1,2), (0,2)],
            Orientation.Ninety : [(2,1), (1,1), (0,1), (0,0)],
            Orientation.OneEighty : [(0,2), (0,1), (0,0), (1,0)],
            Orientation.TwoSeventy : [(0,0), (1,0), (2,0), (2,1)]
        ]
    }
    
    override var bottomBlocksForOrientations: [Orientation : Array<Block>]{
        return [
            Orientation.Zero : [blocks[ThirdBlockIndex], blocks[FourthBlockIndex]],
            Orientation.Ninety : [blocks[FirstBlockIndex], blocks[SecondBlockIndex], blocks[ThirdBlockIndex]],
            Orientation.OneEighty : [blocks[FirstBlockIndex], blocks[FourthBlockIndex]],
            Orientation.TwoSeventy : [blocks[FirstBlockIndex], blocks[SecondBlockIndex], blocks[FourthBlockIndex]]
        ]
    }
}
