//
//  ViewController.swift
//  Drink Much? V2
//
//  Created by William Farley on 2/6/17.
//  Copyright © 2017 William Farley. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var drinkerImage: UIImageView!
    @IBOutlet weak var drinkCountLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var resetLabel: UIButton!
    @IBOutlet weak var bacLabel: UILabel!
    @IBOutlet weak var testYourselfView: UIView!
    @IBOutlet weak var drinkCountEtcView: UIView!
    @IBOutlet weak var yourWeightLabel: UILabel!
    @IBOutlet weak var yourGenderLabel: UILabel!
    
    // MARK: - Variables
    
    var weightEntered = false
    var bodyWeight = 200.0
    var gender = false
    var genderEntered = false
    
    var drinkCount = 0
    var relativeDrinkCount: Double = 0
    var BAC: Double = 0
    
    var firstDrinkTime = 0.0
    var liabilityWaiverAccepted: Bool = false
    var highScore = 0
    
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
                    "Why'd The Chicken Cross The Road?",
                    "I don't think we have the technology to know that",
                    "Guess What Number You're At. Wait, don't look.",
                    "No, This is Number 13... You Might Have a Problem",
                    "Give Someone Your Phone. It's Dangerous"]
    
    // MARK: - Override Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bodyWeight = defaultsData.double(forKey: "bodyWeight")
        
        weightEntered = defaultsData.bool(forKey: "weightEntered")
        
        gender = defaultsData.bool(forKey: "gender")
        
        genderEntered = defaultsData.bool(forKey: "genderEntered")
        
        drinkCount = defaultsData.integer(forKey: "drinkCount")
        
        defaultsData.set(drinkCount, forKey: "drinkCount")
        
        relativeDrinkCount = defaultsData.double(forKey: "relativeDrinkCount")
        
        liabilityWaiverAccepted = defaultsData.bool(forKey: "liabilityWaiverAccepted")
        
        calculateBAC()
        
        if drinkCount == 0 {
            resetLabel.isHidden = true
        } else {
            resetLabel.isHidden = false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GameViewController1" {
            let destinationVC = segue.destination as! GameViewController1
            destinationVC.highScore = highScore
        }
        
        if segue.identifier == "LiabilityViewController" {
            let destinationVC = segue.destination as! LiabilityViewController
            destinationVC.accepted = liabilityWaiverAccepted
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
        let bacToShow = String(format: "%.3f", BAC)
        bacLabel.text = "Expected BAC: \(bacToShow)"
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
        case timeInvervals[1] ..< timeInvervals[2]:
                relativeDrinkCount = Double(drinkCount) + 1
                hoursLabel.text = "Hours Elapsed: 1"
        case timeInvervals[2] ..< timeInvervals[3]:
            relativeDrinkCount = Double(drinkCount) + 2
            hoursLabel.text = "Hours Elapsed: 2"
        case timeInvervals[3] ..< timeInvervals[4]:
            relativeDrinkCount = Double(drinkCount) + 3
            hoursLabel.text = "Hours Elapsed: 3"
        case timeInvervals[4] ..< timeInvervals[5]:
            relativeDrinkCount = Double(drinkCount) + 4
            hoursLabel.text = "Hours Elapsed: 4"
        case timeInvervals[5] ..< timeInvervals[6]:
            relativeDrinkCount = Double(drinkCount) + 5
            hoursLabel.text = "Hours Elapsed: 5"
        case timeInvervals[6] ..< timeInvervals[7]:
            relativeDrinkCount = Double(drinkCount) + 6
            hoursLabel.text = "Hours Elapsed: 6"
        case timeInvervals[7] ..< timeInvervals[8]:
            relativeDrinkCount = Double(drinkCount) + 7
            hoursLabel.text = "Hours Elapsed: 7"
        case timeInvervals[8] ..< timeInvervals[9]:
            relativeDrinkCount = Double(drinkCount) + 8
            hoursLabel.text = "Hours Elapsed: 8"
        case timeInvervals[9] ..< timeInvervals[10]:
            relativeDrinkCount = Double(drinkCount) + 9
            hoursLabel.text = "Hours Elapsed: 9"
        case timeInvervals[10] ..< timeInvervals[11]:
            relativeDrinkCount = Double(drinkCount) + 10
            hoursLabel.text = "Hours Elapsed: 10"
        default:
            hoursLabel.text = "Hours Elapsed: Less Than 1"
            }
    }
    
    func markFirstDrinkTime() {
        if drinkCount == 1 {
            firstDrinkTime = NSTimeIntervalSince1970
            defaultsData.set(firstDrinkTime, forKey: "firstDrinkTime")
            }
    }
    
    func calculateBAC() {
        var r = 0.0
        if gender == false {
            r = 0.68
        } else {
            r = 0.55
        }
        let alcInGrams = (relativeDrinkCount * 14)
        let bodyWeightInGrams = bodyWeight * 454
        
        BAC = (alcInGrams)/(bodyWeightInGrams * r) * 100
        
        updateLabels()
    }
    
    // MARK: - Actions
        
    @IBAction func addDrinkPressed(_ sender: UIButton) {
        
        if liabilityWaiverAccepted == false {
            showAlert(title: "You Must Accept Terms and Conditions Before Use", message: "Click Terms and Conditions to View", dismissMessage: "Ok")
        }
        
        resetLabel.isHidden = false
        
        drinkCount = drinkCount + 1
        
        markFirstDrinkTime()
                
        relativeDrinkCount = relativeDrinkCount + 1
        
        if Int(relativeDrinkCount) == messages.count-1 {
            showAlert(title: "That's As High As We Go", message: "Sorry if you're actually still drinking.", dismissMessage: "Ok")
        }
        
        calculateBAC()
        
        timer()
        
        defaultsData.synchronize()
        
        if weightEntered == false || genderEntered == false {
            showAlert(title: "You Can Enter Your Weight and Gender To Increase Accuracy", message: "Otherwise we're just plugging a guess into the formula", dismissMessage: "Ok")
        }

    }

    @IBAction func resetButtonPressed(_ sender: Any) {
        drinkCount = 0
        relativeDrinkCount = 0
        BAC = 0.0
        defaultsData.synchronize()
        drinkCountLabel.text = "Drink Count: "
        bacLabel.text = "Expected BAC: "
        messageLabel.text = messages[0]
        hoursLabel.text = "Hours Elapsed: "
        resetLabel.isHidden = true
    }
    
    @IBAction func coordinationPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "GameViewController1", sender: nil)
    }
    
    @IBAction func unwindToViewController(sender: UIStoryboardSegue) {
        
        if let sourceVC = sender.source as? LiabilityViewController {
            if liabilityWaiverAccepted == false {
            liabilityWaiverAccepted = sourceVC.accepted!
            defaultsData.set(liabilityWaiverAccepted, forKey: "liabilityWaiverAccepted")
            }
        }
        
        if let sourceVC = sender.source as? GameViewController1 {
            highScore = sourceVC.highScore!
            defaultsData.synchronize()
        }
        
    }
    
    func checkIfWeightHadBeenEntered() {
        if weightEntered == false {
            weightEntered = true
            defaultsData.set(weightEntered, forKey: "weightEntered")
            defaultsData.set(bodyWeight, forKey: "bodyWeight")
        }
    }
    
    func checkIfGenderHadBeenEntered() {
        if genderEntered == false {
            genderEntered = true
            defaultsData.set(gender, forKey: "gender")
            defaultsData.set(genderEntered, forKey: "genderEntered")
        }
    }
    
    @IBAction func weightIs100(_ sender: Any) {
        bodyWeight = 100
        checkIfWeightHadBeenEntered()
        yourWeightLabel.text = "Your Weight: 100"
        calculateBAC()
    }
    
    @IBAction func weightIs150(_ sender: Any) {
        bodyWeight = 150
        checkIfWeightHadBeenEntered()
        yourWeightLabel.text = "Your Weight: 150"
        calculateBAC()
    }
    
    @IBAction func weightIs200(_ sender: Any) {
        bodyWeight = 200
        checkIfWeightHadBeenEntered()
        yourWeightLabel.text = "Your Weight: 200"
        calculateBAC()
    }
    
    @IBAction func weightIs250(_ sender: Any) {
        bodyWeight = 250
        checkIfWeightHadBeenEntered()
        yourWeightLabel.text = "Your Weight: 250"
        calculateBAC()
    }

    @IBAction func genderIsM(_ sender: UIButton) {
        gender = false
        checkIfGenderHadBeenEntered()
        yourGenderLabel.text = "Your Gender: Male"
        calculateBAC()
    }

    @IBAction func genderIsF(_ sender: UIButton) {
        gender = true
        checkIfGenderHadBeenEntered()
        yourGenderLabel.text = "Your Gender: Female"
        calculateBAC()
    }
    
}
