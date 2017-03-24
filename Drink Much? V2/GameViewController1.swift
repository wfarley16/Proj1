//
//  GameViewController1.swift
//  Drink Much? V2
//
//  Created by William Farley on 2/26/17.
//  Copyright © 2017 William Farley. All rights reserved.
//

import UIKit

class GameViewController1: UIViewController {
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    @IBOutlet weak var tryAgainButton: UIButton!
        
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var instructionsLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    var round = 0
    var score = 0
    var selectedButton: Int = -1
    var lastButton: Int = -1
    
    var highScore: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if highScore != 0 {
            highScoreLabel.text = "High Score: \(highScore)"
        } else {
            highScoreLabel.isHidden = true
            highScore = 0
        }
        
        tryAgainButton.isHidden = true
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UnwindToVCFromGameVC" {
            let destinationVC = segue.destination as! ViewController
            destinationVC.highScore = highScore!
        }
    }
    
    //MARK:- Functions
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func stopGame() {
        timeLabel.text = "Game Over"
        button1.isEnabled = false
        button2.isEnabled = false
        button3.isEnabled = false
        
        if score > highScore! {
            if score > highScore! {
                highScore = score
                scoreLabel.text = "New High Score: \(score)"
            } else {
            scoreLabel.text = "Your Score: \(score)" }
        }
        
        highScoreLabel.isHidden = false
        highScoreLabel.text = "High Score: \(highScore!)"
        
        tryAgainButton.isHidden = false
    }

    func checkButtonColor(_ selectedButton: Int) {
        
        switch selectedButton {
        case 0:
            if lastButton == -1 || lastButton == 0 {
                score = score + 1
            } else {
                stopGame()
                showAlert(title: "Game Over", message: "You Hit A Red Button!")
            }
        case 1:
            if lastButton == -1 || lastButton == 1 {
                score = score + 1
            } else {
                stopGame()
                showAlert(title: "Game Over", message: "You Hit A Red Button!")
            }
        case 2:
            if lastButton == -1 || lastButton == 2 {
                score = score + 1
            } else {
                stopGame()
                showAlert(title: "Game Over", message: "You Hit A Red Button!")
            }
        default:
            print("Something went wrong")
        }
    }
    
    func newRound() {
        label1.backgroundColor = UIColor.red
        label2.backgroundColor = UIColor.red
        label3.backgroundColor = UIColor.red
        round = round + 1
        if round == 1 {
            timeLabel.text = "Your 15 Seconds Have Started!"
            Timer.scheduledTimer(timeInterval: 15, target: self, selector: #selector(GameViewController1.stopGame), userInfo: nil, repeats: false)
        }
    }
    
    func randomButton() {
        var randomNumber: Int
        
        repeat {
            randomNumber = Int(arc4random_uniform(3))
        } while randomNumber == lastButton
        
        switch randomNumber {
        case 0:
            label1.backgroundColor = UIColor.green
        case 1:
            label2.backgroundColor = UIColor.green
        case 2:
            label3.backgroundColor = UIColor.green
        default:
            print("Something went wrong")
        }
        
        lastButton = randomNumber
    }
    
    // MARK:- Actions
    
    @IBAction func button1Pressed(_ sender: UIButton) {
        instructionsLabel.text = "Press The Green Button!"
        checkButtonColor(0)
        scoreLabel.text = "Score: \(score)"
        newRound()
        randomButton()
    }

    @IBAction func button2Pressed(_ sender: UIButton) {
        instructionsLabel.text = "Press The Green Button!"
        checkButtonColor(1)
        scoreLabel.text = "Score: \(score)"
        newRound()
        randomButton()
    }

    @IBAction func button3Pressed(_ sender: UIButton) {
        instructionsLabel.text = "Press The Green Button!"
        checkButtonColor(2)
        scoreLabel.text = "Score: \(score)"
        newRound()
        randomButton()
    }

    @IBAction func tryAgainPressed(_ sender: UIButton) {
        button1.isEnabled = true
        button2.isEnabled = true
        button3.isEnabled = true
        label1.backgroundColor = UIColor.green
        label2.backgroundColor = UIColor.green
        label3.backgroundColor = UIColor.green
        score = 0
        round = 0
        lastButton = -1
        scoreLabel.text = "Score:"
        highScoreLabel.text = "High Score: \(highScore!)"
        instructionsLabel.text = "Press Any Button To Start"
        tryAgainButton.isHidden = true
        timeLabel.text = "Once You Start, You Have 15 Seconds"
    }
    
}
