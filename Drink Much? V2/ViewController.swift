//
//  ViewController.swift
//  Drink Much? V2
//
//  Created by William Farley on 2/6/17.
//  Copyright © 2017 William Farley. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var drinkerImage: UIImageView!
    @IBOutlet weak var drinkCountLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var resetLabel: UIButton!
    @IBOutlet weak var bacLabel: UILabel!
    
    var weightTollerance: Double = 0.0
    var drinkCount = 0
    var relativeDrinkCount: Double = 0
    var BAC: Double = 0
    
    var highScore = 0
    
    var firstDrinkTime = 0.0
    var liabilityWaiverAccepted: Bool = false
    
    var defaultsData = UserDefaults.standard
    
    let messages = ["I Solemnly Swear That I Am Up to No Good",
                    "That's A Start",
                    "Two Down. I told you I can drink, Mom",
                    "Third Time's The Charm",
                    "Hey, Look! I think we just crossed the legal limit!",
                    "Cinco De Cerveza!",
                    "What time is it? Sex O'Clock? lol",
                    "Why was six afraid of seven?",
                    "I don't know. I didn't take Psych",
                    "Ho Gome You're Drunk",
                    "Actually Just Clear Your Schedule for the Morning",
                    "Man, You're Getting Fucked Tonight",
                    "Guess What Number You're At. Wait, don't look.",
                    "No, This is Number 13... You Might Have a Problem",
                    "Give Someone Your Phone. It's Dangerous"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        weightTollerance = defaultsData.double(forKey: "weightTollerance")
        
        drinkCount = defaultsData.integer(forKey: "drinkCount")
        
        defaultsData.set(drinkCount, forKey: "drinkCount")
        
        relativeDrinkCount = defaultsData.double(forKey: "relativeDrinkCount")
        
        liabilityWaiverAccepted = defaultsData.bool(forKey: "liabilityWaiverAccepted")
        
        highScore = defaultsData.integer(forKey: "careerHighScore")
        
        if highScore == 0 {
            defaultsData.set(highScore, forKey: "careerHighScore")
        }
        
        BAC = relativeDrinkCount * weightTollerance
        
        updateLabels()
        
        if drinkCount == 0 {
            resetLabel.isHidden = true
        } else {
            resetLabel.isHidden = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GameViewController1" {
            let secondViewController = segue.destination as? GameViewController1
            let highScoreDummy = sender as? Int
            secondViewController?.careerHighScore = highScoreDummy
        }
    }
    
    // MARK: - Functions
    
    func showAlert(title: String, message: String, dismissMessage: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: dismissMessage, style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func updateLabels() {
        drinkCountLabel.text = "Drink Count: \(drinkCount)"
        bacLabel.text = "Expected BAC: \(BAC)"
        messageLabel.text = messages[drinkCount]
    }
    
    func timer() {
        let currentTime = NSTimeIntervalSince1970
        let elapsedTime = Int(currentTime - firstDrinkTime)

        let timeInvervals = [3600,
                             7200,
                             10800,
                             14400,
                             18000,
                             21600,
                             25200,
                             28800,
                             32400,
                             36000,
                             39600,
                             43200]
        
        switch elapsedTime {
        case 0 ..< timeInvervals[0]:
            hoursLabel.text = "Hours Elapsed: Less Than 1"
        case timeInvervals[0] ..< timeInvervals[1]:
            relativeDrinkCount = Double(drinkCount) - 1
            hoursLabel.text = "Hours Elapsed: 1"
        case timeInvervals[1] ..< timeInvervals[2]:
            relativeDrinkCount = Double(drinkCount) - 2
            hoursLabel.text = "Hours Elapsed: 2"
        case timeInvervals[2] ..< timeInvervals[3]:
            relativeDrinkCount = Double(drinkCount) - 3
            hoursLabel.text = "Hours Elapsed: 3"
        case timeInvervals[3] ..< timeInvervals[4]:
            relativeDrinkCount = Double(drinkCount) - 4
            hoursLabel.text = "Hours Elapsed: 4"
        case timeInvervals[4] ..< timeInvervals[5]:
            relativeDrinkCount = Double(drinkCount) - 5
            hoursLabel.text = "Hours Elapsed: 5"
        case timeInvervals[5] ..< timeInvervals[6]:
            relativeDrinkCount = Double(drinkCount) - 6
            hoursLabel.text = "Hours Elapsed: 6"
        case timeInvervals[6] ..< timeInvervals[7]:
            relativeDrinkCount = Double(drinkCount) - 7
            hoursLabel.text = "Hours Elapsed: 7"
        case timeInvervals[7] ..< timeInvervals[8]:
            relativeDrinkCount = Double(drinkCount) - 8
            hoursLabel.text = "Hours Elapsed: 8"
        case timeInvervals[8] ..< timeInvervals[9]:
            relativeDrinkCount = Double(drinkCount) - 9
            hoursLabel.text = "Hours Elapsed: 9"
        case timeInvervals[9] ..< timeInvervals[10]:
            relativeDrinkCount = Double(drinkCount) - 10
            hoursLabel.text = "Hours Elapsed: 10"
        case timeInvervals[10] ..< timeInvervals[11]:
            relativeDrinkCount = Double(drinkCount) - 11
            hoursLabel.text = "Hours Elapsed: 11"
        case timeInvervals[11] ..< timeInvervals[12]:
            relativeDrinkCount = Double(drinkCount) - 12
            hoursLabel.text = "Hours Elapsed: 12"
        default:
            hoursLabel.text = "Hours Elapsed: Greater Than 12"
        }

    }
    
    func markFirstDrinkTime() {
        if drinkCount == 1 {
            firstDrinkTime = NSTimeIntervalSince1970
            defaultsData.set(firstDrinkTime, forKey: "firstDrinkTime")
            if liabilityWaiverAccepted == false {
                showAlert(title: "Terms And Conditions", message: "You Can Read Our Terms And Conditions on Our Website (insert link). Press Accept to Continue", dismissMessage: "Accept")
                liabilityWaiverAccepted = true
                defaultsData.set(true, forKey: "liabilityWaiverAccepted")
            }
        }
    }
    
    func checkIfWeightInputted() {
        if weightTollerance == 0.0 {
            weightTollerance = 0.02
            showAlert(title: "Please Enter Weight in User Info", message: "For Now We'll Just Set You to 0.02 Per Drink.", dismissMessage: "Ok")
        }
    }
    
    // MARK: - Actions
    
    @IBAction func addDrinkPressed(_ sender: UIButton) {
        
        resetLabel.isHidden = false
        
        drinkCount = drinkCount + 1
        
        markFirstDrinkTime()
        
        checkIfWeightInputted()
        
        relativeDrinkCount = relativeDrinkCount + 1
        
        if relativeDrinkCount == 14 {
            showAlert(title: "That's As High As We Go", message: "Sorry if you're actually still drinking.", dismissMessage: "Ok")
        }
        
        BAC = relativeDrinkCount * weightTollerance
        
        updateLabels()
        
        timer()
        
        defaultsData.synchronize()

    }

    @IBAction func resetButtonPressed(_ sender: Any) {
        drinkCount = 0
        relativeDrinkCount = 0
        defaultsData.synchronize()
        drinkCountLabel.text = "Drink Count: "
        bacLabel.text = "Expected BAC: "
        messageLabel.text = messages[0]
        hoursLabel.text = "Hours Elapsed: "
        resetLabel.isHidden = true
    }
    
    @IBAction func coordinationPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "GameViewController1", sender: highScore)
    }
    
    @IBAction func settingsPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "UserDetails", sender: nil)
    }
    
    @IBAction func unwindToViewController(sender: UIStoryboardSegue) {
        if let gameViewController = sender.source as? GameViewController1 {
            highScore = gameViewController.careerHighScore!
        }
        
        if let detailViewController = sender.source as? UserDetailViewController {
            weightTollerance = detailViewController.weightTollerance
        }
        
        defaultsData.synchronize()
    }

}


