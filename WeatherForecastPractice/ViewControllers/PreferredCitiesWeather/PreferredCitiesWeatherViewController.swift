//
//  CityWeatherViewController.swift
//  WeatherForecastPractice
//
//  Created by Andrew Bailey on 12/4/18.
//  Copyright © 2018 Andrew Bailey. All rights reserved.
//

import UIKit

class PreferredCitiesWeatherViewController: UIViewController {

    @IBOutlet weak var citiesWeatherTableView: UITableView!
    
    var cityWeatherViewModel: CityWeatherViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityWeatherViewModel = CityWeatherViewModel.init()
        cityWeatherViewModel!.fetchPreferredCityWeatherModels()
        {
            () in
            DispatchQueue.main.async {
                self.citiesWeatherTableView.reloadData()
            }
        }
    }
}

extension PreferredCitiesWeatherViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityWeatherViewModel!.getCityWeatherModelArrayCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PreferredCityWeatherTableViewCell") as? PreferredCityWeatherTableViewCell, let cityWeatherModel = cityWeatherViewModel!.getCityWeatherModel(at: indexPath.row) else {
            return UITableViewCell()
        }
        
        
        
        return cell
    }
}
