//
//  WeatherAPIHandler.swift
//  WeatherForecastPractice
//
//  Created by Andrew Bailey on 12/4/18.
//  Copyright © 2018 Andrew Bailey. All rights reserved.
//

import Foundation
import CoreLocation

class WeatherAPIHandler {
    
    static let sharedInstance = WeatherAPIHandler()
    
    static let forecastType = (current: "weather", fiveDay: "forecast")
    
    let openWeatherMapAPIKey = "2e48df12f5c8491f52e13882409e64ce"
    let openWeatherMapAPICallFormat = "https://api.openweathermap.org/data/2.5/%@?id=%@&units=imperial&APPID=%@"
    let openWeatherMapIconAPICallFormat = "https://openweathermap.org/img/w/%@.png"
    let openWeatherMapAPICallCoordinatesFormat = "https://api.openweathermap.org/data/2.5/%@?lat=%@&lon=%@&units=imperial&APPID=%@"
    
    let cityReferenceFileName = "city.list"
    
    private init(){}
    
    func getForecastURLString(forecastType: String, cityID: Int) -> String
    {
        return String(format: openWeatherMapAPICallFormat, forecastType, String(cityID), openWeatherMapAPIKey)
    }
    func getForecastURLString(latitude: Double, longitude: Double) -> String
    {
        return String(format: openWeatherMapAPICallCoordinatesFormat, WeatherAPIHandler.forecastType.current, String(latitude), String(longitude), openWeatherMapAPIKey)
    }
    func getForecastIconURLString(id: Int) -> String
    {
        return String(format: openWeatherMapIconAPICallFormat, String(id))
    }
    
    func fetchCitiesFromLocalCache(completion: @escaping (Array<CityModel>) -> Void)
    {
        DispatchQueue.global().async {
            let cityModelArray = Array<CityModel>()
            if let path = Bundle.main.path(forResource: "\(self.cityReferenceFileName)", ofType: "json") {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                    let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                    if let jsonResult = jsonResult as? Array<Dictionary<String, AnyObject>> {
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
    }
    
    func fetchCurrentForecast(for cityModel: CityModel, completion: @escaping (CityWeatherModel?) -> Void)
    {
        guard let url = URL(string: getForecastURLString(forecastType: WeatherAPIHandler.forecastType.current, cityID: cityModel.id)) else {
            completion(nil)
            return
        }
        let dataTask = URLSession.shared.dataTask(with: url)
        {
            (data, response, error) in
            if error == nil {
                do {
                    if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: []) as? Dictionary<String, Any> {
                        let forecastModelArray = ForecastParser.parseForecast(type: WeatherAPIHandler.forecastType.current, jsonResult: jsonResult)
                        let cityWeatherModel = CityWeatherModel.init(cityModel: cityModel, forecastModelArray: forecastModelArray, cityImage: nil)
                        completion(cityWeatherModel)
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
    func fetchFiveDayForecast(for cityModel: CityModel, completion: @escaping (CityWeatherModel?) -> Void)
    {
        let urlString = getForecastURLString(forecastType: WeatherAPIHandler.forecastType.fiveDay, cityID: cityModel.id)
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
//        print(urlString)
        let dataTask = URLSession.shared.dataTask(with: url)
        {
            (data, response, error) in
            if error == nil {
                do {
                    if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: []) as? Dictionary<String, Any> {
                        let forecastModelArray = ForecastParser.parseForecast(type: WeatherAPIHandler.forecastType.fiveDay, jsonResult: jsonResult)
                        let cityWeatherModel = CityWeatherModel.init(cityModel: cityModel, forecastModelArray: forecastModelArray, cityImage: nil)
                        completion(cityWeatherModel)
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
    
    func fetchCityWeatherModel(for coordinates: CLLocationCoordinate2D, completion: @escaping (CityWeatherModel?) -> Void)
    {
        guard let url = URL(string: getForecastURLString(latitude: Double(coordinates.latitude), longitude:  Double(coordinates.longitude))) else {
            completion(nil)
            return
        }
        let dataTask = URLSession.shared.dataTask(with: url)
        {
            (data, response, error) in
            if error == nil {
                do {
                    if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: []) as? Dictionary<String, Any> {
                        
                        guard let cityModel = CityParser.parseCityFromWeatherAPI(jsonResult: jsonResult) else {
                                completion(nil)
                            return
                        }
                        
                        let forecastModelArray = ForecastParser.parseForecast(type: WeatherAPIHandler.forecastType.current, jsonResult: jsonResult)
                        
                        let cityWeatherModel = CityWeatherModel.init(cityModel: cityModel, forecastModelArray: forecastModelArray, cityImage: nil)
                        
                        completion(cityWeatherModel)
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
