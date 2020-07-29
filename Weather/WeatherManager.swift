//
//  WeatherManager.swift
//  Weather
//
//  Created by اسرارالحق  on 28/07/2020.
//  Copyright © 2020 اسرارالحق . All rights reserved.
//

import Foundation
import UIKit

protocol WeatherManagerDelegat {
    func didUpdateWeather(_ newData: WeatherData)
    func didFailWithError(_ error: Error)
}

struct WeatherManager {
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=c6e3da79601c742282d5967c913b0f72&units=metric"
    var delegate: WeatherManagerDelegat? = nil
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
//        print(urlString)
        performRequest(urlString: urlString)
        
    }
    
    func performRequest(urlString: String) {
                if let url = URL(string: urlString) {
                    let session = URLSession(configuration: .default)
                    
                    let task = session.dataTask(with: url) { (data,response, error) in
                        if error != nil {
                            print(error?.localizedDescription as Any)
                            return
                        }
                        
                        if let safeData = data {
//                            let dataString = String(data: safeData, encoding: .utf8)
//                            print(dataString)
                            self.parseJSON(recievedWeatherData: safeData)
                            
                        }
                    }
                    task.resume()
                }
            }
    
    func parseJSON(recievedWeatherData: Data) {
        let decoder = JSONDecoder()
        do {
            let weather = try decoder.decode(WeatherData.self, from: recievedWeatherData)
            delegate?.didUpdateWeather(weather)
        } catch {
            delegate?.didFailWithError(error)
        }
    }
    
    func fetchIcon(title: String) -> URL? {
        let urlStringStart = "https://openweathermap.org/img/wn/"
        let urlStringEnd = "@2x.png"
        let urlString = urlStringStart+title+urlStringEnd
        return URL(string: urlString)
    }
    
}

