//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Caludia Carrillo on 1/14/18.
//  Copyright © 2018 Claudia Carrillo. All rights reserved.
//

import Foundation
import CoreLocation

class LocationManager {
  private var manager = CLLocationManager()
  
  init(delegate: CLLocationManagerDelegate) {
    checkAuthorizationStatus()
    manager.delegate = delegate
    manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    manager.distanceFilter = 100
  }
  
  private func checkAuthorizationStatus() {
    let status = CLLocationManager.authorizationStatus()
    print(status)
    if status == .notDetermined {
      manager.requestWhenInUseAuthorization()
    }
  }
  
  func updateLocation() {
    manager.startUpdatingLocation()
  }
}
