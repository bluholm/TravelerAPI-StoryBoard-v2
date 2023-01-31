//
//  APITestCurrency.swift
//  TravelerAPI-StoyBoardTests
//
//  Created by Marc-Antoine BAR on 2022-11-27.
//

import XCTest
@testable import TravelerAPI_StoyBoard

final class APITestCurrency: XCTestCase {
    
    // MARK: - Properties
    
    var currencyLogic: CurrencyLogic!
    var expectation: XCTestExpectation!
    
    // MARK: - Setup
    
    override func setUp() {
        
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [URLProtocolMock.self]
        let urlSession = URLSession.init(configuration: configuration)
        
        currencyLogic = CurrencyLogic(urlSession: urlSession)
        expectation = expectation(description: "Expectation")
        
    }
    
    // MARK: - Test Logic
    
    func testGivenGoodDataWhenREquestThenExpectNoError() {
        
        URLProtocolMock.requestHandler = { _ in
            return (FakeResponseData.responseOk!, FakeResponseData.CurrencyCorrectJsonData)
        }
        
        currencyLogic.getRates(to: "EUR", amount: 133) { (result) in
            switch result {
            case .success(let post):
                XCTAssertNotNil(post)
            case .failure:
                XCTFail("succes is expected")
            }
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
        
    }
    
    func testGivenBadDataWhenREquestThenExpectError() {
        
        URLProtocolMock.requestHandler = { _ in
            return (FakeResponseData.responseOk!, FakeResponseData.IncorrectDataJson)
        }
        
        currencyLogic.getRates(to: "EUR", amount: 133) { (result) in
            switch result {
            case .success:
                XCTFail("error is expected")
            case .failure(let error):
                XCTAssertEqual(error, .decoderJSON)
            }
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
        
    }
    
    func testGivenBadAnswerWhenREquestThenExpectError() {
        
        URLProtocolMock.requestHandler = { _ in
            return (FakeResponseData.responseKO!, nil)
        }
        
        currencyLogic.getRates(to: "EUR", amount: 133) { (result) in
            switch result {
            case .success:
                XCTFail("error is expected")
            case .failure(let error):
                XCTAssertEqual(error, .statusCode)
            }
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
        
    }
    
}
