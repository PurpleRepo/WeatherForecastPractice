//
//  CityWeatherViewModel.swift
//  WeatherForecastPractice
//
//  Created by Andrew Bailey on 12/4/18.
//  Copyright © 2018 Andrew Bailey. All rights reserved.
//

import Foundation
import CoreLocation

class CityWeatherViewModel: NSObject {
    
    var locationManager = CLLocationManager()
    
    var cityWeatherModelArray = Array<CityWeatherModel>()
    var coordinates: CLLocationCoordinate2D?
    
    override init()
    {
        super.init()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 30
        locationManager.requestLocation()
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

extension CityWeatherViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        coordinates = locationManager.location?.coordinate
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print(error.localizedDescription)
    }
}
