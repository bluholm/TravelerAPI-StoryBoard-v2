//
//  FakeResponseData.swift
//  TravelerAPI-StoyBoardTests
//
//  Created by Marc-Antoine BAR on 2022-11-22.
//

import Foundation
import TravelerAPI_StoyBoard

final class FakeResponseData {

    static let urls = "http://google.com"
    
    // MARK: - RESPONSES

    static let  responseOk = HTTPURLResponse(url: URL(string: urls)!,
                                             statusCode: 200,
                                             httpVersion: nil,
                                             headerFields: [:])
    static let responseKO = HTTPURLResponse(url: URL(string: urls)!,
                                            statusCode: 500,
                                            httpVersion: nil,
                                            headerFields: [:])

    // MARK: - ERRORS

    static let error: Error? = nil
    
    // MARK: - CORRECT DATA
    static let url: URL = URL(string: urls)!

    static var TranslateCorrectJsonData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Translate", withExtension: "json")!
        // swiftlint: disable force_try
        return try! Data(contentsOf: url)
    }
    
    static var WeatherCorrectJsonData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Weather", withExtension: "json")!
        return try? Data(contentsOf: url)
    }
    
    static var CurrencyCorrectJsonData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Currency", withExtension: "json")!
        return try? Data(contentsOf: url)
    }

    // MARK: - INCORRECT DATA

    static let IncorrectDataJson = "error".data(using: .utf8)
}
