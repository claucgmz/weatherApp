//
//  Weather.swift
//  WeatherApp
//
//  Created by Caludia Carrillo on 1/9/18.
//  Copyright © 2018 Claudia Carrillo. All rights reserved.
//

import Foundation
import ObjectMapper

struct Weather: Mappable {
  var date: Date? = Date()
  var temperature: Double = 0
  var minTemperature: Double = 0
  var maxTemperature: Double = 0
  var description: String = ""
  var countryName: String = ""
  var cityName: String = ""
  private var weatherIcon: String?
  
  var weatherIconImage: UIImage? {
    guard let icon = self.weatherIcon else {
      return nil
    }
  
    return UIImage(named: weatherIconImageName(weatherIcon: icon))
  }
  
  var temperatureInCelsius: Int {
    return convertKelvinToCelsius(temperature: self.temperature)
  }
  
  var minTemperatureInCelsius: Int {
    return convertKelvinToCelsius(temperature: self.minTemperature)
  }
  
  var maxTemperatureInCelsius: Int {
    return convertKelvinToCelsius(temperature: self.maxTemperature)
  }
  
  init?(map: Map) {
    
  }
  
  mutating func mapping(map: Map) {
    date <-  (map["dt"], DateTransform())
    temperature <- map["main.temp"]
    minTemperature <- map["main.temp_min"]
    maxTemperature <- map["main.temp_max"]
    description <- map["weather.0.description"]
    countryName <- map["sys.country"]
    cityName <- map["name"]
    weatherIcon <- map["weather.0.icon"]
  }
  
  private func convertKelvinToCelsius(temperature: Double) -> Int {
    return Int(temperature-273.15)
  }
  
  private func weatherIconImageName(weatherIcon: String) -> String {
    switch weatherIcon {
      case "01d":
        return "sunny"
      case "01n":
        return "clearnight"
      case "02d":
        return "cloudyday"
      case "02n":
        return "cloudynight"
      case "03d", "03n", "04d", "04n":
        return "cloudy"
      case "09d", "09n":
        return "rainy"
      case "10d", "10n":
        return "rainy"
      case "11d", "11n":
        return "thunderstorm"
      case "13d", "13n":
        return "snowy"
      default:
        return "windy"
    }
  }
}

