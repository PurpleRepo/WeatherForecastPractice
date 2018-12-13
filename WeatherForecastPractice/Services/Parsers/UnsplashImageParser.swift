//
//  UnsplashImageParser.swift
//  WeatherForecastPractice
//
//  Created by Andrew Bailey on 12/11/18.
//  Copyright © 2018 Andrew Bailey. All rights reserved.
//

import Foundation
import UIKit

class UnsplashImageParser {
    
    class func parseImage(jsonResult: Dictionary<String, Any>) -> UIImage?
    {
        guard let arrayOfResults = jsonResult["results"] as? Array<Dictionary<String, Any>> else {
            return nil
        }
        guard let urls = arrayOfResults[0]["urls"] as? Dictionary<String, Any> else {
            return nil
        }
        guard let fullURL = urls["full"] as? String else {
            return nil
        }
        print(fullURL)
        return UIImage(contentsOfFile: fullURL)
    }
}
