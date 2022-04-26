//
//  Weather.swift
//  itronDay
//
//  Created by Сережа on 16.03.2022.
//

import Foundation

struct Result: Codable {
    let lat: Double
    let lon: Double
    let timezone: String
    let current: Current
}

struct Current: Codable {
    let dt: Int
    let sunrise: Int
    let sunset: Int
    let temp: Double
    let feels_like: Double
    let pressure: Int
    let humidity: Int
    let dew_point: Double
    let uvi: Double
    let clouds: Int
    let wind_speed: Double
    let wind_deg: Int
    let weather: [Weather]
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

