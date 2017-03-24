//
//  LiabilityViewController.swift
//  Drink Much? V2
//
//  Created by William Farley on 3/22/17.
//  Copyright © 2017 William Farley. All rights reserved.
//

import UIKit

class LiabilityViewController: UIViewController {
    
    var accepted: Bool?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if accepted != true {
            accepted = false
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "UnwindToVCFromLiabilityVC" {
            let destinationVC = segue.destination as! ViewController
            destinationVC.liabilityWaiverAccepted = accepted!
        }
        
    }
    
    @IBAction func acceptTCPressed(_ sender: Any) {
        accepted = true
    }

}
