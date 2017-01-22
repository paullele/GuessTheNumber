//
//  ViewController.swift
//  GuessTheNumber
//
//  Created by apple on 11/01/2017.
//  Copyright © 2017 apple. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        gameStatus.text = "Your guess is..."
        secretNumber = gameLogic.generateNumber(upTo: range!)
        attemptsStatus.text = String(attempts!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var range: Int?
    var tips: Bool?
    var attempts: Int?
    private var guessed = false
    private let gameLogic = GameLogic()
    private var secretNumber: Int?
    
    
    @IBOutlet weak var gameStatus: UILabel!
    @IBOutlet weak var guessingBox: UITextField!
    @IBOutlet weak var guessButton: UIButton!
    @IBOutlet weak var attemptsStatus: UILabel!
    
    func manageEndGame() {
        guessButton.isUserInteractionEnabled = false
        guessed = true
        guessingBox.resignFirstResponder()
        guessingBox.isUserInteractionEnabled = false
    }
    
    @IBAction func onGuessButton(_ sender: UIButton) {

        if getGuess >= 0 {
            if(getGuess == secretNumber) {
                gameStatus.text = "Correct!"
                manageEndGame()
                
            } else {
                gameStatus.text = gameLogic.giveTipMessage(tipsAllowed: tips!, guessing: getGuess, secret: secretNumber!)
                guessingBox.text = nil
                gameLogic.checksAttempts(&attempts!)
                attemptsStatus.text! = String(attempts!)
                
                if gameLogic.gameOver(attempts!) {
                    gameStatus.text = "Game Over"
                    manageEndGame()
                }
            } 
        }
    }
    
    @IBAction func newGame(_ sender: UIButton) {
        if !guessed || !gameLogic.gameOver(attempts!) {
            let alert = UIAlertController(title: "New Game", message: "Are you sure?", preferredStyle: .actionSheet)
            
            let yesAction = UIAlertAction(title: "Yes", style: .destructive, handler: {
                action in self.performSegue(withIdentifier: "NewGame", sender: UIButton())
            })
            
            let noAction = UIAlertAction(title: "No", style: .cancel, handler: nil)
            
            alert.addAction(yesAction)
            alert.addAction(noAction)
            
            if let ppc = popoverPresentationController {
                ppc.sourceView = sender
                ppc.sourceRect = sender.bounds
            }
            
            present(alert, animated: true, completion: nil)
        }
    }
    
    var getGuess: Int {
        get {
            if let guess = Int(guessingBox.text!) {
                return guess
            } else {
                return -1
            }
        }
 
    }


}

