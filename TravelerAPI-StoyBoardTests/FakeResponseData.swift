//
//  FakeResponseData.swift
//  TravelerAPI-StoyBoardTests
//
//  Created by Marc-Antoine BAR on 2022-11-22.
//

import Foundation


class FakeResponseData {
    
    static let  responseOk = HTTPURLResponse(url: URL(string: "http://openclassroom.com")!,
                                             statusCode: 200,
                                             httpVersion: nil,
                                             headerFields: [:])
    static let responseKO = HTTPURLResponse(url: URL(string: "http://openclassroom.com")!,
                                            statusCode: 500,
                                            httpVersion: nil,
                                            headerFields: [:])
    
    class FakeError: Error {
        static let error = FakeError()
    }

    static var TranslateCorrectJsonData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Translate", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
    
    static let IncorrectDataJson = "erreur".data(using: .utf8)
    
}
