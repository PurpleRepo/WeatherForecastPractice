//
//  ForecastModel.swift
//  WeatherForecastPractice
//
//  Created by Andrew Bailey on 12/5/18.
//  Copyright © 2018 Andrew Bailey. All rights reserved.
//

import Foundation
import UIKit

struct ForecastModel {
    
    let unixTime: Int               // "dt"
    let weatherType: String         // "main"
    let description: String         // "description"
    let icon: String                // "icon"
    var iconImage: UIImage?         // (loaded image)
    let temperature: Double         // "temp"
    let windSpeed: Double           // "speed" 
}
