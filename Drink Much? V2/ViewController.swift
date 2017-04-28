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
    @IBOutlet weak var weightTextField: UITextField!
    
    // MARK: - Variables
    
    var drinkerInfo = [DrinkerUserDefaults]()
    
    var bodyWeight: Int!
    var gender: Bool!
    
    var drinkCount: Int!
    var relativeDrinkCount: Int!
    var BAC: Double!
    
    var firstDrinkTime: Double!
    var liabilityWaiverAccepted: Bool!
    var highScore: Int!
    
    var messages = ["I Solemnly Swear That I Am Up to No Good",
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
        
        if let drinkerDefaultsData = UserDefaults.standard.object(forKey: "drinkerData") as? Data {
            if let drinkerDefaultsArray = NSKeyedUnarchiver.unarchiveObject(with: drinkerDefaultsData) as? [DrinkerUserDefaults] {
                print("Here is where you would populate drinker info")
//                drinkerInfo = drinkerDefaultsArray
            } else {
                print("error creating array")
            }
        } else {
            print("error loading data")
            let defaultDrinker = DrinkerUserDefaults()
            defaultDrinker.acceptedLiabilityAgreement = false
            defaultDrinker.drinkCount = 0
            defaultDrinker.firstDrinkTime = NSTimeIntervalSince1970
            defaultDrinker.gender = false
            defaultDrinker.weight = 200
            defaultDrinker.highScore = 0
            drinkerInfo.append(defaultDrinker)
            relativeDrinkCount = 0
        }
        
        bodyWeight = drinkerInfo[0].weight
        gender = drinkerInfo[0].gender
        drinkCount = drinkerInfo[0].drinkCount
        firstDrinkTime = drinkerInfo[0].firstDrinkTime
        liabilityWaiverAccepted = drinkerInfo[0].acceptedLiabilityAgreement
        highScore = drinkerInfo[0].highScore
        
        if drinkCount == 0 {
            resetLabel.isHidden = true
        } else {
            resetLabel.isHidden = false
            calculateBAC()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GameViewController1" {
            let destinationVC = segue.destination as! GameViewController1
            destinationVC.drinkerInfo = drinkerInfo
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
    
    func saveDrinkerDefaults() {
        var drinkerDefaultsArray = [DrinkerUserDefaults]()
        drinkerDefaultsArray = drinkerInfo
        let drinkerData = NSKeyedArchiver.archivedData(withRootObject: drinkerDefaultsArray)
        UserDefaults.standard.set(drinkerData, forKey: "drinkerData")
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
                relativeDrinkCount = drinkCount - 1
                hoursLabel.text = "Hours Elapsed: 1"
        case timeInvervals[2] ..< timeInvervals[3]:
            relativeDrinkCount = drinkCount - 2
            hoursLabel.text = "Hours Elapsed: 2"
        case timeInvervals[3] ..< timeInvervals[4]:
            relativeDrinkCount = drinkCount - 3
            hoursLabel.text = "Hours Elapsed: 3"
        case timeInvervals[4] ..< timeInvervals[5]:
            relativeDrinkCount = drinkCount - 4
            hoursLabel.text = "Hours Elapsed: 4"
        case timeInvervals[5] ..< timeInvervals[6]:
            relativeDrinkCount = drinkCount - 5
            hoursLabel.text = "Hours Elapsed: 5"
        case timeInvervals[6] ..< timeInvervals[7]:
            relativeDrinkCount = drinkCount - 6
            hoursLabel.text = "Hours Elapsed: 6"
        case timeInvervals[7] ..< timeInvervals[8]:
            relativeDrinkCount = drinkCount - 7
            hoursLabel.text = "Hours Elapsed: 7"
        case timeInvervals[8] ..< timeInvervals[9]:
            relativeDrinkCount = drinkCount - 8
            hoursLabel.text = "Hours Elapsed: 8"
        case timeInvervals[9] ..< timeInvervals[10]:
            relativeDrinkCount = drinkCount - 9
            hoursLabel.text = "Hours Elapsed: 9"
        case timeInvervals[10] ..< timeInvervals[11]:
            relativeDrinkCount = drinkCount - 10
            hoursLabel.text = "Hours Elapsed: 10"
        default:
            hoursLabel.text = "Hours Elapsed: Less Than 1"
            }
    }
    
    func markFirstDrinkTime() {
        if drinkCount == 1 {
            firstDrinkTime = NSTimeIntervalSince1970
            saveDrinkerDefaults()
            }
    }
    
    func calculateBAC() {
        var r = 0.0
        if gender == false {
            r = 0.68
        } else {
            r = 0.55
        }
        
        timer()
        
        let alcInGrams = (relativeDrinkCount * 14)
        let bodyWeightInGrams = bodyWeight * 454
        
        BAC = (Double(alcInGrams))/(Double(bodyWeightInGrams) * r) * 100
        
        updateLabels()
    }
    
    // MARK: - Actions
        
    @IBAction func addDrinkPressed(_ sender: UIButton) {
        
        if liabilityWaiverAccepted == false {
            showAlert(title: "You Must Accept Terms and Conditions Before Use", message: "Click Terms and Conditions to View", dismissMessage: "Ok")
            performSegue(withIdentifier: "LiabilityViewController", sender: nil)
        }
        
        resetLabel.isHidden = false
        
        drinkCount = drinkCount + 1
        
        markFirstDrinkTime()
                
        relativeDrinkCount = relativeDrinkCount + 1
        
        if drinkCount == messages.count-1 {
            messages.append("Well I'm out of clever messages")
        }
        
        calculateBAC()
        
        saveDrinkerDefaults()

    }

    @IBAction func resetButtonPressed(_ sender: Any) {
        drinkCount = 0
        relativeDrinkCount = 0
        BAC = 0.0
        saveDrinkerDefaults()
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
                saveDrinkerDefaults()
            }
        }
        
        if let sourceVC = sender.source as? GameViewController1 {
            highScore = sourceVC.highScore!
            saveDrinkerDefaults()
        }
        
    }
    
    @IBAction func weightTextFieldEdited(_ sender: UITextField) {
        if let enteredWeight = Int(weightTextField.text!) {
            bodyWeight = enteredWeight
            yourWeightLabel.text = "Your Weight: \(bodyWeight)"
            calculateBAC()
            saveDrinkerDefaults()
        } else {
            showAlert(title: "Invalid Number", message: "Please enter a valid weight. No decimals, commas, or non-numeric digits.", dismissMessage: "Ok")
        }

    }

    @IBAction func genderIsM(_ sender: UIButton) {
        gender = false
        yourGenderLabel.text = "Your Gender: Male"
        calculateBAC()
        saveDrinkerDefaults()
    }

    @IBAction func genderIsF(_ sender: UIButton) {
        gender = true
        yourGenderLabel.text = "Your Gender: Female"
        calculateBAC()
        saveDrinkerDefaults()
    }
    
}
