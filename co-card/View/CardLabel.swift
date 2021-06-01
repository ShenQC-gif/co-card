//
//  Card.swift
//  co-card
//
//  Created by ちいつんしん on 2021/01/11.
//  Copyright © 2021 ちいつんしん. All rights reserved.
//

import Foundation
import UIKit

class CardLabel {
    func createCard(mode: Mode, numberOfCard: Int) -> UILabel {
        let card = UILabel()

        property(card)

        card.frame = CGRect(x: xCoorinate(mode, numberOfCard),
                            y: yCoorinate(mode, numberOfCard - 1),
                            width: lengthOfSide(mode),
                            height: lengthOfSide(mode))

        return card
    }

    // カードのプロパティを設定
    private func property(_ card: UILabel) {
        card.textAlignment = .center // 横揃えの設定
        card.textColor = .black // テキストカラーの設定
        card.backgroundColor = .white
        card.layer.borderWidth = 2
        card.layer.cornerRadius = 10
        card.font = UIFont(name: "HiraKakuProN-W6", size: 17) // フォントの設定
    }

    private func standareLength(_ mode: Mode) -> CGFloat {
        let width = UIScreen.main.bounds.size.width

        // 画面を(一行あたりのカード×6)分かつした幅を1とする
        let standardLength = width / CGFloat(mode.cardPerLine * 6)

        return standardLength
    }

    private func xCoorinate(_ mode: Mode, _ numberOfCard: Int) -> CGFloat {
        let standardLength = standareLength(mode)

        var xCoordinate = CGFloat()

        xCoordinate = standardLength + 6 * standardLength * CGFloat(numberOfCard % mode.cardPerLine)

        return xCoordinate
    }

    private func yCoorinate(_ mode: Mode, _ numberOfCard: Int) -> CGFloat {
        var cardYStartPoint = CGFloat()

        cardYStartPoint = 80 * (1 + CGFloat(numberOfCard / mode.cardPerLine))

        let yCoordinate = MainViewController.menuHegiht + cardYStartPoint

        return yCoordinate
    }

    private func lengthOfSide(_ mode: Mode) -> CGFloat {
        let standardLength = standareLength(mode)
        return standardLength * 4
    }
}
