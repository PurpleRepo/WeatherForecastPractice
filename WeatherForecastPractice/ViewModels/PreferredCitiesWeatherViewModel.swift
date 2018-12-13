//
//  CityWeatherViewModel.swift
//  WeatherForecastPractice
//
//  Created by Andrew Bailey on 12/4/18.
//  Copyright © 2018 Andrew Bailey. All rights reserved.
//

import Foundation
import CoreLocation
import SVProgressHUD

class PreferredCitiesWeatherViewModel {
    
    let profileManager = ProfileManager()
    let locationService = LocationService()
    var cityIDArray = Array<String>()
    var cityWeatherModelArray = Array<CityWeatherModel>()
    
    init(){}
    
    func fetchPreferredCityWeatherModels(completion: @escaping () -> Void)
    {
        // api call
        //WeatherAPIHandler.
        cityIDArray = profileManager.fetchStoredCityIDs()
        if cityIDArray.count == 0 {
            DispatchQueue.main.async {
                SVProgressHUD.show(withStatus: "Getting Local Weather")
            }
            locationService.getLocation() {
                (coordinates) in
                guard let coordinates = coordinates else {
                    DispatchQueue.main.async {
                        SVProgressHUD.dismiss()
                    }
                    completion()
                    return
                }
                WeatherAPIHandler.sharedInstance.fetchCityWeatherModel(for: coordinates)
                {
                    (cityWeatherModel) in
                    guard var cityWeatherModel = cityWeatherModel else {
                        DispatchQueue.main.async {
                            SVProgressHUD.dismiss()
                        }
                        completion()
                        return
                    }
                    UnsplashAPIHandler.sharedInstance.fetchPicture(of: cityWeatherModel.cityModel.name)
                    {
                        (image) in
                        cityWeatherModel.cityImage = image
                        self.cityWeatherModelArray.append(cityWeatherModel)
                        // TODO: save the city ID in the profile manager
                        DispatchQueue.main.async {
                            SVProgressHUD.dismiss()
                        }
                        completion()
                    }
                }
            }
        } else {
            DispatchQueue.main.async {
                SVProgressHUD.show(withStatus: "Loading Weather Profile")
            }
            
            // TODO: load the cities that are in the String array
            
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
            }
            completion()
        }
    }
    
    func addCity(cityModel: CityModel, completion: @escaping () -> Void)
    {
        WeatherAPIHandler.sharedInstance.fetchCurrentForecast(for: cityModel)
        {
            (cityWeatherModel) in
            guard let cityWeatherModel = cityWeatherModel else {
                completion()
                return
            }
            self.cityWeatherModelArray.append(cityWeatherModel)
            completion()
        }
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
