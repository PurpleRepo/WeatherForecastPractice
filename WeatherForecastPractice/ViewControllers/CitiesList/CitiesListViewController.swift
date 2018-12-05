//
//  CitiesListViewController.swift
//  WeatherForecastPractice
//
//  Created by Andrew Bailey on 12/5/18.
//  Copyright © 2018 Andrew Bailey. All rights reserved.
//

import UIKit

class CitiesListViewController: UIViewController {
    
    @IBOutlet weak var citiesListTableView: UITableView!
    
    var cityViewModel = CityViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        cityViewModel.fetchCityModels()
        {
            () in
            DispatchQueue.main.async {
                self.citiesListTableView.reloadData()
            }
        }
    }
}

extension CitiesListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityViewModel.getCityModelArrayCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CityTableViewCell") as? CityTableViewCell, let cityModel = cityViewModel.getCityModel(at: indexPath.row) else {
            return UITableViewCell()
        }
        
        
        
        return cell
    }
}
