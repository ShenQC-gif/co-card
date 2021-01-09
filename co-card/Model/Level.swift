//
//  Level.swift
//  co-card
//
//  Created by ちいつんしん on 2021/01/09.
//  Copyright © 2021 ちいつんしん. All rights reserved.
//

import Foundation

class Level{
    
    var level = Int()
    
    ///最初のレベル
    func firstLevel() -> String {
        level = 1
        return CurrentLevel()
    }
    
    ///レベルを1上げる
    func nextLevel() -> String{
        level += 1
        return CurrentLevel()
    }
    
    ///現在のレベルを返す
    func CurrentLevel() -> String{
        return "Level \(level)"
    }
    
}
