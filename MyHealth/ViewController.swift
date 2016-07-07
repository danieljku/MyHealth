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
    @IBOutlet weak var weightField: UITextField!
    @IBOutlet weak var genderSegControl: UISegmentedControl!

    var flag = true
    var myInfo: BMIInfo!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        heightField.layer.borderWidth = 1
        weightField.layer.borderWidth = 1
        ageField.layer.borderWidth = 1
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "BMI"{
            if let destination = segue.destinationViewController as? BMIViewController{
                destination.myBMI = self.myInfo
            }
        }
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if identifier == "BMI" {
            if self.myInfo != nil {
                return true
            }
        }
        
        return false
    }
 */

    @IBAction func calculateBMI(sender: AnyObject) {
        let gender: String!
        if genderSegControl.selectedSegmentIndex == 0{
            gender = "m"
        }else{
            gender = "f"
        }
        
        let API_KEY = "V1Uf5OeFhrmshaSro1kpHbhdM5e4p1d0cy5jsnHHOFHmPlTJJr"
        
        let apiBMI = "https://bmi.p.mashape.com"
        
        if let url = NSURL(string: apiBMI) {
            
            let urlRequest = NSMutableURLRequest(URL: url)
            
            urlRequest.setValue(API_KEY, forHTTPHeaderField: "X-Mashape-Key")
            urlRequest.HTTPMethod = "POST"
            
            let bmiParams = [
                "weight": [
                    "value": weightField.text!,
                    "unit": "kg"
                ],
                "height": [
                    "value": heightField.text!,
                    "unit": "cm"
                ],
                "sex" : gender,
                "age" : ageField.text!,
            ]
            
            let data = try! NSJSONSerialization.dataWithJSONObject(bmiParams, options: .PrettyPrinted)
           
            urlRequest.HTTPBody = data
            
            Alamofire.request(urlRequest).responseJSON(completionHandler: { (response) in
                switch response.result{
                case .Success:
                    if let value = response.result.value{
                        let bmi = JSON(value)
                        
                        dispatch_async(dispatch_get_main_queue(), {
                            let controller = self.storyboard?.instantiateViewControllerWithIdentifier("BMIViewController") as? BMIViewController
                            //Store all the info into a struct
                            controller?.myBMI = BMIInfo(json: bmi)
                            //Push view controller onto the stack
                            self.navigationController?.pushViewController(controller!, animated: true)
                        })
                    }
                case .Failure(let error):
                    print(error)
                }

            })
            
        }

    }
}

