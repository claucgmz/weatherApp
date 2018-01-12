//
//  WeatherForecast.swift
//  WeatherApp
//
//  Created by Caludia Carrillo on 1/11/18.
//  Copyright © 2018 Claudia Carrillo. All rights reserved.
//

import Foundation
import ObjectMapper

struct WeatherForecast: Mappable {
  let weathers = [Weather]()
  
  init?(map: Map) {
    let mapJSON = map.JSON
    if mapJSON["list"] == nil {
      return nil
    }
  }
  
  mutating func mapping(map: Map) {

  }

}
