//
//  ViewController.swift
//  MyHealth
//
//  Created by Daniel Ku on 7/6/16.
//  Copyright © 2016 djku. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import AlamofireNetworkActivityIndicator
import SwiftyJSON


class ViewController: UIViewController {
    @IBOutlet weak var heightField: UITextField!
    @IBOutlet weak var ageField: UITextField!
    @IBOutlet weak var waistField: UITextField!
    @IBOutlet weak var weightField: UITextField!
    @IBOutlet weak var hipField: UITextField!
    @IBOutlet weak var testField: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
/*
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        <#code#>
    }
*/
    @IBAction func calculateBMI(sender: AnyObject) {
        
        

        
        let API_KEY = "V1Uf5OeFhrmshaSro1kpHbhdM5e4p1d0cy5jsnHHOFHmPlTJJr"
        
        let apiBMI = "https://bmi.p.mashape.com"
        
        if let url = NSURL(string: apiBMI) {
            
            let urlRequest = NSMutableURLRequest(URL: url)
            
            urlRequest.setValue(API_KEY, forHTTPHeaderField: "X-Mashape-Key")
            urlRequest.HTTPMethod = "POST"
            
            let bmiParams = [
                "weight": [
                    "value": /*weightField.text!*/"80.00",
                    "unit": "kg"
                ],
                "height": [
                    "value": /*heightField.text!*/ "170.00",
                    "unit": "cm"
                ],
                "sex" : "m",
                "age" : "20"/*ageField.text!*/,
                "waist" : waistField.text!,
                "hip" : hipField.text!
            ]
            
            let data = try! NSJSONSerialization.dataWithJSONObject(bmiParams, options: .PrettyPrinted)
           
            urlRequest.HTTPBody = data
            
            Alamofire.request(urlRequest).responseJSON(completionHandler: { (response) in
                switch response.result{
                case .Success:
                    if let value = response.result.value{
                        let bmi = JSON(value)
                        
                        print("HI " +  bmi["weight"]["kg"].stringValue)
                        
                        self.testField.text! = bmi["weight"]["lb"].stringValue
                        
                    }
                case .Failure(let error):
                    print(error)
                }

            })
            
        }

    }
}

