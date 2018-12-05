//
//  WeatherAPIHandler.swift
//  WeatherForecastPractice
//
//  Created by Andrew Bailey on 12/4/18.
//  Copyright © 2018 Andrew Bailey. All rights reserved.
//

import Foundation

class WeatherAPIHandler {
    
    let sharedInstance = WeatherAPIHandler()
    
    let openWeatherMapAPIKey = "2e48df12f5c8491f52e13882409e64ce"
    let openWeatherMapAPICallFormat = "http://api.openweathermap.org/data/2.5/forecast?id=%@&APPID=%@"
    
    let cityReferenceFileName = "city.list"
    
    private init() { }
    
    func fetchCitiesFromLocalCache(completion: @escaping (Array<CityModel>) -> Void)
    {
        var cityModelArray = Array<CityModel>()
        if let path = Bundle.main.path(forResource: cityReferenceFileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let person = jsonResult["person"] as? [Any] {
                    
                }
            } catch {
                completion(cityModelArray)
            }
        } else {
            completion(cityModelArray)
        }
    }
    
    
}
