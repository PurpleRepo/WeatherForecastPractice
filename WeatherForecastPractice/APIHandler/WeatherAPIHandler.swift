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
    
    private init(){}
    
    func getURLStringFromID(id: Int) -> String
    {
        return String(format: openWeatherMapAPICallFormat, String(id), openWeatherMapAPIKey)
    }
    
    func fetchCitiesFromLocalCache(completion: @escaping (Array<CityModel>) -> Void)
    {
        let cityModelArray = Array<CityModel>()
        if let path = Bundle.main.path(forResource: cityReferenceFileName, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Dictionary<String, AnyObject> {
                    completion(CityParser.parseCities(jsonResult: jsonResult))
                } else {
                    completion(cityModelArray)
                }
            } catch {
                completion(cityModelArray)
            }
        } else {
            completion(cityModelArray)
        }
    }
    
    func fetchCityWeatherUsingID(id: Int, completion: @escaping (CityWeatherModel?) -> Void)
    {
        guard let url = URL(string: getURLStringFromID(id: id)) else {
            completion(nil)
            return
        }
        let dataTask = URLSession.shared.dataTask(with: url)
        {
            (data, response, error) in
            if error == nil {
                do {
                    if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: []) as? Dictionary<String, Any> {
                        completion(CityWeatherParser.parseCityWeather(jsonResult: jsonResult))
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
