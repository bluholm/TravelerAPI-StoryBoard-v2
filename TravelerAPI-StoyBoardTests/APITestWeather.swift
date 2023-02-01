//
//  APITestWeather.swift
//  TravelerAPI-StoyBoardTests
//
//  Created by Marc-Antoine BAR on 2022-11-27.
//

import XCTest
@testable import TravelerAPI_StoyBoard

final class APITestWeather: XCTestCase {
    
    // MARK: - Properties
    
    var weatherService: WeatherLogic!
    var expectation: XCTestExpectation!
    
    // MARK: - Setup
    
    override func setUp() {
        
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [URLProtocolMock.self]
        let urlSession = URLSession.init(configuration: configuration)
        
        weatherService = WeatherLogic(urlSession: urlSession)
        expectation = expectation(description: "Expectation")
        weatherService.weatherUrl = FakeResponseData.urls
    }
    
    // MARK: - Test Logic
    
    func testGivenDataNilErrorNotNilWhenREquestThenExpectError() {
     
        URLProtocolMock.requestHandler = { _ in
            return (FakeResponseData.responseOk, nil, FakeResponseData.error)
        }
        
        weatherService.getWeather { (result) in
            switch result {
            case .success:
                XCTFail("error is expected")
            case .failure(let error):
                XCTAssertEqual(error, .errorNil)
            }
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2)
              
    }
    
    func testGivenGoodDataWhenREquestThenExpectNoError() {
        
        URLProtocolMock.requestHandler = { _ in
            return (FakeResponseData.responseOk, FakeResponseData.WeatherCorrectJsonData, nil)
        }
        
        weatherService.getWeather { (result) in
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
            return (FakeResponseData.responseOk, FakeResponseData.IncorrectDataJson, nil)
        }
        
        weatherService.getWeather { (result) in
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
            return (FakeResponseData.responseKO, nil, nil)
        }
        
        weatherService.getWeather { (result) in
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
    
    func testGiven0WhenGetIsLaucnhThenExpectAString() {
        let result = "sun.max"
        let number = 0
        let test = weatherService.getCodeWeather(code: number)
        XCTAssertEqual(result, test)
        self.expectation.fulfill()
        wait(for: [expectation], timeout: 2)
    }
    
    func testGiven1WhenGetIsLaucnhThenExpectAString() {
        let result = "cloud.sun"
        let number = 1
        let test = weatherService.getCodeWeather(code: number)
        XCTAssertEqual(result, test)
        self.expectation.fulfill()
        wait(for: [expectation], timeout: 2)
    }
    
    func testGiven45WhenGetIsLaucnhThenExpectAString() {
        let result = "sun.haze"
        let number = 45
        let test = weatherService.getCodeWeather(code: number)
        XCTAssertEqual(result, test)
        self.expectation.fulfill()
        wait(for: [expectation], timeout: 2)
    }
    
    func testGiven51WhenGetIsLaucnhThenExpectAString() {
        let result = "cloud.sun.rain"
        let number = 51
        let test = weatherService.getCodeWeather(code: number)
        XCTAssertEqual(result, test)
        self.expectation.fulfill()
        wait(for: [expectation], timeout: 2)
    }
    
    func testGiven56WhenGetIsLaucnhThenExpectAString() {
        let result = "cloud.bolt.rain"
        let number = 56
        let test = weatherService.getCodeWeather(code: number)
        XCTAssertEqual(result, test)
        self.expectation.fulfill()
        wait(for: [expectation], timeout: 2)
    }
    
    func testGiven61WhenGetIsLaucnhThenExpectAString() {
        let result = "cloud.rain"
        let number = 61
        let test = weatherService.getCodeWeather(code: number)
        XCTAssertEqual(result, test)
        self.expectation.fulfill()
        wait(for: [expectation], timeout: 2)
    }
    
    func testGiven66WhenGetIsLaucnhThenExpectAString() {
        let result = "cloud.sleet"
        let number = 66
        let test = weatherService.getCodeWeather(code: number)
        XCTAssertEqual(result, test)
        self.expectation.fulfill()
        wait(for: [expectation], timeout: 2)
    }
    
    func testGiven71WhenGetIsLaucnhThenExpectAString() {
        let result = "cloud.snow"
        let number = 71
        let test = weatherService.getCodeWeather(code: number)
        XCTAssertEqual(result, test)
        self.expectation.fulfill()
        wait(for: [expectation], timeout: 2)
    }
    
    func testGiven77WhenGetIsLaucnhThenExpectAString() {
        let result = "cloud.hail"
        let number = 77
        let test = weatherService.getCodeWeather(code: number)
        XCTAssertEqual(result, test)
        self.expectation.fulfill()
        wait(for: [expectation], timeout: 2)
    }
    
    func testGiven80WhenGetIsLaucnhThenExpectAString() {
        let result = "cloud.bolt.rain.fill"
        let number = 80
        let test = weatherService.getCodeWeather(code: number)
        XCTAssertEqual(result, test)
        self.expectation.fulfill()
        wait(for: [expectation], timeout: 2)
    }
    
    func testGiven85WhenGetIsLaucnhThenExpectAString() {
        let result = "cloud.snow.circle.fill"
        let number = 85
        let test = weatherService.getCodeWeather(code: number)
        XCTAssertEqual(result, test)
        self.expectation.fulfill()
        wait(for: [expectation], timeout: 2)
    }
    
    func testGiven95WhenGetIsLaucnhThenExpectAString() {
        let result = "cloud.bolt.rain.fill"
        let number = 95
        let test = weatherService.getCodeWeather(code: number)
        XCTAssertEqual(result, test)
        self.expectation.fulfill()
        wait(for: [expectation], timeout: 2)
    }
    
    func testGiven96WhenGetIsLaucnhThenExpectAString() {
        let result = "cloud.bolt.rain.circle.fill"
        let number = 96
        let test = weatherService.getCodeWeather(code: number)
        XCTAssertEqual(result, test)
        self.expectation.fulfill()
        wait(for: [expectation], timeout: 2)
    }
    
    func testGivenAFakeNumberWhenGetIsLaucnhThenExpectAString() {
        let result = "questionmark.app.fill"
        let number = 3332
        let test = weatherService.getCodeWeather(code: number)
        XCTAssertEqual(result, test)
        self.expectation.fulfill()
        wait(for: [expectation], timeout: 2)
    }
    
}
