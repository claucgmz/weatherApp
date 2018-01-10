//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Caludia Carrillo on 1/9/18.
//  Copyright © 2018 Claudia Carrillo. All rights reserved.
//

import Foundation

class WeatherManager {
  let weatherService = WeatherService()
  func getWeather(withLocation location: GeoCoordinate, onSuccess: @escaping SuccessHandler, onFailure: @escaping ErrorHandler) {
    weatherService.getWeather(withLocation: location, onSuccess: { result in
      print(result!)
      //Weather(map: result)
    }, onFailure: { error in
      print(error as Any)
    })
  }
}
