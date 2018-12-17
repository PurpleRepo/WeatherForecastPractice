//
//  LocationService.swift
//  WeatherForecastPractice
//
//  Created by Andrew Bailey on 12/6/18.
//  Copyright © 2018 Andrew Bailey. All rights reserved.
//

import Foundation
import CoreLocation

class LocationService: NSObject, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    var dispatchGroup = DispatchGroup()
    var leaves = 0
    
    override init()
    {
        super.init()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 30
    }
    
    func getLocation(completion: @escaping (CLLocationCoordinate2D?) -> Void)
    {
        dispatchGroup.enter()
        locationManager.requestLocation()
        dispatchGroup.notify(queue: .global()) {
            completion(self.locationManager.location?.coordinate)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        objc_sync_enter(leaves)
        if leaves == 0 {
            leaves += 1
            dispatchGroup.leave()
        }
        objc_sync_exit(leaves)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
//        print(error.localizedDescription)
    }
}
