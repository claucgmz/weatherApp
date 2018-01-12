//
//  WeatherCell.swift
//  WeatherApp
//
//  Created by Caludia Carrillo on 1/11/18.
//  Copyright © 2018 Claudia Carrillo. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {
  @IBOutlet weak var weekDayLabel: UILabel!
  @IBOutlet weak var iconImageView: UIImageView!
  @IBOutlet weak var minTemperatureLabel: UILabel!
  @IBOutlet weak var maxTemperatureLabel: UILabel!
  
  func configure(withWeather weather: Weather, color: UIColor) {
    self.maxTemperatureLabel.text = "\(weather.maxTemperatureInCelsius)°"
    self.minTemperatureLabel.text = "\(weather.maxTemperatureInCelsius)°"
    self.weekDayLabel.text = weather.date?.dayOfWeek
    self.iconImageView.image = weather.weatherIconImage
  }
  
}
