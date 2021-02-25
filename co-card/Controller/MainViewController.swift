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
    
    private var sounds = Sounds()
    private var highScore = HighScore()
    private var score = CurrentScore()
    private var level = CurrentLevel()
    private var modeTitle = ModeTitle()
    private var cardLabel = CardLabel()
    var mode = Mode()

    static let menuHegiht = UIScreen.main.bounds.size.height*0.15
    
    private let modeLabel:UILabel={
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "HiraKakuProN-W6", size: 20)
        return label
    }()
    
    private let levelLabel:UILabel={
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "HiraKakuProN-W6", size: 20)
        return label
    }()
    
    private let scoreLabel:UILabel={
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "HiraKakuProN-W6", size: 20)
        return label
    }()
    
    private let highScoreLabel:UILabel={
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "HiraKakuProN-W6", size: 20)
        return label
    }()

    //カード総数
    private var totalCard = Int()
    //数字の書かれるカードの枚数
    private var cardWithNumber = Int()
    //カードをタップした順番
    private var tapOrder = Int()
    private var outputText: String?
    private var cardArray: [UILabel] = []
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        var safeAreaTop = CGFloat()
        let width = UIScreen.main.bounds.size.width
        
        if #available(iOS 11.0, *) {
            safeAreaTop = self.view.safeAreaInsets.top
        }
        
        modeLabel.frame = CGRect(x: 0, y: safeAreaTop, width: width/2, height: MainViewController.menuHegiht/2)
        
        levelLabel.frame = CGRect(x: width/2, y: safeAreaTop, width: width/2, height: MainViewController.menuHegiht/2)
        
        scoreLabel.frame = CGRect(x: 0, y: safeAreaTop + MainViewController.menuHegiht/2, width: width/2, height: MainViewController.menuHegiht/2)
        
        highScoreLabel.frame = CGRect(x: width/2, y: safeAreaTop + MainViewController.menuHegiht/2, width: width/2, height: MainViewController.menuHegiht/2)

        view.addSubview(modeLabel)
        view.addSubview(levelLabel)
        view.addSubview(scoreLabel)
        view.addSubview(highScoreLabel)

        let menuBottomBorder = CALayer()
        
        menuBottomBorder.frame = CGRect(x: 0, y: safeAreaTop + MainViewController.menuHegiht, width: width, height: 2)

        menuBottomBorder.backgroundColor = UIColor.black.cgColor

        view.layer.addSublayer(menuBottomBorder)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        totalCard = mode.cardPerLine*mode.cardPerLine
        
        levelLabel.text = "Level \(level.currentLevel())"
        scoreLabel.text = "Score \(score.currenScore())"
        highScoreLabel.text = "High Score \(highScore.currentHighScore(modeTitle.returnTitle(mode:mode)))"
        modeLabel.text = modeTitle.returnTitle(mode:mode)
        
        setCard()
        
        // 最初に数字が書かれたカードは3枚
        cardWithNumber = 3
        setNum()
        
    }
    
    private func setCard() {
        
        // カードを作成
        for n in 1 ... totalCard {
            
            let card = cardLabel.createCard(mode: mode, numberOfCard: n)
            
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
    private func setNum() {
        
        // カード配列をシャッフル
        cardArray.shuffle()
        
        // cardWithNumberの数だけカードに数字とタグを付与
        for n in 1 ... cardWithNumber {
            cardArray[n].text = "\(n)"
            cardArray[n].tag = n
        }
        
        changeCardTextColor(.black)
        ifCardCanBeTapped(false)
        
        if mode == .VeryHard {
            // 難易度がVery Hardなら数字割当てから2秒後にカードの文字が消える
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.changeCardTextColor(.white)
                self.ifCardCanBeTapped(true)
            }
        } else {
            // 難易度がVery Hard以外なら数字割当てから3秒後にカードの文字が消える
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.changeCardTextColor(.white)
                self.ifCardCanBeTapped(true)
                
            }
        }
    }
    
    private func changeCardTextColor(_ color: UIColor){
        
        for card in cardArray{
            card.textColor = color
        }
        
    }
    
    private func ifCardCanBeTapped(_ trueOrNot: Bool){
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
            pointPlus(point: 10)
            
            // 全てのカードをタップ(カードをタップした回数がレベル数より2枚多い回数まで達する)すれば次のレベルへ
            if tapOrder == level.level + 2 {
                
                nextLevel()
                
            }
        }
    }
    
    private func nextLevel() {
        
        // levelupの音源を再生
        sounds.playSound(fileName: "levelup", extentionName: "mp3")
        
        // 一度カードの表示、枚数をリセット
        reset()
        
        level.nextLevel()
        levelLabel.text = "Level \(level.currentLevel())"
        
        // スコアを100点プラス
        pointPlus(point: 100)
        
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
    
    ///スコアを加点し、ハイスコア更新かチェック
    private func pointPlus(point:Int){
        
        score.plus(point: point)
        // スコアを更新
        scoreLabel.text = "Score \(score.currenScore())"
        
        // ハイスコア更新かチェック
        highScore.updateScore(score.score, modeTitle.returnTitle(mode:mode))
        highScoreLabel.text = "High Score \(highScore.currentHighScore(modeTitle.returnTitle(mode:mode)))"
        
    }
    
    private func reset() {
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


