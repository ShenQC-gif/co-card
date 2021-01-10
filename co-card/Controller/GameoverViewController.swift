//
//  GameoverViewController.swift
//  co-card
//
//  Created by ちいつんしん on 2020/11/06.
//  Copyright © 2020 ちいつんしん. All rights reserved.
//

import UIKit

class GameoverViewController: UIViewController {
    
    var screenShot = ScreenShot()
    var level = Level()
    var score = Score()
    var mode = Mode()
    
    var outputText: String?

    @IBOutlet var outputLabel: UILabel!
    @IBOutlet var levelLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var modeLabel: UILabel!
    @IBOutlet var again: UIButton!
    @IBOutlet var home: UIButton!
    @IBOutlet var share: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        again.layer.borderWidth = 2
        home.layer.borderWidth = 2
        share.layer.borderWidth = 2

        outputLabel.text = outputText
        levelLabel.text = "Level \(level.currentLevel())"
        scoreLabel.text = "Score \(score.currenScore())"
        modeLabel.text = mode.title
    }

    @IBAction func onShareButtonTapped(_: Any) {
        
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        
        let size = CGSize(width: width, height: height * 12 / 24)
        
        let activityVC = screenShot.share(size: size, width: width, height: height, view: view)
        
        present(activityVC, animated: true, completion: nil)
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
        if segue.identifier == "toMain" {
            let playscreen = segue.destination as! MainViewController
            playscreen.mode = mode
        }
    }
}
