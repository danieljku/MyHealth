//
//  BMIInfo.swift
//  MyHealth
//
//  Created by Daniel Ku on 7/6/16.
//  Copyright © 2016 djku. All rights reserved.
//

import Foundation
import SwiftyJSON

struct BMIInfo{
    let weight: String
    let height: String
    let bmi: String
    let status: String
    let risk: String
    let idealWeight: String
    
    
    init(json: JSON){
        weight = json["weight"]["kg"].stringValue
        height = json["height"]["cm"].stringValue
        bmi = json["bmi"]["value"].stringValue
        status = json["bmi"]["status"].stringValue
        risk = json["bmi"]["risk"].stringValue
        idealWeight = json["ideal_weight"].stringValue
    }
}
