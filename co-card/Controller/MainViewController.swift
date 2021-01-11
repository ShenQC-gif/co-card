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
    var highScore = HighScore()
    var score = Score()
    var level = Level()
    var mode = Mode()
    
    //カード総数
    var totalCard = Int()
    //数字の書かれるカードの枚数
    var cardWithNumber = Int()
    //カードをタップした順番
    var tapOrder = Int()
    var outputText: String?
    var cardArray: [UILabel] = []
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var topViewButtomBorder: UILabel!
    @IBOutlet var levelLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var modeLabel: UILabel!
    @IBOutlet var highscoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        totalCard = mode.cardPerLine*mode.cardPerLine
        levelLabel.text = "Level \(level.currentLevel())"
        scoreLabel.text = "Score \(score.currenScore())"
        highscoreLabel.text = "High Score \(highScore.currentHighScore(mode.title))"
        modeLabel.text = mode.title
        
        //topViewにボーダーを追加
        topViewButtomBorder.layer.borderWidth = 2
        
        setCard()
        
        // 最初に数字が書かれたカードは3枚
        cardWithNumber = 3
        setNum()
        
    }
    
    func setCard() {
        
        // カードを作成
        for n in 1 ... totalCard {
            
            // Labelのインスタンスを作成
            let card = UILabel()
            
            // Labelにカードプロパティを付与
            cardProperty(label: card)
            
            let width = UIScreen.main.bounds.size.width
            let height = UIScreen.main.bounds.size.height
            
            // 数字の書かれたカードの総数を1増やす
            let cardOrderInCGFloatType = CGFloat(n)
            
            let cardPerLineInCGFloatType = CGFloat(mode.cardPerLine)
            // カードと画面両辺との間を1とすると、カードとカードの間が2、カードの一辺の長さを4となる
            let standardLength = width / (cardPerLineInCGFloatType * 6)
            
            
            // カードがoneColumnNumの数で一行になるよう座標を定義
            let cardx = standardLength * (1 + 6 * (cardOrderInCGFloatType - 1).truncatingRemainder(dividingBy: cardPerLineInCGFloatType))
            let cardy = height * 0.15 + 80 * ceil(cardOrderInCGFloatType / cardPerLineInCGFloatType)
            
            // カードの座標と大きさを定義
            card.frame = CGRect(x: cardx,
                                y: cardy,
                                width: standardLength * 4,
                                height: standardLength * 4)
            
            // 画面にカードを追加
            view.addSubview(card)
            // カード配列にカードを追加
            cardArray.append(card)
        }
        
        for card in cardArray{
            // UIGestureのインスタンス作成、hideアクション呼び出し
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onCardTapped(_:)))
            
            // カードにタップジェスチャーを追加
            card.addGestureRecognizer(tapGesture)
        }
    }
    
    /// カードに数字をランダムに割当て
    func setNum() {
        
        // カード配列をシャッフル
        cardArray.shuffle()
        
        // cardWithNumberの数だけカードに数字とタグを付与
        for n in 1 ... cardWithNumber {
            // 1〜カードの枚数分の数字配列を作成
            cardArray[n].text = "\(n)"
            cardArray[n].tag = n
        }
        
        changeCardTextColor(.black)
        ifCardCanBeTapped(false)
        
        if mode == .VeryHard {
            // 難易度がVery Hardなら数字割当てから2秒後にカードを作成
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.changeCardTextColor(.white)
                // カードをタップできるようにする
                self.ifCardCanBeTapped(true)
            }
        } else {
            // 難易度がVery Hard以外なら数字割当てから3秒後にカードを作成
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.changeCardTextColor(.white)
                // カードをタップできるようにする
                self.ifCardCanBeTapped(true)
                
            }
        }
    }
    
    func changeCardTextColor(_ color: UIColor){
        
        for card in cardArray{
            card.textColor = color
        }
        
    }
    
    func ifCardCanBeTapped(_ trueOrNot: Bool){
        for card in self.cardArray{
            card.isUserInteractionEnabled = trueOrNot
        }
    }
    
    /// カードをタップした時の挙動
    @objc func onCardTapped(_ sender: UITapGestureRecognizer) {
        // タップした順番を管理
        tapOrder += 1
        
        //タップされたら数字を表示し、再度タップできないようにする
        let card = (sender.view) as UIView? as? UILabel
        card?.textColor = .black
        card?.isUserInteractionEnabled = false
        
        // タップした順番とカードの数字(=タグ)が一致しなければGameover
        if (sender.view?.tag)! != tapOrder {
            
            // 間違いの効果音
            sounds.playSound(fileName: "wrong", extentionName: "mp3")
            
            // Gameoverの画面へ
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.performSegue(withIdentifier: "gameover", sender: nil)
            }
            
        } else { // タップしたカードが正しい場合
            // 正解の音源を再生
            sounds.playSound(fileName: "correct", extentionName: "mp3")
            
            // Gameoverにならなければスコアを10点プラス
            score.plus(point: 10)
            
            // スコアを更新
            scoreLabel.text = "Score \(score.currenScore())"
            
            // ハイスコア更新かチェック
            highScore.updateScore(score.score, mode.title)
            highscoreLabel.text = "High Score \(highScore.currentHighScore(mode.title))"
            
            // 全てのカードをタップ(カードをタップした回数がレベル数より2枚多い回数まで達する)すれば次のレベルへ
            if tapOrder == level.level + 2 {
                
                nextLevel()
                
            }
        }
    }
    
    //カードのプロパティを設定
    func cardProperty(label: UILabel) {
        
        label.textAlignment = NSTextAlignment.center // 横揃えの設定
        label.textColor = UIColor.black // テキストカラーの設定
        label.backgroundColor = UIColor.white
        label.layer.borderWidth = 2
        label.layer.cornerRadius = 10
        label.font = UIFont(name: "HiraKakuProN-W6", size: 17) // フォントの設定
        
    }
    
    func nextLevel() {
        
        // levelupの音源を再生
        sounds.playSound(fileName: "levelup", extentionName: "mp3")
        
        // 一度カード、枚数をリセット
        reset()
        
        level.nextLevel()
        levelLabel.text = "Level \(level.currentLevel())"
        
        // スコアを100点プラス
        score.plus(point: 100)
        // スコアを更新
        scoreLabel.text = "Score \(score.currenScore())"
        
        // ハイスコア更新かチェック
        highScore.updateScore(score.score, mode.title)
        highscoreLabel.text = "High Score \(highScore.currentHighScore(mode.title))"
        
        //レベルがMaxに達した(=(カードの全枚数-1)回レベルアップを繰り返す)時の挙動
        if level.level == totalCard - 1 {
            outputText = "Congratulations!!"
            performSegue(withIdentifier: "gameover", sender: nil)
            
            //レベルがMaxに達していない時の挙動
        } else {
            // 数字を割当てるカードの枚数を増やす
            cardWithNumber += 1
            
            // 数字を割当て
            setNum()
        }
        
    }
    
    func reset() {
        // 全てのカードの数字をリセット
        for card in cardArray {
            card.text = ""
        }
        // 選んだ順番をリセット
        tapOrder = 0
        
    }
    
    // gameover画面に遷移する際のデータの受け渡し
    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
        if segue.identifier == "gameover" {
            let gameover = segue.destination as! GameoverViewController
            gameover.level.level = level.level
            gameover.score.score = score.score
            gameover.mode = mode
            
            if highScore.updatedOrNot == true {
                gameover.outputText = "New Score!!"
            }else {
                gameover.outputText = "Gameover"
            }
            
        }
    }
}


