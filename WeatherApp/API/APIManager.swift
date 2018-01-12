//
//  APIManager.swift
//  WeatherApp
//
//  Created by Caludia Carrillo on 1/9/18.
//  Copyright © 2018 Claudia Carrillo. All rights reserved.
//

import Foundation

typealias JSONStandard = Dictionary<String, AnyObject>
typealias JSONDictionary = [String: Any]
typealias JSONArray = [JSONDictionary]
typealias SuccessHandler = (Weather?) -> Void
typealias ForecastSuccessHandler = ([Weather?]) -> Void
typealias ErrorHandler = (WeatherError?) -> Void

class APIManager {
  static let sharedInstance = APIManager()
  let baseURL = "http://api.openweathermap.org/data/2.5"
  let key = "0d616c2ea47e334eec902903eca13e40"
  var languageCode: String = ""
  
  init() {
    let locale = Locale.current
    guard let languageCode = locale.languageCode else {
      return
    }
    
    self.languageCode = languageCode
  }
}
