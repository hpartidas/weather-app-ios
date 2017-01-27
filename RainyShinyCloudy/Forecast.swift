//
//  Forecast.swift
//  RainyShinyCloudy
//
//  Created by Hector Partidas on 1/27/17.
//  Copyright © 2017 Hector Partidas. All rights reserved.
//

import UIKit

class Forecast {
    private var _dow: String!
    private var _forecast: String!
    private var _tempHi: Double!
    private var _tempLo: Double!
    
    var dow: String {
        get {
            return _dow
        }
        set {
            _dow = newValue
        }
    }
    
    var forecast: String {
        get {
            return _forecast
        }
        set {
            _forecast = newValue
        }
    }
    
    var tempHi: Double {
        get {
            return _tempHi
        }
        set {
            _tempHi = newValue
        }
    }
    
    var tempLo: Double {
        get {
            return _tempLo
        }
        set {
            _tempLo = newValue
        }
    }
    
    init(dayOfTheWeek: String, forecast: String, tempHi: Double, tempLo: Double) {
        self.dow = dayOfTheWeek
        self.forecast = forecast
        self.tempHi = tempHi
        self.tempLo = tempLo
    }
}
