//
//  CityForecastViewModel.swift
//  WeatherForecastPractice
//
//  Created by Andrew Bailey on 12/6/18.
//  Copyright © 2018 Andrew Bailey. All rights reserved.
//

import Foundation

class CityForecastViewModel {
    
    var cityWeatherModel: CityWeatherModel?
    
    init(cityWeatherModel: CityWeatherModel)
    {
        self.cityWeatherModel = cityWeatherModel
    }
    
    func loadFiveDayForecast(completion: @escaping () -> Void)
    {
        WeatherAPIHandler.sharedInstance.fetchFiveDayForecast(for: (cityWeatherModel?.cityModel)!)
        {
            (cityWeatherModel) in
            self.cityWeatherModel = cityWeatherModel
            completion()
        }
    }
    
    func getCityName() -> String { return (cityWeatherModel?.cityModel.name)! }
    func getForecastOfDay(dayIndex: Int) -> ForecastModel?
    {
        guard let weather = cityWeatherModel else {
            return nil
        }
        if dayIndex >= 0 && dayIndex < weather.forecastModelArray.count {
            return weather.forecastModelArray[dayIndex * 8]
        }
        return nil
    }
}
