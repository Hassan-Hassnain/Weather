//
//  ViewController.swift
//  Weather
//
//  Created by اسرارالحق  on 28/07/2020.
//  Copyright © 2020 اسرارالحق . All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var cityNameTextField: UITextField!
    @IBOutlet weak var weatherDetailsLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherManager.delegate = self
        cityNameTextField.delegate = self
    }
    @IBAction func searchButton(_ sender: Any) {
        if let cityName = cityNameTextField.text {
            weatherManager.fetchWeather(cityName: cityName)
        }
    }
    
    func updateWeatherOnScreen(data: WeatherData?, error: Error? = nil) {
        DispatchQueue.main.async {
            var info: String = ""
            if let error = error {
                self.weatherDetailsLabel.text = ""
                info = error.localizedDescription as String
                self.cityNameTextField.text = ""
            } else if let data = data  {
                info = """
                Date            [ \(data.dt) ]
                -----------------------------------------------
                City Name       [ \(data.name) ]         Country    [ \(data.sys.country) ]
                -----------------------------------------------
                Longitude       [ \(data.coord.lat) ]    latitude   [ \(data.coord.lon) ]
                -----------------------------------------------
                Temprature      [ \(data.main.temp) ]    Feels Like [ \(data.main.feels_like) ]
                -----------------------------------------------
                Min Temp        [ \(data.main.temp_min)] Max Temp   [ \(data.main.temp_max) ]
                -----------------------------------------------
                Air Pressure    [ \(data.main.pressure) ]Humidity   [ \(data.main.humidity) ]
                -----------------------------------------------
                Main    [ \(data.weather[0].main) ]Humidity   [ \(data.weather[0].description) ]
                -----------------------------------------------
                Base            [ \(data.base) ]
                -----------------------------------------------
                Visibility      [ \(data.visibility) ]
                -----------------------------------------------
                Air Speed       [ \(data.wind.speed) ]   Direction  [ \(data.wind.deg) ]
                -----------------------------------------------
                Clouds status   [ \(data.clouds.all) ]
                -----------------------------------------------
                Sunrise         [ \(data.sys.sunrise) ]
                -----------------------------------------------
                Sunset          [ \(data.sys.sunset) ]
                -----------------------------------------------
                Time Zone       [ \(data.timezone) ]
                -----------------------------------------------
                
                """
            }
            self.weatherDetailsLabel.text = info
            if let url = self.weatherManager.fetchIcon(title: (data?.weather[0].icon)!){
                self.weatherIcon.load(url: url)
            }
        }
    }
    
}

extension ViewController: UISearchTextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchButton(textField)
        textField.resignFirstResponder()
        return true
    }
}

extension ViewController: WeatherManagerDelegat {
    
    func didUpdateWeather(_ newData: WeatherData) {
        //        print(newData)
        updateWeatherOnScreen(data: newData)
    }
    
    func didFailWithError(_ error: Error) {
        print(error.localizedDescription)
        updateWeatherOnScreen(data: nil, error: error)
    }
}


