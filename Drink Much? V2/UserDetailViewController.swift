//
//  UserDetailViewController.swift
//  Drink Much? V2
//
//  Created by William Farley on 3/13/17.
//  Copyright © 2017 William Farley. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {
    
    @IBOutlet weak var weightTextField: UITextField!
    
    var enteredWeight: Int = 0
    var weightTollerance: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showAlert(title: String, message: String, dismissMessage: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: dismissMessage, style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func enterButtonPressed(_ sender: Any) {
        if let userInput = Int(weightTextField.text!) {
            enteredWeight = userInput
            weightTollerance = 0.01 * (4 - (0.01 * Double(userInput)))
        } else {
            showAlert(title: "Invalid Entry", message: "Check to make sure your inputted weight is a valid number.", dismissMessage: "Ok")
        }
    }

    @IBAction func donePressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

}
