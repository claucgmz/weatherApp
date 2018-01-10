//
//  WeatherError.swift
//  WeatherApp
//
//  Created by Caludia Carrillo on 1/9/18.
//  Copyright © 2018 Claudia Carrillo. All rights reserved.
//

import Foundation

enum WeatherError: Error {
  case noGeoLocation
  case invalidData
  
  func getDescription() -> String {
    switch self {
      case .noGeoLocation:
        return "Couldn't get your current location."
      default:
        return "Couldn't get weather data"
    }
  }
}

