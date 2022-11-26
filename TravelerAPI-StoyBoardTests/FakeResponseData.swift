//
//  FakeResponseData.swift
//  TravelerAPI-StoyBoardTests
//
//  Created by Marc-Antoine BAR on 2022-11-22.
//

import Foundation
import TravelerAPI_StoyBoard

class FakeResponseData {

    //MARK: - RESPONSES

    static let  responseOk = HTTPURLResponse(url: URL(string: "http://openclassroom.com")!,
                                             statusCode: 200,httpVersion: nil,headerFields: [:])
    static let responseKO = HTTPURLResponse(url: URL(string: "http://openclassroom.com")!,
                                            statusCode: 500,httpVersion: nil,headerFields: [:])

    //MARK: - ERRORS

    static let error: Error? = nil
    
    //MARK: - CORRECT DATA
    static let url: URL = URL(string: "http://google.com")!

    static var TranslateCorrectJsonData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Translate", withExtension: "json")!
        return try! Data(contentsOf: url)
    }

    //MARK: - INCORRECT DATA

    static let IncorrectDataJson = "error".data(using: .utf8)
}
