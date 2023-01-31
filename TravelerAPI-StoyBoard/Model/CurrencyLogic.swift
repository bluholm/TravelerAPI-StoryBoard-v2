//
//  CurrencyLogic.swift
//  TravelerAPI-StoyBoard
//
//  Created by Marc-Antoine BAR on 2022-11-14.
//

import Foundation

final class CurrencyLogic {
    
    // MARK: Properties
    
    private let apiKey = "gaJkuUOG9lMrds5hLxbVgI6cUklegcvW"
    let urlSession: URLSession
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    // MARK: Actions
    
    func getRates(to: String, amount: Double, completionHandler: @escaping (Result<Currency, NetworkError>) -> Void ) {
        let to = to
        let from = "USD"
        let amount = amount
        let currencyUrl = "https://api.apilayer.com/fixer/convert?to=\(to)&from=\(from)&amount=\(amount)"

        guard let url = URL(string: currencyUrl) else {
            completionHandler(.failure(.badURL))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue(apiKey, forHTTPHeaderField: "apiKey")
        
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
                guard let responseJSON = try? JSONDecoder().decode(Currency.self, from: data) else {
                    completionHandler(.failure(.decoderJSON))
                    return
                }
                completionHandler(.success(responseJSON))
            }
        }
        task.resume()
    }
    
}
