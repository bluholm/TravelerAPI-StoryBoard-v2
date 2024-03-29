//
//  WeatherLogic.swift
//  TravelerAPI-StoyBoard
//
//  Created by Marc-Antoine BAR on 2022-11-18.
//

import Foundation

final class WeatherLogic {
    
    // MARK: - Properties
    
    let urlSession: URLSession
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    var weatherUrl: String?
    
    // MARK: - Api Calls
    
    func getWeather(completionHandler: @escaping (Result<Weather, NetworkError>) -> Void) {
        
        guard let weatherUrl, let url = URL(string: weatherUrl) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = urlSession.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    completionHandler(.failure(.errorNil))
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    completionHandler(.failure(.statusCode))
                    return
                }
                guard let responseJSON = try? JSONDecoder().decode(Weather.self, from: data) else {
                    completionHandler(.failure(.decoderJSON))
                    return
                }
                completionHandler(.success(responseJSON))
            }
        }
        task.resume()
    }
    
    // MARK: - CUSTOMS
    
    // swiftlint:disable cyclomatic_complexity
    func getCodeWeather(code: Int) -> String {
        var result: String
        switch code {
        case 0:
            result = "sun.max"
        case 1, 2, 3:
            result = "cloud.sun"
        case 45, 48:
            result = "sun.haze"
        case 51, 53, 55:
            result = "cloud.sun.rain"
        case  56, 57:
            result = "cloud.bolt.rain"
        case  61, 63, 65:
            result = "cloud.rain"
        case  66, 67:
            result = "cloud.sleet"
        case  71, 73, 75:
            result = "cloud.snow"
        case  77:
            result = "cloud.hail"
        case  80, 81, 82:
            result = "cloud.bolt.rain.fill"
        case  85, 86:
            result = "cloud.snow.circle.fill"
        case  95:
            result = "cloud.bolt.rain.fill"
        case  96, 99:
            result = "cloud.bolt.rain.circle.fill"
        default:
            result = "questionmark.app.fill"
        }
        return result
    }
}
