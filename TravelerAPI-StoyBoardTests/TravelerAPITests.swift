//
//  TravelerAPI_StoyBoardTests.swift
//  TravelerAPI-StoyBoardTests
//
//  Created by Marc-Antoine BAR on 2022-11-19.
//

import XCTest
@testable import TravelerAPI_StoyBoard

final class TravelerAPI_StoyBoardTests: XCTestCase {
    
    //MARK: - PROPERTIES
    var MyTranslateLogic: TranslateLogic!
    var expectation: XCTestExpectation!
    let apiURL = URL(string: "https://mylittlePoney.com")!
    
    //MARK: - OVERRIDE
    override func setUp() {
        
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [URLProtocolMock.self]
        let urlSession = URLSession.init(configuration: configuration)
        
        MyTranslateLogic = TranslateLogic(urlSession: urlSession)
        expectation = expectation(description: "Expectation")
    }
    
    //MARK: - TEST LOGIC
    func testParsingFailure() {
        // Prepare response
        let data = Data()
        URLProtocolMock.requestHandler = { request in
          let response = HTTPURLResponse(url: self.apiURL, statusCode: 200, httpVersion: nil, headerFields: nil)!
          return (response, data)
        }
        
        // Call API.
        MyTranslateLogic.getTextTranslated { (result) in
          switch result {
          case .success(_):
            XCTFail("Success response was not expected.")
          case .failure(let error):
              debugPrint("aa \(error)")
              
              XCTAssertEqual(error, .decoderJSON , "Parsing error was expected.")
          }
          self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
      }

}
