//
//  HomeViewController.swift
//  co-card
//
//  Created by ちいつんしん on 2020/11/06.
//  Copyright © 2020 ちいつんしん. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var modeNum = 0
    var oneColumnNum: CGFloat = 0
    let width = UIScreen.main.bounds.size.width
    let height = UIScreen.main.bounds.size.height

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var mode: UILabel!
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

        mode.frame = CGRect(x: 0,
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

        checkMode()
    }

    @IBAction func nextmode(_: Any) {
        modeNum += 1
        checkMode()
    }

    @IBAction func previousmode(_: Any) {
        modeNum -= 1
        checkMode()
    }

    func checkMode() {
        switch modeNum {
        case -1:
            mode.text = "Easy"
            previousMode.isHidden = true
            oneColumnNum = 4

        case 0:
            mode.text = "Normal"
            nextMode.isHidden = false
            previousMode.isHidden = false
            oneColumnNum = 5

        case 1:
            mode.text = "Hard"
            nextMode.isHidden = false
            previousMode.isHidden = false
            oneColumnNum = 6

        case 2:
            mode.text = "Very Hard"
            nextMode.isHidden = true
            oneColumnNum = 6

        default:
            break
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
        if segue.identifier == "toMain" {
            let playscreen = segue.destination as! MainViewController
            playscreen.oneColumnNum = oneColumnNum
            playscreen.mode = mode.text
        }
    }
}
