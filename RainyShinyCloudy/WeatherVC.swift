//
//  ViewController.swift
//  RainyShinyCloudy
//
//  Created by Hector Partidas on 1/26/17.
//  Copyright © 2017 Hector Partidas. All rights reserved.
//

import UIKit

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelTemp: UILabel!
    @IBOutlet weak var labelCity: UILabel!
    @IBOutlet weak var labelForecast: UILabel!
    @IBOutlet weak var imageForecast: UIImageView!
    @IBOutlet weak var tableview: UITableView!
    
    var currentWeather: Weather!
    var forecasts: [Forecast] = [Forecast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self
    
        currentWeather = Weather()
        
        currentWeather.downloadWeatherDetails {
            self.forecasts = self.currentWeather.forecasts
            self.tableview.reloadData()
            self.updateUI()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableview.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell else {
            return WeatherCell()
        }
        
        if !isValidForecast() {
            return WeatherCell()
        }
        
        guard let forecast = forecasts[indexPath.row] as? Forecast else {
            let forecast = Forecast(dayOfTheWeek: "",forecast: "",tempHi: 0.0,tempLo: 0.0)
            cell.configureCell(forecast: forecast)
            return cell
        }
        
        cell.configureCell(forecast: forecast)
        
        return cell
    }
    
    func updateUI() {
        labelCity.text = currentWeather.cityName
        labelTemp.text = "\(currentWeather.currentTemperature)"
        labelForecast.text = currentWeather.weatherType.capitalized
        labelDate.text = currentWeather.date
        let image = UIImage(named: currentWeather.weatherType.capitalized)
        imageForecast.image = image
    }
    
    func isValidForecast() -> Bool {
        return forecasts.count > 0 ? true : false
    }
}

