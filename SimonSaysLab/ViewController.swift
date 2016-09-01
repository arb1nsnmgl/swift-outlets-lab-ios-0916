//
//  ViewController.swift
//  SimonSaysLab
//
//  Created by James Campagno on 5/31/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayColorView: UIView!
    @IBOutlet weak var startGameButton: UIButton!
    @IBOutlet weak var winLabel: UILabel!
    @IBOutlet weak var redBtn: UIButton!
    @IBOutlet weak var greenBtn: UIButton!
    @IBOutlet weak var blueBtn: UIButton!
    @IBOutlet weak var yellowBtn: UIButton!
    
    @IBAction func redButton(sender: AnyObject) {
        simonSaysGame.guessRed()
        buttonsClicked += 1
        print("Your guessed is: \(self.simonSaysGame.chosenColors)")
        checkGuessedColor()
        
    }
    
    @IBAction func greenButton(sender: AnyObject) {
        simonSaysGame.guessGreen()
        buttonsClicked += 1
        print("Your guessed is: \(self.simonSaysGame.chosenColors)")
        checkGuessedColor()
        
    }
    
    @IBAction func yellowButton(sender: AnyObject) {
        simonSaysGame.guessYellow()
        buttonsClicked += 1
        print("Your guessed is: \(self.simonSaysGame.chosenColors)")
        checkGuessedColor()
    }
    
    @IBAction func blueButton(sender: AnyObject) {
        simonSaysGame.guessBlue()
        buttonsClicked += 1
        print("Your guessed is: \(self.simonSaysGame.chosenColors)")
        checkGuessedColor()
    }
    
    var simonSaysGame = SimonSays()
    var buttonsClicked = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        winLabel.hidden = true
        redBtn.enabled = false
        blueBtn.enabled = false
        greenBtn.enabled = false
        yellowBtn.enabled = false
        
    }
}

// MARK: - SimonSays Game Methods
extension ViewController {
    
    @IBAction func startGameTapped(sender: UIButton) {
        UIView.transitionWithView(startGameButton, duration: 0.9, options: .TransitionFlipFromBottom , animations: {
            self.startGameButton.hidden = true
            }, completion: nil)
        
        displayTheColors()
        enableColoredButtons()
    }
    
    private func displayTheColors() {
        self.view.userInteractionEnabled = false
        UIView.transitionWithView(displayColorView, duration: 1.5, options: .TransitionCurlUp, animations: {
            self.displayColorView.backgroundColor = self.simonSaysGame.nextColor()?.colorToDisplay
            self.displayColorView.alpha = 0.0
            self.displayColorView.alpha = 1.0
            }, completion: { _ in
                if !self.simonSaysGame.sequenceFinished() {
                    self.displayTheColors()
                } else {
                    self.view.userInteractionEnabled = true
                    print("Pattern to match: \(self.simonSaysGame.patternToMatch)")
                }
        })
    }
    
    func checkGuessedColor() {
        if self.simonSaysGame.chosenColors ==  self.simonSaysGame.patternToMatch {
            simonSaysGame.wonGame()
            winLabel.hidden = false
            winLabel.text = "You won!"
        } else if self.simonSaysGame.chosenColors.count >= 5 {
            winLabel.hidden = false
            winLabel.text = "Nope, try again."
        }
    }
    
    func enableColoredButtons() {
        redBtn.enabled = true
        blueBtn.enabled = true
        greenBtn.enabled = true
        yellowBtn.enabled = true
    }
    
}
