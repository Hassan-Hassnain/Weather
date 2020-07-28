//
//  WeaterData.swift
//  Weather
//
//  Created by اسرارالحق  on 28/07/2020.
//  Copyright © 2020 اسرارالحق . All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    var coord: Coord
    var base: String
    var main: Main
    var visibility: Int
    var wind: Wind
    var clouds: Clouds
    var dt: Int
    var sys: Sys
    var timezone: Int
    var id: Int
    var name: String
    var cod: Int
    var weather: [WeatherInfo]
    
}
struct Main: Codable{
    let temp: Double
    let feels_like: Double
    let pressure: Double
    let humidity: Double
    let temp_min: Double
    let temp_max: Double
}

struct Wind: Codable {
    var speed: Double
    var deg: Int
}

struct Clouds: Codable {
    var all: Int
}

struct Sys: Codable {
    var type: Int
    var id: Int
    var country: String
    var sunrise: Int
    var sunset: Int
}

struct WeatherInfo: Codable {
    var id: Int
    var main: String
    var description: String
    let icon: String
    
}

struct Coord: Codable {
    var lon: Double
    var lat: Double
}
