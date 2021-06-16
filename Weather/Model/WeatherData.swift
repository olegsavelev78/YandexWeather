//
//  WeatherData.swift
//  Weather
//
//  Created by Олег Савельев on 12.06.2021.
//

import Foundation

struct WeatherData: Codable {
    let fact: Fact
    let forecasts: [Forecast]
    let geo_object: GeoObject
}

struct Fact: Codable {
    let temp: Int
    let feels_like: Int
    let icon: String
    let pressure_mm: Int
    let humidity: Int
    let wind_speed: Double
    let wind_dir: String
    let condition: String
}

struct Forecast: Codable {
    let date: String
    let parts: Parts
}

struct Parts: Codable {
    let day: Day
}

struct Day: Codable {
    let temp_min: Int
    let temp_max: Int
}

struct GeoObject: Codable {
    let locality: Country
}

struct Country: Codable {
    let id: Int
    let name: String
}
