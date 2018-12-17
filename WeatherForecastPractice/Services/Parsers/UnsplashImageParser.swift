//
//  UnsplashImageParser.swift
//  WeatherForecastPractice
//
//  Created by Andrew Bailey on 12/11/18.
//  Copyright © 2018 Andrew Bailey. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class UnsplashImageParser {
    
    class func parseImage(jsonResult: Dictionary<String, Any>, completion: @escaping (UIImage?) -> Void)
    {
        guard let arrayOfResults = jsonResult["results"] as? Array<Dictionary<String, Any>> else {
            completion(nil)
            return
        }
        guard let urls = arrayOfResults[0]["urls"] as? Dictionary<String, Any> else {
            completion(nil)
            return
        }
        guard let fullURL = urls["full"] as? String else {
            completion(nil)
            return
        }
        guard let url = URL(string: fullURL) else {
            completion(nil)
            return
        }
        
        KingfisherManager.shared.retrieveImage(with: url, options: nil, progressBlock: nil)
        {
            (image, error, cacheType, urlRef) in
            completion(image)
        }
    }
}
