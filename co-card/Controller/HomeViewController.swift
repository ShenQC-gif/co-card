//
//  HomeViewController.swift
//  co-card
//
//  Created by ちいつんしん on 2020/11/06.
//  Copyright © 2020 ちいつんしん. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    var mode = Mode()

    let width = UIScreen.main.bounds.size.width
    let height = UIScreen.main.bounds.size.height
    

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var modeLabel: UILabel!
    @IBOutlet var nextModeButton: UIButton!
    @IBOutlet var previousModeButton: UIButton!
    @IBOutlet var start: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.frame = CGRect(x: 0,
                                  y: height * 1 / 8,
                                  width: width,
                                  height: height / 8)

        previousModeButton.frame = CGRect(x: width / 20,
                                    y: height * 3 / 8,
                                    width: width * 2 / 10,
                                    height: height / 8)

        modeLabel.frame = CGRect(x: 0,
                            y: height * 3 / 8,
                            width: width,
                            height: height / 8)

        nextModeButton.frame = CGRect(x: width * 15 / 20,
                                y: height * 3 / 8,
                                width: width * 2 / 10,
                                height: height / 8)

        start.frame = CGRect(x: width * 5 / 16,
                             y: height * 5.5 / 8,
                             width: width * 3 / 8,
                             height: height / 12)

        start.layer.borderWidth = 2
        start.layer.cornerRadius = 10

        modeLabel.text = mode.title
        
    }

    @IBAction func onNextModeButtonTapped(_: Any) {
        
        mode.nextMode()
        modeLabel.text = mode.title
        nextModeButton.isHidden = !mode.nextModeExists()
        previousModeButton.isHidden = !mode.previousModeExists()
        
    }

    @IBAction func onPreviousModeButtonTapped(_: Any) {
        
        mode.previousMode()
        modeLabel.text = mode.title
        nextModeButton.isHidden = !mode.nextModeExists()
        previousModeButton.isHidden = !mode.previousModeExists()
        
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
        if segue.identifier == "toMain" {
            let playscreen = segue.destination as! MainViewController
            playscreen.mode = mode
        }
    }
}
