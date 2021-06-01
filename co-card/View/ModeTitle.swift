//
//  ModeTitle.swift
//  co-card
//
//  Created by ちいつんしん on 2021/01/17.
//  Copyright © 2021 ちいつんしん. All rights reserved.
//

import Foundation

class ModeTitle {
    func returnTitle(mode: Mode) -> String {
        switch mode {
        case .easy:
            return "Easy"

        case .normal:
            return "Normal"

        case .hard:
            return "Hard"

        case .veryHard:
            return "VeryHard"
        }
    }
}
