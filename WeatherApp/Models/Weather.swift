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
  var temperature: Double?
  var minTemperature: Double?
  var maxTemperature: Double?
  var description: String?
  var countryName: String?
  var cityName: String?
  
  init?(map: Map) {
    
  }
  
  mutating func mapping(map: Map) {
    temperature <- map["main.temp"]
    minTemperature <- map["main.temp_min"]
    maxTemperature <- map["main.temp_max"]
    description <- map["weather.0.main"]
    countryName <- map["sys.country"]
    cityName <- map["name"]
  }
}
