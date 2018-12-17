//
//  CityWeatherViewController.swift
//  WeatherForecastPractice
//
//  Created by Andrew Bailey on 12/4/18.
//  Copyright © 2018 Andrew Bailey. All rights reserved.
//

import UIKit
import SVProgressHUD

class PreferredCitiesWeatherViewController: UIViewController, AddCityDelegate {

    @IBOutlet weak var citiesWeatherTableView: UITableView!
    
    var preferredCitiesWeatherViewModel = PreferredCitiesWeatherViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.show(withStatus: "Loading Weather Profile")
        preferredCitiesWeatherViewModel.fetchPreferredCityWeatherModels()
        {
            () in
            DispatchQueue.main.async {
                self.citiesWeatherTableView.reloadData()
                SVProgressHUD.dismiss()
            }
        }
    }
    
    func addCity(cityModel: CityModel)
    {
        SVProgressHUD.show(withStatus: "Adding \(cityModel.name)")
        preferredCitiesWeatherViewModel.addCity(cityModel: cityModel)
        {
            () in
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
                self.citiesWeatherTableView.reloadData()
            }
        }
    }
    
    @IBAction func showCitiesList()
    {
        if let controller = storyboard?.instantiateViewController(withIdentifier: "CitiesListViewController") as? CitiesListViewController {
            controller.addCityDelegate = self
            navigationController?.pushViewController(controller, animated: true)
        }
    }
}

extension PreferredCitiesWeatherViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return preferredCitiesWeatherViewModel.getCityWeatherModelArrayCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PreferredCityWeatherTableViewCell") as? PreferredCityWeatherTableViewCell, let cityWeatherModel = preferredCitiesWeatherViewModel.getCityWeatherModel(at: indexPath.row) else {
            return UITableViewCell()
        }
        
        let formattedTemp = String(format: "%.1f", cityWeatherModel.forecastModelArray[0].temperature)
        
        cell.cityNameLabel.text = cityWeatherModel.cityModel.name.uppercased()
        cell.backgroundImageImageView.image = cityWeatherModel.cityImage
        cell.cityWeatherIconImageView.image = cityWeatherModel.forecastModelArray[0].iconImage
        cell.weatherDescriptionLabel.text = "Weather: \(cityWeatherModel.forecastModelArray[0].weatherType)"
        cell.temperatureLabel.text = "Temperature: \(formattedTemp)°F"
        cell.windSpeedLabel.text = "Wind Speed: \(String(cityWeatherModel.forecastModelArray[0].windSpeed)) MPH"
        
        return cell
    }
}

extension PreferredCitiesWeatherViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.isSelected = false
        if let controller = storyboard?.instantiateViewController(withIdentifier: "CityForecastViewController") as? CityForecastViewController {
            controller.cityForecastViewModel = CityForecastViewModel(cityWeatherModel: preferredCitiesWeatherViewModel.getCityWeatherModel(at: indexPath.row)!)
            navigationController?.pushViewController(controller, animated: true)
        }
    }
}
