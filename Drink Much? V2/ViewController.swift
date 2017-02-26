//
//  ViewController.swift
//  Drink Much? V2
//
//  Created by William Farley on 2/6/17.
//  Copyright © 2017 William Farley. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var drinkerImage: UIImageView!
    @IBOutlet weak var drinkCountLabel: UILabel!
    @IBOutlet weak var bacLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    
    var weightTollerance: Double = 0.02
    var drinkCount = 0
    var relativeDrinkCount: Double = 0
    var BAC: Double = 0
    
    var firstDrinkTime = 0.0
    
    let messages = ["This Won't Pop Up",
                    "Let's Get It Started!",
                    "Who Has a Speaker?",
                    "Please Don't Puke Yet",
                    "Numero Quattro: Start of the Happy Zone",
                    "Don't You Fucking Think of Driving",
                    "Really Getting There Now",
                    "New Bar! Someone Call The Uber",
                    "Hit Up Your Side-Piece Yet?",
                    "Hit Up Your Ex Yet?",
                    "Give Up Your Phone",
                    "Ho Gome You're Drunk",
                    "Nah Nevermind You Have Nothing to Do in The Morning",
                    "Ok Either You're Just Scrolling Through",
                    "Or You're A Savage"]
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        firstDrinkTime = NSTimeIntervalSince1970
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Functions
    
    func timer() {
        let currentTime = NSTimeIntervalSince1970
        let elapsedTime = Int(currentTime - firstDrinkTime)
        
        switch elapsedTime {
        case let elapsedTime where timeInvervals[0] > elapsedTime:
            hoursLabel.text = "Hours Elapsed: Less Than 1"
        case let elapsedTime where timeInvervals[1] > elapsedTime:
            relativeDrinkCount = relativeDrinkCount - 1
            hoursLabel.text = "Hours Elapsed: 1"
        case let elapsedTime where timeInvervals[2] > elapsedTime:
            relativeDrinkCount = relativeDrinkCount - 2
            hoursLabel.text = "Hours Elapsed: 2"
        case let elapsedTime where timeInvervals[3] > elapsedTime:
            relativeDrinkCount = relativeDrinkCount - 3
            hoursLabel.text = "Hours Elapsed: 3"
        case let elapsedTime where timeInvervals[4] > elapsedTime:
            relativeDrinkCount = relativeDrinkCount - 4
            hoursLabel.text = "Hours Elapsed: 4"
        case let elapsedTime where timeInvervals[5] > elapsedTime:
            relativeDrinkCount = relativeDrinkCount - 5
            hoursLabel.text = "Hours Elapsed: 5"
        case let elapsedTime where timeInvervals[6] > elapsedTime:
            relativeDrinkCount = relativeDrinkCount - 6
            hoursLabel.text = "Hours Elapsed: 6"
        case let elapsedTime where timeInvervals[7] > elapsedTime:
            relativeDrinkCount = relativeDrinkCount - 7
            hoursLabel.text = "Hours Elapsed: 7"
        case let elapsedTime where timeInvervals[8] > elapsedTime:
            relativeDrinkCount = relativeDrinkCount - 8
            hoursLabel.text = "Hours Elapsed: 8"
        case let elapsedTime where timeInvervals[9] > elapsedTime:
            relativeDrinkCount = relativeDrinkCount - 9
            hoursLabel.text = "Hours Elapsed: 9"
        case let elapsedTime where timeInvervals[10] > elapsedTime:
            relativeDrinkCount = relativeDrinkCount - 10
            hoursLabel.text = "Hours Elapsed: 10"
        case let elapsedTime where timeInvervals[11] > elapsedTime:
            relativeDrinkCount = relativeDrinkCount - 11
            hoursLabel.text = "Hours Elapsed: 11"
        case let elapsedTime where timeInvervals[12] > elapsedTime:
            relativeDrinkCount = relativeDrinkCount - 12
            hoursLabel.text = "Hours Elapsed: 12"
        default:
            hoursLabel.text = "Hours Elapsed: Greater Than 12"
        }

    }
    
    // MARK: Actions

    @IBAction func weightEntered(_ sender: UITextField) {
        
        if let enteredWeight = Double(textField.text!) {
            weightTollerance = 0.01 * (4 - (0.01 * enteredWeight)) }
        else {
            let alertController = UIAlertController(title: "Entry Error", message: "Please enter a valid number. Not an empty string. No commas, symbols, or non-numeric characters.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil) }
        
    }
    
    @IBAction func drinkAdded(_ sender: UITapGestureRecognizer) {
        
        drinkCount = drinkCount + 1
        
        relativeDrinkCount = relativeDrinkCount + 1
        
        BAC = relativeDrinkCount * weightTollerance
        
        drinkCountLabel.text = "Drink Count: \(drinkCount)"
        
        bacLabel.text = "\(BAC)"
        
        messageLabel.text = messages[drinkCount]
        
        timer()
        
        }
    
    
    }



