//
//  WeatherCell.swift
//  RainyShinyCloudy
//
//  Created by Hector Partidas on 1/27/17.
//  Copyright © 2017 Hector Partidas. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var forecastImage: UIImageView!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelForecast: UILabel!
    @IBOutlet weak var labelTempHi: UILabel!
    @IBOutlet weak var labelTempLo: UILabel!
    
    // write set up function
    func configureCell(forecast: Forecast) {
        labelTempLo.text = "\(forecast.tempLo)"
        labelTempHi.text = "\(forecast.tempHi)"
        labelForecast.text = forecast.forecast
        labelDate.text = forecast.dow
        forecastImage.image = UIImage(named: forecast.forecast.capitalized)
    }

}
