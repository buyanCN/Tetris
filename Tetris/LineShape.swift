//
//  LineShape.swift
//  Tetris
//
//  Created by buyan on 2017/5/11.
//  Copyright © 2017年 buyan. All rights reserved.
//

class LineShape:Shape{
    
    
    /*
     this means the 0,0 point:  !!
     zero and one eighty:
     !0!
     |1|
     |2|
     |3|
     
     ninety and two seventy:
     |0!1!2|3|
     
     */
    
    override var blockRowColumnPositions: [Orientation : Array<(columnDiff: Int, rowDiff: Int)>]{
        return [
            Orientation.Zero : [(0,0), (0,1), (0,2), (0,3)],
            Orientation.Ninety : [(-1,0), (0,0), (1,0), (2,0)],
            Orientation.OneEighty : [(0,0), (0,1), (0,2), (0,3)],
            Orientation.TwoSeventy : [(-1,0), (0,0), (1,0), (2,0)]
        ]
    }
    
    override var bottomBlocksForOrientations: [Orientation : Array<Block>]{
        return [
            Orientation.Zero : [blocks[FourthBlockIndex]],
            Orientation.Ninety : blocks,
            Orientation.OneEighty : [blocks[FourthBlockIndex]],
            Orientation.TwoSeventy : blocks
        ]
    }
}
