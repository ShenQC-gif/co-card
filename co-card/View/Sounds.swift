//
//  Sounds.swift
//  co-card
//
//  Created by ちいつんしん on 2020/11/06.
//  Copyright © 2020 ちいつんしん. All rights reserved.
//

import AVFoundation
import Foundation

class Sounds {
    var player: AVAudioPlayer?

    func playSound(fileName: String, extentionName: String) {
        let soundURL = Bundle.main.url(forResource: fileName, withExtension: extentionName)

        do {
            player = try AVAudioPlayer(contentsOf: soundURL!)
            player?.play()
        } catch {
            print("error")
        }
    }
}
