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
typealias ErrorHandler = (WeatherError?) -> Void

class APIManager {
  static let baseURL = "http://api.openweathermap.org/data/2.5"
  static let key = "0d616c2ea47e334eec902903eca13e40"
}
