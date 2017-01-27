//
//  Weather.swift
//  RainyShinyCloudy
//
//  Created by Hector Partidas on 1/26/17.
//  Copyright © 2017 Hector Partidas. All rights reserved.
//

import UIKit
import Alamofire

class Weather {
    private var _date: String!
    private var _cityName: String!
    private var _weatherType: String!
    private var _currentTemperature: Double!
    private var _imageUrl: String!
    
    var cityName: String {
        get {
            return _cityName
        }
        set {
            _cityName = newValue
        }
    }
    var date: String {
        let dateStyle = DateFormatter()
        dateStyle.dateStyle = .long
        dateStyle.timeStyle = .none
        let currentDate = dateStyle.string(from: Date())
        self._date = "Today, \(currentDate)"
        return self._date
    }
    var weatherType: String {
        get {
            return _weatherType
        }
        set {
            _weatherType = newValue
        }
    }
    var currentTemperature: Double {
        get {
            return _currentTemperature
        }
        set {
            _currentTemperature = newValue
        }
    }
    var imageUrl: String {
        get {
            return _imageUrl
        }
        set {
            _imageUrl = newValue
        }
    }
    var forecasts: [Forecast] = [Forecast]()
    
//    init(city: String, weather: String) {
//        self.cityName = city
//        self.weatherType = weather
//        //self.date = self.date
//        self.currentTempuratue = 30.0
//    }
    
    func downloadWeatherDetails(completed: @escaping () -> ()) {
        let currentWeatherUrl = URL(string: "\(BASE_URL)\(CURRENT_WEATHER_ENDPOINT)?key=\(API_KEY)&q=-24,35&days=6")!
        
        Alamofire.request(currentWeatherUrl).responseJSON { response in
            let result = response.result
//            print("\(response)")
            guard let dictionary = result.value as? Dictionary<String, AnyObject> else {
                // this is bad!
                return
            }
            
            guard let location = dictionary["location"] as? Dictionary<String, AnyObject> else {
                // error handling here
                return
            }
            guard let name = location["name"] as? String else {
                // error handling
                return
            }
                    
            guard let date = location["localtime"] as? String else {
                // error handling
                return
            }
            
            guard let weather = dictionary["current"] as? Dictionary<String, AnyObject> else {
                // error handling
                return
            }
            
            guard let temp = weather["temp_c"] as? Double else {
                // error handling
                return
            }
            
            guard let condition = weather["condition"] as? Dictionary<String, AnyObject> else {
                // error handling
                return
            }
            
            guard let weatherType =  condition["text"] as? String else {
                // error handling
                return
            }
            
            guard let imageUrl = condition["icon"] as? String else {
                // error handling
                return
            }
            
            guard let forecasts = dictionary["forecast"] as? Dictionary<String, AnyObject> else {
                // error habdling
                return
            }
            
            guard let forecastDay = forecasts["forecastday"] as? [Dictionary<String, AnyObject>] else {
                return
            }
            
            for i in 1 ..< 6 {
                guard let dow = forecastDay[i]["date"] as? String else {
                    return
                }
                
                guard let temp = forecastDay[i]["day"] as? Dictionary<String, AnyObject> else {
                    return
                }
                
                guard let tempHi = temp["maxtemp_c"] as? Double else {
                    return
                }
                
                guard let tempLo = temp["mintemp_c"] as? Double else {
                    return
                }
                
                guard let condition = temp["condition"] as? Dictionary<String, AnyObject> else {
                    return
                }
                
                guard let forecast = condition["text"] as? String else {
                    return
                }
                
                self.forecasts.append(Forecast(dayOfTheWeek: dow, forecast: forecast, tempHi: tempHi, tempLo: tempLo))
                
            }
            
            self.cityName = name.capitalized
            self._date = date
        
            self.currentTemperature = temp
            self.weatherType = weatherType
            self.imageUrl = imageUrl
            
            completed()
        }
    }
}
