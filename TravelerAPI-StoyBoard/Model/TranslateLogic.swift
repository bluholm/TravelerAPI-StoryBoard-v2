//
//  Translate.swift
//  TravelerAPI-StoyBoard
//
//  Created by Marc-Antoine BAR on 2022-11-12.
//

import Foundation

final class TranslateLogic {
   
    // MARK: - Properties
    
    let urlSession: URLSession
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    private let apiKey = "24e4c008-11b5-3633-cfcf-25adfbedf2cf:fx"
    private let baseUrl = "https://api-free.deepl.com/v2/translate"
    var translateText: String = ""
    var parameters: [(String, String)] {
        return [
            ("auth_key", apiKey),
            ("target_lang", "EN"),
            ("text", translateText)]
    }
    
    // MARK: - API CALL
    
    func getTextTranslated(completionHandler: @escaping (Result<Translate, NetworkError>) -> Void) {
        
        guard let translateUrl: URL  = .init(string: baseUrl) else { return }
        let url: URL = URLEncodable.encode(with: translateUrl, and: parameters)
        let request = URLRequest(url: url)
        
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
                guard let responseJSON = try? JSONDecoder().decode(Translate.self, from: data) else {
                        completionHandler(.failure(.decoderJSON))
                    return
                }
                completionHandler(.success(responseJSON))
            }
        }
        task.resume()
    }
}
