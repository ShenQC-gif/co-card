//
//  Box.swift
//  co-card
//
//  Created by ちいつんしん on 2020/11/06.
//  Copyright © 2020 ちいつんしん. All rights reserved.
//

import Foundation
import UIKit

class Box {
    func create(label: UILabel) {
        // 位置とサイズの指定
        label.textAlignment = NSTextAlignment.center // 横揃えの設定
        label.textColor = UIColor.black // テキストカラーの設定
        label.backgroundColor = UIColor.white
        label.layer.borderWidth = 2
        label.layer.cornerRadius = 10
        label.font = UIFont(name: "HiraKakuProN-W6", size: 17) // フォントの設定
    }
}
