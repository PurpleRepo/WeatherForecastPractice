//
//  PreferredCityWeatherTableViewCell.swift
//  WeatherForecastPractice
//
//  Created by Andrew Bailey on 12/5/18.
//  Copyright © 2018 Andrew Bailey. All rights reserved.
//

import UIKit

class PreferredCityWeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var backgroundImageImageView: UIImageView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var cityWeatherIconImageView: UIImageView!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
