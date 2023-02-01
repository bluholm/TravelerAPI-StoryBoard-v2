//
//  URLEncodable.swift
//  TravelerAPI-StoyBoard
//
//  Created by Marc-Antoine BAR on 2022-11-12.
//

import Foundation

final class URLEncodable {
    
    static func encode(with baseURL: URL, and parameters: [(String, Any)]?) -> URL {
        guard var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: false),
              let parameters = parameters,
              !parameters.isEmpty else {
            return baseURL
        }
        urlComponents.queryItems = parameters.map { URLQueryItem(name: $0, value: "\($1)") }
        guard let url = urlComponents.url else { return baseURL }
        return url
    }
}
