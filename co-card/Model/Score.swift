//
//  Score.swift
//  co-card
//
//  Created by ちいつんしん on 2021/01/09.
//  Copyright © 2021 ちいつんしん. All rights reserved.
//

import Foundation

class Score {
    var score: Int

    init() {
        score = 0
    }

    func plus(point: Int) {
        score += point
    }

    func currenScore() -> Int {
        return score
    }
}
