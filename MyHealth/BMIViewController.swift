//
//  BMIViewController.swift
//  MyHealth
//
//  Created by Daniel Ku on 7/6/16.
//  Copyright © 2016 djku. All rights reserved.
//

import UIKit
import SwiftyJSON


class BMIViewController: UIViewController {
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var bmiLabel: UILabel!
    @IBOutlet weak var statusText: UITextView!
    @IBOutlet weak var idealWeightLabel: UILabel!
    @IBOutlet weak var riskText: UITextView!
    
    var myBMI: BMIInfo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weightLabel.text = myBMI.weight
        heightLabel.text = myBMI.height
        bmiLabel.text = myBMI.bmi
        statusText.text = myBMI.status
        riskText.text = myBMI.risk
        idealWeightLabel.text = myBMI.idealWeight
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
