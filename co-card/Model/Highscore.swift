//
//  Highscore.swift
//  co-card
//
//  Created by ちいつんしん on 2020/11/06.
//  Copyright © 2020 ちいつんしん. All rights reserved.
//

import Foundation

class Highscore {
    
    var score = 0
    var updateOrNot = false
    
    //最新のハイスコア参照
    func refer(_ key: String){
        
        if UserDefaults.standard.object(forKey: key) != nil {
            
            score = UserDefaults.standard.object(forKey: key) as! Int
        
        }
        
    }
        
    //新しいスコアがハイスコアを更新時、ハイスコアを上書きし記憶
    func updateScore(_ newScore: Int, _ mode: String){
        
        if newScore > score {
            
            score = newScore
            
            UserDefaults.standard.set(score, forKey: mode )
                        
            updateOrNot = true
        }
        
    }
    
}
