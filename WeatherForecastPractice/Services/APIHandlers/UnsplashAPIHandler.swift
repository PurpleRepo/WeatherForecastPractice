//
//  UnsplashAPIHandler.swift
//  WeatherForecastPractice
//
//  Created by Andrew Bailey on 12/4/18.
//  Copyright © 2018 Andrew Bailey. All rights reserved.
//

import Foundation
import Alamofire

class UnsplashAPIHandler {
    
    let unsplashAPIAccessKey = "c5292831ad0c7ad8c30be3d5be731be72832a40ef2c8db853a9bd5f48816c283"
//    let unsplashAPIPrivateKey = "3b2dcb75c58c70773e9b32a0bb8847690d24c437d443d90b6eeb526a810893b7"
    let unsplashAPICallFormat = "https://api.unsplash.com/search/photos?query=%@&client_id=%@"
    
    static let sharedInstance = UnsplashAPIHandler()
    
    private init(){}
    
    func getURLStringOfCityLocation(city: String) -> String
    {
        return String(format: unsplashAPICallFormat, city, unsplashAPIAccessKey)
    }
    
    func fetchPicture(of city: String, completion: @escaping (UIImage?) -> Void)
    {
        // JSON
        // then URL
        // use Kingfisher to download and cache the images?
        guard let url = URL(string: getURLStringOfCityLocation(city: city)) else {
            completion(nil)
            return
        }
        let dataTask = URLSession.shared.dataTask(with: url)
        {
            (data, response, error) in
            if error == nil {
                do {
                    if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: []) as? Dictionary<String, Any> {
                        completion(UnsplashImageParser.parseImage(jsonResult: jsonResult))
                    } else {
                        completion(nil)
                    }
                } catch {
                    completion(nil)
                }
            } else {
                completion(nil)
            }
        }
        dataTask.resume()
    }
}
