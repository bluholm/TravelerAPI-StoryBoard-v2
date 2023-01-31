//
//  TravelerAPI_StoyBoardTests.swift
//  TravelerAPI-StoyBoardTests
//
//  Created by Marc-Antoine BAR on 2022-11-19.
//

import XCTest
@testable import TravelerAPI_StoyBoard

final class TravelerAPI_StoyBoardTests: XCTestCase {
    
    // MARK: - Properties
    
    var translateService: TranslateLogic!
    var expectation: XCTestExpectation!
    
    // MARK: - Setup
    
    override func setUp() {
        
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [URLProtocolMock.self]
        let urlSession = URLSession.init(configuration: configuration)
        
        translateService = TranslateLogic(urlSession: urlSession)
        expectation = expectation(description: "Expectation")
    }
    
    // MARK: - Test TranslateLogic
    
    func testGivenGoodDataWhenREquestThenExpectNoError() {
        
        URLProtocolMock.requestHandler = { _ in
            return (FakeResponseData.responseOk!, FakeResponseData.TranslateCorrectJsonData)
        }
        
        translateService.getTextTranslated { (result) in
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
        
        translateService.getTextTranslated { (result) in
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
        
        translateService.getTextTranslated { (result) in
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
