//
//  CityForecastViewController.swift
//  WeatherForecastPractice
//
//  Created by Andrew Bailey on 12/6/18.
//  Copyright © 2018 Andrew Bailey. All rights reserved.
//

import UIKit

class CityForecastViewController: UIViewController {
    
    var cityForecastViewModel: CityForecastViewModel?
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var day1Label: UILabel!
    @IBOutlet weak var day2Label: UILabel!
    @IBOutlet weak var day3Label: UILabel!
    @IBOutlet weak var day4Label: UILabel!
    @IBOutlet weak var day5Label: UILabel!
    @IBOutlet weak var day1WeatherIcon: UIImageView!
    @IBOutlet weak var day2WeatherIcon: UIImageView!
    @IBOutlet weak var day3WeatherIcon: UIImageView!
    @IBOutlet weak var day4WeatherIcon: UIImageView!
    @IBOutlet weak var day5WeatherIcon: UIImageView!
    @IBOutlet weak var day1TemperatureLabel: UILabel!
    @IBOutlet weak var day2TemperatureLabel: UILabel!
    @IBOutlet weak var day3TemperatureLabel: UILabel!
    @IBOutlet weak var day4TemperatureLabel: UILabel!
    @IBOutlet weak var day5TemperatureLabel: UILabel!
    
    var forecastUIArray = Array<Array<UIView>>()

    override func viewDidLoad() {
        super.viewDidLoad()
        forecastUIArray.append(Array<UIView>())
        forecastUIArray[0].append(day1Label)
        forecastUIArray[0].append(day1WeatherIcon)
        forecastUIArray[0].append(day1TemperatureLabel)
        forecastUIArray.append(Array<UIView>())
        forecastUIArray[1].append(day2Label)
        forecastUIArray[1].append(day2WeatherIcon)
        forecastUIArray[1].append(day2TemperatureLabel)
        forecastUIArray.append(Array<UIView>())
        forecastUIArray[2].append(day3Label)
        forecastUIArray[2].append(day3WeatherIcon)
        forecastUIArray[2].append(day3TemperatureLabel)
        forecastUIArray.append(Array<UIView>())
        forecastUIArray[3].append(day4Label)
        forecastUIArray[3].append(day4WeatherIcon)
        forecastUIArray[3].append(day4TemperatureLabel)
        forecastUIArray.append(Array<UIView>())
        forecastUIArray[4].append(day5Label)
        forecastUIArray[4].append(day5WeatherIcon)
        forecastUIArray[4].append(day5TemperatureLabel)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadCityForecastViewModel()
    }
    
    func loadCityForecastViewModel()
    {
        cityNameLabel.text = cityForecastViewModel?.getCityName().uppercased()
        cityForecastViewModel?.loadFiveDayForecast()
        {
            () in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEE"
            for day in 0..<self.forecastUIArray.count {
                let forecastModel = self.cityForecastViewModel?.getForecastOfDay(dayIndex: day)
                if let temperature = forecastModel?.temperature {
                    let formattedTemp = String(format: "%.1f", temperature)
                    let date = Date(timeIntervalSince1970: Double(forecastModel?.unixTime ?? 0))
                    let dayString = dateFormatter.string(from: date)
                    DispatchQueue.main.async {
                        (self.forecastUIArray[day][0] as! UILabel).text = dayString
                        (self.forecastUIArray[day][1] as! UIImageView).image = forecastModel?.iconImage
                        (self.forecastUIArray[day][2] as! UILabel).text = "\(formattedTemp)°F"
                    }
                }
            }
        }
    }
}
