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
    
    init(){
        self = Mode.Normal
    }
    
    mutating func nextMode(){
        
        if let nextMode = Mode(rawValue: rawValue + 1){
            self = nextMode
        }else{
            return
        }
    }
    
    func nextModeExists() -> Bool{
        
        var ifExist: Bool
        
        if Mode(rawValue: rawValue + 1) != nil{
            ifExist = true
        }else{
            ifExist = false
        }
        
        return ifExist
    }
    
    mutating func previousMode(){
        
        if let previousMode = Mode(rawValue: rawValue - 1){
            self = previousMode
        }else{
            return
        }
    }
    
    func previousModeExists() -> Bool{
        
        var ifExist: Bool
        
        if Mode(rawValue: rawValue - 1) != nil{
            ifExist = true
        }else{
            ifExist = false
        }
        
        return ifExist
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
