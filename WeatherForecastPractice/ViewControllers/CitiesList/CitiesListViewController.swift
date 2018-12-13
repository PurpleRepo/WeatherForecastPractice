//
//  CitiesListViewController.swift
//  WeatherForecastPractice
//
//  Created by Andrew Bailey on 12/5/18.
//  Copyright © 2018 Andrew Bailey. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol AddCityDelegate {
    func addCity(cityModel: CityModel)
}

class CitiesListViewController: UIViewController {
    
    @IBOutlet weak var citiesListTableView: UITableView!
    
    var addCityDelegate: AddCityDelegate?
    var cityViewModel = CityViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.show(withStatus: "Loading Cities")
        cityViewModel.fetchCityModels()
        {
            () in
            DispatchQueue.main.async {
                self.citiesListTableView.reloadData()
                SVProgressHUD.dismiss()
            }
        }
    }
}

extension CitiesListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityViewModel.getCityModelArrayCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CityTableViewCell"), let cityModel = cityViewModel.getCityModel(at: indexPath.row) else {
            return UITableViewCell()
        }
        
        cell.textLabel?.text = cityModel.name
        cell.detailTextLabel?.text = cityModel.country
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cityModel = cityViewModel.getCityModel(at: indexPath.row) {
            addCityDelegate?.addCity(cityModel: cityModel)
            navigationController?.popViewController(animated: true)
        }
    }
}
