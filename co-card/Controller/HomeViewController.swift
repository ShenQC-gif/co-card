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
    var modeTitle = ModeTitle()

    @IBOutlet var modeLabel: UILabel!
    @IBOutlet var nextModeButton: UIButton!
    @IBOutlet var previousModeButton: UIButton!
    @IBOutlet var start: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        start.layer.borderWidth = 2
        start.layer.cornerRadius = 10

        modeLabel.text = modeTitle.returnTitle(mode:mode)
        
    }

    @IBAction func onNextModeButtonTapped(_: Any) {
        
        mode.nextMode()
        modeLabel.text = modeTitle.returnTitle(mode:mode)
        nextModeButton.isHidden = !mode.nextModeExists()
        previousModeButton.isHidden = !mode.previousModeExists()
        
    }

    @IBAction func onPreviousModeButtonTapped(_: Any) {
        
        mode.previousMode()
        modeLabel.text = modeTitle.returnTitle(mode:mode)
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
