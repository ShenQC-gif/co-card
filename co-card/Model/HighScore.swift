//
//  Highscore.swift
//  co-card
//
//  Created by ちいつんしん on 2020/11/06.
//  Copyright © 2020 ちいつんしん. All rights reserved.
//

import Foundation

class HighScore {
    
    var highScore = Int()
    var updatedOrNot = Bool()
    
    ///最新のハイスコア参照
    func refer(_ mode: String){
        
        if UserDefaults.standard.object(forKey: mode) != nil {
            
            highScore = UserDefaults.standard.object(forKey: mode)as! Int
            
        }else{
            
            highScore = 0
            
        }
        
    }
        
    ///新しいスコアがハイスコアを更新時、ハイスコアを上書きし記憶
    func updateScore(_ newScore: Int, _ mode: String){
        
        if newScore > highScore {
            
            updatedOrNot = true
            
            highScore = newScore
            
            UserDefaults.standard.set(highScore, forKey: mode )
           
        }
        
    }
    
    func currentHighScore(_ mode: String) -> Int{
        
        refer(mode)
        
        return highScore
        
    }
    
}
