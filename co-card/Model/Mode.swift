//
//  File.swift
//  co-card
//
//  Created by ちいつんしん on 2020/11/29.
//  Copyright © 2020 ちいつんしん. All rights reserved.
//

import Foundation


enum Mode: String{
    
    case Easy
    
    case Normal
    
    case Hard
    
    case VeryHard
    
    var nextMode: Mode! {
        switch self {
        case .Easy:
            return.Normal
        case .Normal:
            return .Hard
        case .Hard:
            return .VeryHard
        case .VeryHard:
            return nil
      
        }
    }
    
    var previousMode: Mode! {
        switch self {
        case .Easy:
            return nil
        case .Normal:
            return .Easy
        case .Hard:
            return .Normal
        case .VeryHard:
            return .Hard
        }
    }
    
}
    
