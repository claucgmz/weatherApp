//
//  UIImageView+form.swift
//  WeatherApp
//
//  Created by Caludia Carrillo on 1/10/18.
//  Copyright © 2018 Claudia Carrillo. All rights reserved.
//

import UIKit

extension UIView {
  func setRounded() {
    let radius = self.bounds.width
    self.layer.cornerRadius = radius
  }
}
