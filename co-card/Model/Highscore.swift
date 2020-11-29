//
//  Highscore.swift
//  co-card
//
//  Created by ちいつんしん on 2020/11/06.
//  Copyright © 2020 ちいつんしん. All rights reserved.
//

import Foundation

class Highscore {
    
    var score = Int()
    var updateOrNot = false
    
    
    ///最新のハイスコア参照
    func refer(_ mode: String) -> Int{
        
        if UserDefaults.standard.object(forKey: mode) != nil {
            
            score = UserDefaults.standard.object(forKey: mode)as! Int
            return score
            
        }else{
            
            return 0
            
        }
        
    }
        
    ///新しいスコアがハイスコアを更新時、ハイスコアを上書きし記憶
    func updateScore(_ newScore: Int, _ mode: String){
        
        if newScore > score {
            
            score = newScore
            
            UserDefaults.standard.set(score, forKey: mode )
                        
            updateOrNot = true
        }
        
    }
    
}
