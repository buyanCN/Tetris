//
//  ZShape.swift
//  Tetris
//
//  Created by buyan on 2017/5/11.
//  Copyright © 2017年 buyan. All rights reserved.
//

class ZShape:Shape{
    
    /*
     zero and one eighty:
          ! !0|
          |2|1|
          |3| |
     
     ninety and two senventy:
         |0!1! |
         | |2|3|
     */
    
    override var blockRowColumnPositions: [Orientation : Array<(columnDiff: Int, rowDiff: Int)>]{
        return [
            Orientation.Zero : [(1,0), (1,1), (0,1), (0,2)],
            Orientation.Ninety : [(-1,0), (0,0), (0,1), (1,1)],
            Orientation.OneEighty : [(1,0), (1,1), (0,1), (0,2)],
            Orientation.TwoSeventy : [(-1,0), (0,0), (0,1), (1,1)]
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
