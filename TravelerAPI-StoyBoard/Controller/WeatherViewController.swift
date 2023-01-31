//
//  WeatherViewController.swift
//  TravelerAPI-StoyBoard
//
//  Created by Marc-Antoine BAR on 2022-11-12.
//

import UIKit

final class WeatherViewController: UIViewController {
    
    // MARK: Properties
    
    let weatherUrlUp = "https://api.open-meteo.com/v1/forecast?latitude=40.71&longitude=-74.01&current_weather=true"
    let weatherUrlDown = "https://api.open-meteo.com/v1/forecast?latitude=48.8567&longitude=2.3510&current_weather=true"
    
    @IBOutlet var imageWeatherUp: UIImageView!
    @IBOutlet var imageWeatherDown: UIImageView!
    @IBOutlet var labelTemperatureUp: UILabel!
    @IBOutlet var labelTemperatureDown: UILabel!
    @IBOutlet var toggleIndicatorUp: UIActivityIndicatorView!
    @IBOutlet var toggleIndicatorDown: UIActivityIndicatorView!
    let model = WeatherLogic()
    
    // MARK: Life Cycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        model.weatherUrl = weatherUrlUp
        model.weatherUrl = weatherUrlDown
        
        self.model.getWeather { [weak self] result in
            switch result {
            case .success(let weatherUp):
                self?.toggleIndicatorUp.isHidden = false
                self?.updateFieldWeatherUp(element: weatherUp)
            case .failure(.badURL):
                self?.presentAlert(message: TypeError.badUrl)
            case .failure(.decoderJSON):
                self?.presentAlert(message: TypeError.decoderJSON)
            case .failure(.statusCode):
                self?.presentAlert(message: TypeError.StatusCode200)
            case .failure(.errorNil):
                self?.presentAlert(message: TypeError.ErrorNil)
            }
        }
        
        self.model.getWeather { [weak self] result in
            switch result {
            case .success(let weatherDown):
                self?.toggleIndicatorDown.isHidden = false
                self?.updateFieldWeatherDown(element: weatherDown)
            case .failure(.badURL):
                self?.presentAlert(message: TypeError.badUrl)
            case .failure(.decoderJSON):
                self?.presentAlert(message: TypeError.decoderJSON)
            case .failure(.statusCode):
                self?.presentAlert(message: TypeError.StatusCode200)
            case .failure(.errorNil):
                self?.presentAlert(message: TypeError.ErrorNil)
            }
        }
    }
    
    // MARK: Privates
    
    func displayWeatherUp(icon: String, temperature: Double) {
        toggleIndicatorUp.isHidden = true
        labelTemperatureUp.text = "\(temperature) °"
        imageWeatherUp.image = UIImage(systemName: icon, withConfiguration: UIImage.SymbolConfiguration(pointSize: 60))
        
    }
    
    func displayWeatherDown(icon: String, temperature: Double) {
        toggleIndicatorDown.isHidden = true
        labelTemperatureDown.text = "\(temperature) °"
        imageWeatherDown.image = UIImage(systemName: icon, withConfiguration: UIImage.SymbolConfiguration(pointSize: 60))
    }
    
    private func updateFieldWeatherUp(element: Weather) {
        let icon = model.getCodeWeather(code: element.currentWeather.weathercode)
        let temperature = element.currentWeather.temperature
        self.displayWeatherUp(icon: icon, temperature: temperature)
    }
    
    private func updateFieldWeatherDown(element: Weather) {
        let icon = model.getCodeWeather(code: element.currentWeather.weathercode)
        let temperature = element.currentWeather.temperature
        self.displayWeatherDown(icon: icon, temperature: temperature)
    }
}
