//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Caludia Carrillo on 1/9/18.
//  Copyright © 2018 Claudia Carrillo. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class WeatherService {
  
  func getWeather(withLocation location: GeoCoordinate, onSuccess: @escaping SuccessHandler, onFailure: @escaping ErrorHandler) {
    let weatherURL = "\(APIManager.baseURL)/weather?lat=\(location.latitude)&lon=\(location.longitude)&appid=\(APIManager.key)"
    Alamofire.request(weatherURL)
      .validate()
      .responseObject { (response: DataResponse<Weather>) in
        guard let weather = response.result.value else {
          onFailure(WeatherError.invalidData)
          return
        }
        
        onSuccess(weather)
    }
  }
}
