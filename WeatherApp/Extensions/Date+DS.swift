//
//  Date+DS.swift
//  WeatherApp
//
//  Created by Caludia Carrillo on 1/10/18.
//  Copyright © 2018 Claudia Carrillo. All rights reserved.
//

import Foundation

extension Date {
  func toString(withFormat format: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    
    return dateFormatter.string(from: self)
  }
  
  var dayOfWeek: String {
    let dateFormatter = DateFormatter()
    let currentWeekday = Calendar.current.component(.weekday, from: self)
    
    return dateFormatter.weekdaySymbols[currentWeekday]
  }
}
