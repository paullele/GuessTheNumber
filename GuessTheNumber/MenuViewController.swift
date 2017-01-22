//
//  MenuViewController.swift
//  GuessTheNumber
//
//  Created by apple on 11/01/2017.
//  Copyright © 2017 apple. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet private weak var rangeLabel: UITextField!
    @IBOutlet private weak var tipsOption: UISwitch!
    @IBOutlet private weak var attemptsLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var getRange: Int {
        get {
            if let range = Int(rangeLabel.text!) {
                if range == 0 {
                    return 10
                } else {
                    return range
                }
            } else {
                return 10
            }
        }
    }
    
    var getTips: Bool {
        get {
            return tipsOption.isOn
        }
    }
    
    var getAttempts: Int {
        get {
            if let attempts = Int(attemptsLabel.text!) {
                if attempts == 0 {
                    return 1
                } else {
                    return attempts
                }
            } else {
                return 1
            }
        }
    }

    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        rangeLabel.resignFirstResponder()
        attemptsLabel.resignFirstResponder()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "StartGame" {
            if let gameViewController = segue.destination as? GameViewController {
                gameViewController.range = getRange
                gameViewController.tips = getTips
                gameViewController.attempts = getAttempts
            }
        }

    }
 

}
