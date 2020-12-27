//
//  HomeViewController.swift
//  co-card
//
//  Created by ちいつんしん on 2020/11/06.
//  Copyright © 2020 ちいつんしん. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    var mode : Mode = .Normal

    var cardPerLine = 0
    let width = UIScreen.main.bounds.size.width
    let height = UIScreen.main.bounds.size.height
    

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var modeLabel: UILabel!
    @IBOutlet var nextMode: UIButton!
    @IBOutlet var previousMode: UIButton!
    @IBOutlet var start: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.frame = CGRect(x: 0,
                                  y: height * 1 / 8,
                                  width: width,
                                  height: height / 8)

        previousMode.frame = CGRect(x: width / 20,
                                    y: height * 3 / 8,
                                    width: width * 2 / 10,
                                    height: height / 8)

        modeLabel.frame = CGRect(x: 0,
                            y: height * 3 / 8,
                            width: width,
                            height: height / 8)

        nextMode.frame = CGRect(x: width * 15 / 20,
                                y: height * 3 / 8,
                                width: width * 2 / 10,
                                height: height / 8)

        start.frame = CGRect(x: width * 5 / 16,
                             y: height * 5.5 / 8,
                             width: width * 3 / 8,
                             height: height / 12)

        start.layer.borderWidth = 2
        start.layer.cornerRadius = 10

        reflectMode()
        
    }

    @IBAction func nextMode(_: Any) {
        
        mode = mode.next ?? mode
       
        if mode.next == nil{
            nextMode.isHidden = true
            nextMode.setTitleColor(UIColor.gray, for: .normal)
        }else {
            previousMode.isHidden = false
            previousMode.setTitleColor(UIColor.black, for: .normal)
        }
        
        reflectMode()
    }

    @IBAction func previousMode(_: Any) {
        
        mode = mode.previous ?? mode
        
        if mode.previous == nil{
            previousMode.isHidden = true
            previousMode.setTitleColor(UIColor.gray, for: .normal)
        }else {
            nextMode.isHidden = false
            nextMode.setTitleColor(UIColor.black, for: .normal)
        }
    
        reflectMode()
        
    }

    func reflectMode() {
        
        modeLabel.text = mode.title
            
        //一行あたりのカードの枚数を難易度毎に設定
        switch mode {
        
        case .Easy:
            cardPerLine = 4
        case .Normal:
            cardPerLine = 5
        case .Hard:
            cardPerLine = 6
        case .VeryHard:
            cardPerLine = 6
            
        }

    }

    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
        if segue.identifier == "toMain" {
            let playscreen = segue.destination as! MainViewController
            playscreen.cardPerLine = cardPerLine
            playscreen.mode = mode
        }
    }
}
