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
  @IBOutlet weak var loadingView: UIActivityIndicatorView!
  @IBOutlet weak var generalErrorLabel: UILabel!
  @IBOutlet weak var weatherDataView: UIStackView!
  
  let weatherService = WeatherService()
  var locationManager = CLLocationManager()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    initLocationManager()
    setupView()
    locationManager.startUpdatingLocation()
  }
  
  func initLocationManager() {
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    locationManager.requestWhenInUseAuthorization()
  }
  
  func setupView() {
    weatherDataView(isHidden: true, errorIsHidden: true, isLoading: true)
    imageContainerView.setRounded()
  }
  
  func getWeather(withLocation location: GeoCoordinate) {
    weatherService.getWeather(withLocation: location, onSuccess: updateWeatherData, onFailure: getWeatherOnFailure)
    weatherService.getWeatherForecast(withLocation: location, onSuccess: { weathers in
       
    }, onFailure: getWeatherOnFailure)
  }
  
  func weatherDataView(isHidden: Bool, errorIsHidden: Bool, isLoading: Bool) {
    weatherDataView.isHidden = isHidden
    generalErrorLabel.isHidden = errorIsHidden
    isLoading ? loadingView.startAnimating() : loadingView.stopAnimating()
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
    
    weatherDataView(isHidden: false, errorIsHidden: true, isLoading: false)
  }
  
  func getWeatherOnFailure(_ error: WeatherError?) {
    let currentError = error?.getDescription() ?? "Couldn't get weather data"
    print(currentError)
    generalErrorLabel.text = currentError
    weatherDataView(isHidden: true, errorIsHidden: false, isLoading: false)
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
