//
//  Error.swift
//  TravelerAPI-StoyBoard
//
//  Created by Marc-Antoine BAR on 2022-11-16.
//

enum NetworkError: Error {
    case BadUrl
    case ErrorNil
    case StatusCode200
    case decoderJSON
}


final class TypeError {
    static let badUrl = "url seems to be incorrect"
    static let decoderJSON = "decoder JSon not working"
    static let StatusCode200 = "error status code HTTPRequest not working"
    static let ErrorNil = "error Nil"
    static let AmountConversion = "Amount impossible to convert"
    static let AmountIncorrect = "Amount Incorrect"
}
