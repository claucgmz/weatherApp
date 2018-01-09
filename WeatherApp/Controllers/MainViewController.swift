//
//  MainViewController.swift
//  WeatherApp
//
//  Created by Caludia Carrillo on 1/9/18.
//  Copyright © 2018 Claudia Carrillo. All rights reserved.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController {
  
  let weatherService = WeatherService()
  var locationManager = CLLocationManager()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    initLocationManager()
    locationManager.startUpdatingLocation()
  }
  
  func initLocationManager() {
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    locationManager.requestWhenInUseAuthorization()
  }
  
  func getWeather(withLocation location: GeoCoordinate) {
    weatherService.getWeather(withLocation: location, onSuccess: updateWeatherData, onFailure: getWeatherOnFailure)
  }
  
  func updateWeatherData(weather: Weather?) {
    guard let currentWeather = weather else {
      getWeatherOnFailure(WeatherError.invalidData)
      return
    }
    
    print(currentWeather)
  }
  
  func getWeatherOnFailure(_ error: WeatherError?) {
    print(error?.getDescription() ?? "Couldn't get weather data")
  }

}

/*
 // MARK: - CLLocationManagerDelegate methods
 */
extension MainViewController: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let lastLocation = locations.last else {
      getWeatherOnFailure(WeatherError.noGeoLocation)
      return
    }
  
    let coordinates = lastLocation.coordinate
    let location = GeoCoordinate(latitude: coordinates.latitude, longitude: coordinates.longitude)
    getWeather(withLocation: location)
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    getWeatherOnFailure(WeatherError.noGeoLocation)
  }
}
