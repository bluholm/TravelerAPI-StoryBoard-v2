//
//  Weather.swift
//  TravelerAPI-StoyBoard
//
//  Created by Marc-Antoine BAR on 2022-11-18.
//

import Foundation

struct Weather: Codable {
    
    let latitude, longitude, generationtimeMS: Double
    let utcOffsetSeconds: Int
    let timezone, timezoneAbbreviation: String
    let elevation: Double
    let currentWeather: CurrentWeather
    
    enum CodingKeys: String, CodingKey {
        
        case latitude, longitude
        case generationtimeMS = "generationtime_ms"
        case utcOffsetSeconds = "utc_offset_seconds"
        case timezone
        case timezoneAbbreviation = "timezone_abbreviation"
        case elevation
        case currentWeather = "current_weather"
    }
    
}

struct CurrentWeather: Codable {
    
    let temperature, windspeed, winddirection: Double
    let weathercode: Int
    let time: String
}
