//
//  File.swift
//  co-card
//
//  Created by ちいつんしん on 2020/11/29.
//  Copyright © 2020 ちいつんしん. All rights reserved.
//

import Foundation

enum Mode: Int {
    case easy

    case normal

    case hard

    case veryHard

    init() {
        self = Mode.normal
    }

    mutating func nextMode() {
        if let nextMode = Mode(rawValue: rawValue + 1) {
            self = nextMode
        } else {
            return
        }
    }

    func nextModeExists() -> Bool {
        var ifExist: Bool

        if Mode(rawValue: rawValue + 1) != nil {
            ifExist = true
        } else {
            ifExist = false
        }

        return ifExist
    }

    mutating func previousMode() {
        if let previousMode = Mode(rawValue: rawValue - 1) {
            self = previousMode
        } else {
            return
        }
    }

    func previousModeExists() -> Bool {
        var ifExist: Bool

        if Mode(rawValue: rawValue - 1) != nil {
            ifExist = true
        } else {
            ifExist = false
        }

        return ifExist
    }

    var cardPerLine: Int {
        switch self {
        case .easy: return 4
        case .normal: return 5
        case .hard, .veryHard: return 6
        }
    }
}
