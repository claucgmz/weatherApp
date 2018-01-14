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
  
  @IBOutlet private var locationNameLabel: UILabel!
  @IBOutlet private var descriptionLabel: UILabel!
  @IBOutlet private var temperatureLabel: UILabel!
  @IBOutlet private var iconImageView: UIImageView!
  @IBOutlet private var weekdayLabel: UILabel!
  @IBOutlet private var dateLabel: UILabel!
  @IBOutlet private var imageContainerView: UIView!
  @IBOutlet private var minTemperatureLabel: UILabel!
  @IBOutlet private var maxTemperatureLabel: UILabel!
  @IBOutlet private var loadingView: UIActivityIndicatorView!
  @IBOutlet private var generalErrorLabel: UILabel!
  @IBOutlet private var weatherDataView: UIStackView!
  
  private let weatherService = WeatherService()
  private var locationManager: LocationManager?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    locationManager = LocationManager(delegate: self)
    locationManager?.updateLocation()
  }

  private func setupView() {
    weatherDataView(isHidden: true, errorIsHidden: true, isLoading: true)
    imageContainerView.setRounded()
  }
  
  private func getWeather(withLocation location: GeoCoordinate) {
    weatherService.getWeather(withLocation: location, onSuccess: updateWeatherData, onFailure: getWeatherOnFailure)
  }
  
  private func weatherDataView(isHidden: Bool, errorIsHidden: Bool, isLoading: Bool) {
    weatherDataView.isHidden = isHidden
    generalErrorLabel.isHidden = errorIsHidden
    isLoading ? loadingView.startAnimating() : loadingView.stopAnimating()
  }
  
  private func updateWeatherData(weather: Weather?) {
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
  
  private func getWeatherOnFailure(_ error: WeatherError?) {
    let currentError = error?.description ?? "Couldn't get weather data"
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
