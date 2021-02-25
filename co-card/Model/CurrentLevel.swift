//
//  Level.swift
//  co-card
//
//  Created by ちいつんしん on 2021/01/09.
//  Copyright © 2021 ちいつんしん. All rights reserved.
//

import Foundation

class CurrentLevel {
    var level: Int

    init() {
        level = 1
    }

    /// レベルを1上げる
    func nextLevel() {
        level += 1
    }

    /// 現在のレベルを返す
    func currentLevel() -> Int {
        return level
    }
}
