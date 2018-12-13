//
//  CityWeatherParser.swift
//  WeatherForecastPractice
//
//  Created by Andrew Bailey on 12/5/18.
//  Copyright © 2018 Andrew Bailey. All rights reserved.
//

import Foundation

class ForecastParser {
    
    class func parseForecast(type: String, jsonResult: Dictionary<String, Any>) -> Array<ForecastModel>
    {
        switch type {
        case WeatherAPIHandler.forecastType.current:
            return parseCurrentForecast(jsonResult: jsonResult)
        case WeatherAPIHandler.forecastType.fiveDay:
            return parseFiveDayForecast(jsonResult: jsonResult)
        default:
            return parseCurrentForecast(jsonResult: jsonResult)
        }
    }
    
    class func parseCurrentForecast(jsonResult: Dictionary<String, Any>) -> Array<ForecastModel>
    {
        var forecastModelArray = Array<ForecastModel>()
        if let weatherArray = jsonResult["weather"] as? Array<Dictionary<String, Any>>, let mainDictionary = jsonResult["main"] as? Dictionary<String, Any>, let windDictionary = jsonResult["wind"] as? Dictionary<String, Any>, let unixTime = jsonResult["dt"] as? Int {
            
            if let main = weatherArray[0]["main"] as? String, let description = weatherArray[0]["description"] as? String, let icon = weatherArray[0]["icon"] as? String, let temp = mainDictionary["temp"] as? Double, let speed = windDictionary["speed"] as? Double {
                forecastModelArray.append(ForecastModel.init(unixTime: unixTime, weatherType: main, description: description, icon: icon, iconImage: nil, temperature: temp, windSpeed: speed))
            }
        }
        return forecastModelArray
    }
    
    class func parseFiveDayForecast(jsonResult: Dictionary<String, Any>) -> Array<ForecastModel>
    {
        var forecastModelArray = Array<ForecastModel>()
        
        guard let forecasts = jsonResult["list"] as? Array<Dictionary<String, Any>> else {
            return forecastModelArray
        }
        
        for index in 0 ..< forecasts.count {
            if let unixTime = forecasts[index]["dt"] as? Int, let mainDictionary = forecasts[index]["main"] as? Dictionary<String, Any>, let weatherArray = forecasts[index]["weather"] as? Array<Dictionary<String, Any>>, let windDictionary = forecasts[index]["wind"] as? Dictionary<String, Any> {
                if let main = weatherArray[0]["main"] as? String, let description = weatherArray[0]["description"] as? String, let icon = weatherArray[0]["icon"] as? String, let temp = mainDictionary["temp"] as? Double, let speed = windDictionary["speed"] as? Double {
                    forecastModelArray.append(ForecastModel.init(unixTime: unixTime, weatherType: main, description: description, icon: icon, iconImage: nil, temperature: temp, windSpeed: speed))
                }
            }
        }
        
        return forecastModelArray
    }
}
