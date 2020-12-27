//
//  File.swift
//  co-card
//
//  Created by ちいつんしん on 2020/11/29.
//  Copyright © 2020 ちいつんしん. All rights reserved.
//

import Foundation


enum Mode: Int{
    
    case Easy
    
    case Normal
    
    case Hard
    
    case VeryHard
    
    var next: Mode? {
        Mode(rawValue: rawValue + 1)
    }
  
    var previous: Mode?{
      Mode(rawValue: rawValue - 1)
    }

    var title: String {
        switch self {
        case .Easy: return "Easy"
        case .Normal: return "Normal"
        case .Hard: return "Hard"
        case .VeryHard: return "VeryHard"
        }
    }
    
}
