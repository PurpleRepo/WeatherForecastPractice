//
//  CityParser.swift
//  WeatherForecastPractice
//
//  Created by Andrew Bailey on 12/5/18.
//  Copyright © 2018 Andrew Bailey. All rights reserved.
//

import Foundation

class CityParser {
    
    class func parseCities(jsonResult: Array<Dictionary<String, Any>>) -> Array<CityModel>
    {
        var cityModelArray = Array<CityModel>()
        
        for cities in jsonResult {
            if let id = cities["id"] as? Int, let name = cities["name"] as? String, let country = cities["country"] as? String, let coordinates = cities["coord"] as? Dictionary<String, Double> {
                if let latitude = coordinates["lat"], let longitude = coordinates["lon"] {
                    cityModelArray.append(CityModel.init(id: id, name: name, country: country, latitude: latitude, longitude: longitude))
                }
            }
        }
        
        return cityModelArray
    }
    
    class func parseCityFromWeatherAPI(jsonResult: Dictionary<String, Any>) -> CityModel?
    {
        if let id = jsonResult["id"] as? Int, let name = jsonResult["name"] as? String, let coordinates = jsonResult["coord"] as? Dictionary<String, Any>, let sys = jsonResult["sys"] as? Dictionary<String, Any> {
            if let latitude = coordinates["lat"] as? Double, let longitude = coordinates["lon"] as? Double, let country = sys["country"] as? String {
                return CityModel.init(id: id, name: name, country: country, latitude: latitude, longitude: longitude)
            }
        } else if let city = jsonResult["city"] as? Dictionary<String, Any> {
            if let id = city["id"] as? Int, let name = city["name"] as? String, let coordinates = jsonResult["coord"] as? Dictionary<String, Any>, let country = jsonResult["country"] as? String {
                if let latitude = coordinates["lat"] as? Double, let longitude = coordinates["lon"] as? Double {
                    return CityModel.init(id: id, name: name, country: country, latitude: latitude, longitude: longitude)
                }
            }
        }
        
        return nil
    }
}
