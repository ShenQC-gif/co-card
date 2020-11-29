//
//  ViewController.swift
//  co-card
//
//  Created by ちいつんしん on 2020/11/06.
//  Copyright © 2020 ちいつんしん. All rights reserved.
//

import AVFoundation
import UIKit

class MainViewController: UIViewController, AVAudioPlayerDelegate {
    
    var sounds = Sounds()
    var highScore = Highscore()

    //一行あたりのカードの枚数。難易度によって異なる。
    var cardPerLine = Int()
    //座標計算のため、CGFloat型でも管理
    var cardPerLineInCGFloatType = CGFloat()
    
    var cardCount = Int()
    var cardCountInCGFloatType = CGFloat()
    
    var coverCount = CGFloat()
    var coverPlotInCGFloatType = CGFloat()

    //カードの一辺の長さ。カードの枚数によって異なる。
    var standardLength: CGFloat = 0

    //カードをタップした順番
    var chooseOrder = 0

    var level = 1
    var score = 0
    var mode: String?

    var outputText: String?

    let width = UIScreen.main.bounds.size.width
    let height = UIScreen.main.bounds.size.height

    var cardArray: [UILabel] = []
    var coverArray: [UILabel] = []
    var numArray: [Int] = []

    @IBOutlet var levelLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var modeLabel: UILabel!
    @IBOutlet var highscoreLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardPerLineInCGFloatType = CGFloat(cardPerLine)

        // カードと画面両辺との間を1とすると、カードとカードの間が2、カードの一辺の長さを4となる
        standardLength = width / (cardPerLineInCGFloatType * 6)

        levelLabel.textAlignment = NSTextAlignment.center
        scoreLabel.textAlignment = NSTextAlignment.center

        levelLabel.text = " Level \(level)"
        scoreLabel.text = " Score \(score)"
               
        highScore.refer("\(mode ?? "")")
        highscoreLabel.text = "High Score \(highScore.score)"
        modeLabel.text = mode

        modeLabel.frame = CGRect(x: 0, y: height / 18, width: width / 2, height: standardLength * 2)

        levelLabel.frame = CGRect(x: width / 2, y: height / 18, width: width / 2, height: standardLength * 2)

        scoreLabel.frame = CGRect(x: 0, y: height * 2 / 18, width: width / 2, height: standardLength * 2)

        highscoreLabel.frame = CGRect(x: width / 2, y: height * 2 / 18, width: width / 2, height: standardLength * 2)

        // トップの下線のCALayerを作成
        let topBorder = CALayer()
        topBorder.frame = CGRect(x: 0, y: height * 3 / 18, width: width, height: 2.0)
        topBorder.backgroundColor = UIColor.black.cgColor

        view.layer.addSublayer(topBorder)

        setCard()

        // 最初に数字が書かれたカードは3枚
        cardCount = 3
        setNum()

    }


    func setCard() {
        // oneColumnNumの二乗枚カードを作成
        for n in 1 ... cardPerLine*cardPerLine {
            // Labelのインスタンスを作成
            let card = UILabel()

            // Labelにカードプロパティを付与
            boxProperty(label: card)

            // 数字の書かれたカードの総数を1増やす
            cardCount += 1
            cardCountInCGFloatType = CGFloat(cardCount)

            // カードがoneColumnNum(=plotForCard)の数で一行になるよう座標を定義
            let cardx = standardLength * (1 + 6 * (cardCountInCGFloatType - 1).truncatingRemainder(dividingBy: cardPerLineInCGFloatType))
            let cardy = height / 9 + 80 * ceil(cardCountInCGFloatType / cardPerLineInCGFloatType)

            // カードの座標と大きさを定義
            card.frame = CGRect(x: cardx,
                                y: cardy,
                                width: standardLength * 4,
                                height: standardLength * 4)

            // 画面にカードを追加
            view.addSubview(card)

            // カードにタグを設定
            card.tag = n

            // カード配列にカードを追加
            cardArray.append(card)
        }
    }

    /// カードに数字をランダムに割当て
    func setNum() {
        // 数字の書かれたカードの枚数
        for n in 1 ... cardCount {
            // 1〜カードの枚数分の数字配列を作成
            numArray.append(n)
        }

        // カード配列をシャッフル
        cardArray.shuffle()

        // シャッフルしたカード配列に数字を割当て
        for n in 0 ..< cardCount {
            cardArray[n].text = "\(numArray[n])"
        }

        if mode == "Very Hard" {
            // 難易度がVery Hardなら数字割当てから2秒後にカバーを作成
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.setCover()
            }
        } else {
            // 難易度がVery Hard以外なら数字割当てから3秒後にカバーを作成
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.setCover()
            }
        }
    }

    /// カバーの作成
    func setCover() {
        // oneColumnNumの二乗枚カバーを作成
        for n in 1 ... cardPerLine*cardPerLine {
            // UILabelのインスタンス作成
            let cover = UILabel()

            boxProperty(label: cover)

            // カバーの枚数を増加
            coverCount += 1
            coverPlotInCGFloatType = CGFloat(coverCount)

            // カバーがoneColumnNumの数で一行になるよう座標を定義
            let coverx = standardLength * (1 + 6 * (coverPlotInCGFloatType - 1).truncatingRemainder(dividingBy: cardPerLineInCGFloatType))
            let covery = height / 9 + 80 * ceil(coverPlotInCGFloatType / cardPerLineInCGFloatType)

            // カバーの座標とサイズを設定
            cover.frame = CGRect(x: coverx,
                                 y: covery,
                                 width: standardLength * 4,
                                 height: standardLength * 4)

            // viewにカバーを追加
            view.addSubview(cover)

            // カバーを管理するために配列に組み込む
            coverArray.append(cover)

            // UIGestureのインスタンス作成、hideアクション呼び出し
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hide(_:)))

            // カバーをタップできるようにする
            cover.isUserInteractionEnabled = true

            // カバーにタップジェスチャーを追加
            cover.addGestureRecognizer(tapGesture)
        }

        // カバーにタグを付与
        for n in 0 ..< numArray.count {
            // シャッフル後のカード配列の各カードのタグをカバー配列のカバーに割当て
            coverArray[cardArray[n].tag - 1].tag = numArray[n]
        }
    }
    
   
        //カード・カバーのプロパティを設定
        func boxProperty(label: UILabel) {
           
            label.textAlignment = NSTextAlignment.center // 横揃えの設定
            label.textColor = UIColor.black // テキストカラーの設定
            label.backgroundColor = UIColor.white
            label.layer.borderWidth = 2
            label.layer.cornerRadius = 10
            label.font = UIFont(name: "HiraKakuProN-W6", size: 17) // フォントの設定
        
    }

    /// カバーをタップした時の挙動
    @objc func hide(_ sender: UITapGestureRecognizer) {
        // タップした順番を管理
        chooseOrder += 1

        // タップした順番とカバーのタグが一致しなければGameover
        if (sender.view?.tag)! != chooseOrder {
            // カバーを除去
            sender.view?.removeFromSuperview()

            // 間違いの効果音
            sounds.playSound(fileName: "wrong", extentionName: "mp3")

            // Gameoverの画面へ
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.performSegue(withIdentifier: "gameover", sender: nil)
            }

        } else { // タップしたカバーが正しい場合
            // 正解の音源を再生
            sounds.playSound(fileName: "correct", extentionName: "mp3")

            // Gameoverにならなければスコアを10点プラス
            score += 10

            // スコアを更新
            scoreLabel.text = " Score \(score)"

            // ハイスコア更新かチェック
            highScore.updateScore(score, mode!)
            if highScore.updateOrNot {
                highscoreLabel.text = "ハイスコア: \(highScore.score)"
            }

            // カバーを除去
            sender.view?.removeFromSuperview()

            // 全てのカバーをタップ(カバーをタップした回数がレベル数より2枚多い回数まで達する)すれば次のレベルへ
            if chooseOrder == level + 2 {
                
                nextLevel()
                
            }
        }
    }
    
    func nextLevel() {
        
        // levelupの音源を再生
        sounds.playSound(fileName: "levelup", extentionName: "mp3")

        // 一度カード、カバー、枚数をリセット
        reset()

        // レベル数を1上げる
        level += 1

        // レベル数を更新
        levelLabel.text = " Level \(level)"

        // スコアを100点プラス
        score += 100

        // スコアを更新
        scoreLabel.text = " Score \(score)"

        // ハイスコア更新かチェック
        highScore.updateScore(score, mode!)
        if highScore.updateOrNot {
            highscoreLabel.text = "ハイスコア: \(highScore.score)"
        }
        
        //レベルがMaxに達した(=(カードの全枚数-1)回レベルアップを繰り返す)時の挙動
        if level == cardPerLine * cardPerLine - 1 {
            outputText = "Congratulations!!"
            performSegue(withIdentifier: "gameover", sender: nil)

        //レベルがMaxに達していない時の挙動
        } else {
            // 数字を割当てるカードの枚数を増やす
            cardCount += 1

            // 数字を割当て
            setNum()
        }
        
    }

    func reset() {
        // 全てのカードの数字をリセット
        for n in 0 ..< numArray.count {
            cardArray[n].text = ""
        }
        // 全てのカバーを隠す
        for n in 0 ..< coverArray.count {
            coverArray[n].isHidden = true
        }

        // カバー枚数、選んだ順番をリセット
        coverCount = 0
        chooseOrder = 0

        // カバー配列、数字配列をリセット
        coverArray = []
        numArray = []
    }
    
    // gameover画面に遷移する際のデータの受け渡し
    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
        if segue.identifier == "gameover" {
            let gameover = segue.destination as! GameoverViewController
            gameover.level = level
            gameover.score = score
            gameover.cardPerLine = cardPerLine
            gameover.mode = mode
            
            if highScore.updateOrNot == true {
                gameover.outputText = "New Score!!"
            }else {
                gameover.outputText = "Gameover"
            }
                
        }
    }
}


