//
//  CityWeatherViewModel.swift
//  WeatherForecastPractice
//
//  Created by Andrew Bailey on 12/4/18.
//  Copyright © 2018 Andrew Bailey. All rights reserved.
//

import Foundation
import CoreLocation

class CityWeatherViewModel: NSObject, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    
    var cityWeatherModelArray = Array<CityWeatherModel>()
    
    override init()
    {
        super.init()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 30
    }
    
    func fetchPreferredCityWeatherModels(completion: @escaping () -> Void)
    {
        // api call
    }
    
    func getCityWeatherModelArrayCount() -> Int
    {
        return cityWeatherModelArray.count
    }
    
    func getCityWeatherModel(at index: Int) -> CityWeatherModel?
    {
        if index >= 0 && index < cityWeatherModelArray.count {
            return cityWeatherModelArray[index]
        }
        return nil
    }
}
