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
  
  @IBOutlet weak var locationNameLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var temperatureLabel: UILabel!
  @IBOutlet weak var iconImageView: UIImageView!
  @IBOutlet weak var weekdayLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var imageContainerView: UIView!
  @IBOutlet weak var minTemperatureLabel: UILabel!
  @IBOutlet weak var maxTemperatureLabel: UILabel!
  
  let weatherService = WeatherService()
  var locationManager = CLLocationManager()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    initLocationManager()
    locationManager.startUpdatingLocation()
    viewSetup()
  }
  
  func initLocationManager() {
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    locationManager.requestWhenInUseAuthorization()
  }
  
  func viewSetup() {
    imageContainerView.setRounded()
  }
  
  func getWeather(withLocation location: GeoCoordinate) {
    weatherService.getWeather(withLocation: location, onSuccess: updateWeatherData, onFailure: getWeatherOnFailure)
  }
  
  func updateWeatherData(weather: Weather?) {
    guard let currentWeather = weather else {
      getWeatherOnFailure(WeatherError.invalidData)
      return
    }
    
    locationNameLabel.text = "\(currentWeather.cityName),\(currentWeather.countryName)"
    descriptionLabel.text = currentWeather.description
    temperatureLabel.text = "\(currentWeather.temperatureInCelsius)˚"
    minTemperatureLabel.text = "\(currentWeather.minTemperatureInCelsius)˚"
    maxTemperatureLabel.text = "\(currentWeather.maxTemperatureInCelsius)˚"
    iconImageView.image = currentWeather.weatherIconImage
    dateLabel.text = currentWeather.date?.toString(withFormat: "MMMM, dd YYYY")
    weekdayLabel.text = currentWeather.date?.dayOfWeek
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
