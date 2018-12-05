//
//  CityWeatherParser.swift
//  WeatherForecastPractice
//
//  Created by Andrew Bailey on 12/5/18.
//  Copyright © 2018 Andrew Bailey. All rights reserved.
//

import Foundation

class ForecastParser {
    
    class func parseForecast(jsonResult: Dictionary<String, Any>) -> Array<ForecastModel>
    {
        var forecastModelArray = Array<ForecastModel>()
        guard let allForecast = jsonResult["weather"] as? Array<Dictionary<String, Any>> else {
            return forecastModelArray
        }
        for subForecast in allForecast {
            if let id = subForecast["id"] as? Int, let main = subForecast["main"] as? String, let description = subForecast["description"] as? String, let icon = subForecast["icon"] as? String {
                forecastModelArray.append(ForecastModel.init(id: id, weatherType: main, description: description, icon: icon))
            }
        }
        return forecastModelArray
    }
}
