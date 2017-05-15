//
//  TShape.swift
//  Tetris
//
//  Created by buyan on 2017/5/11.
//  Copyright © 2017年 buyan. All rights reserved.
//

class TShape:Shape{
    
    /*
  
     zero:
     
     | |0| |
     |1|2|3|
     | | | |
     
   
     ninety:
     
     | |1| |
     | |2|0|
     | |3| |
     
     
     one eighty:
     
     | | | |
     |1|2|3|
       |0|
     
     
     two seventy:
     
     | |1| |
     |0|2| |
     | |3| |
    */
    
    override var blockRowColumnPositions: [Orientation : Array<(columnDiff: Int, rowDiff: Int)>]{
        return[
            Orientation.Zero : [(1,0), (0,1), (1,1), (2,1)],
            Orientation.Ninety : [(2,1), (1,0), (1,1), (1,2)],
            Orientation.OneEighty : [(1,2), (0,1), (1,1), (2,1)],
            Orientation.TwoSeventy : [(0,1), (1,0), (1,1), (1,2)]
        ]
    }
    
    override var bottomBlocksForOrientations: [Orientation : Array<Block>]{
        return[
            Orientation.Zero : [blocks[SecondBlockIndex], blocks[ThirdBlockIndex], blocks[FourthBlockIndex]],
            Orientation.Ninety : [blocks[FirstBlockIndex], blocks[FourthBlockIndex]],
            Orientation.OneEighty : [blocks[FirstBlockIndex], blocks[SecondBlockIndex], blocks[FourthBlockIndex]],
            Orientation.TwoSeventy : [blocks[FirstBlockIndex], blocks[FourthBlockIndex]]
        ]
    }
}
