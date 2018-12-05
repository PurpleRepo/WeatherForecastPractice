//
//  CityViewModel.swift
//  WeatherForecastPractice
//
//  Created by Andrew Bailey on 12/5/18.
//  Copyright © 2018 Andrew Bailey. All rights reserved.
//

import Foundation

class CityViewModel {
    
    var cityModelArray = Array<CityModel>()
    
    func fetchCityModels(completion: @escaping () -> Void)
    {
        
    }
    
    func getCityModelArrayCount() -> Int
    {
        return cityModelArray.count
    }
    
    func getCityModel(at index: Int) -> CityModel?
    {
        if index >= 0 && index < cityModelArray.count {
            return cityModelArray[index]
        }
        return nil
    }
}
