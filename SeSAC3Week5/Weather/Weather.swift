//
//  Weather.swift
//  SeSAC3Week5
//
//  Created by 이승현 on 2023/08/17.
//

import Foundation

// MARK: - Welcome
struct WeatherData: Codable {
    let id: Int
    let wind: Wind
    let coord: Coord
    let dt: Int
    let weather: [Weather]
    let cod: Int
    let name: String
    let clouds: Clouds
    let sys: Sys
    let visibility: Int
    let main: Main
    let base: String
    let timezone: Int
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int
}

// MARK: - Coord
struct Coord: Codable {
    let lat, lon: Double
}

// MARK: - Main
struct Main: Codable {
    let seaLevel: Int
    let temp: Double
    let pressure, humidity: Int
    let tempMax: Double
    let grndLevel: Int
    let feelsLike, tempMin: Double

    enum CodingKeys: String, CodingKey {
        case seaLevel = "sea_level"
        case temp, pressure, humidity
        case tempMax = "temp_max"
        case grndLevel = "grnd_level"
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
    }
}

// MARK: - Sys
struct Sys: Codable {
    let sunrise: Int
    let country: String
    let id, type, sunset: Int
}

// MARK: - Weather
struct Weather: Codable {
    let main: String
    let id: Int
    let description, icon: String
}

// MARK: - Wind
struct Wind: Codable {
    let gust, speed: Double
    let deg: Int
}
