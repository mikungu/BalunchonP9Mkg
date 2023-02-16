//
//  WeatherTests.swift
//  WeatherTests
//
//  Created by Mikungu Giresse on 05/02/23.
//

import XCTest

@testable import BalunchonP9

final class WeatherTests: XCTestCase, WeatherModelDelegate {

    let expectation = XCTestExpectation(description: "Wait for queue change.")
    // Test if there is an error
    func testGetRatesShouldPostFailedCallbackIfError() {
        //Given
        let weather = APIService(session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        let weatherService = WeatherModel(apiService: weather)
        weatherService.delegate = self
        
        weatherService.getWeather(city: "Roma")
       
        wait(for: [expectation], timeout: 0.5)
    }
    
    func showWeather (_ value : Weathers) {
        let humidity = 52
        let temp = 278.03
        let idWeather = 804
        let description = "overcast clouds"
        XCTAssertFalse(true)
        expectation.fulfill()
        XCTAssertTrue(true)
        XCTAssertEqual(humidity, value.main.humidity)
        XCTAssertEqual(temp, value.main.temp)
        XCTAssertEqual(idWeather, value.weather[0].id)
        XCTAssertEqual(description, value.weather[3].description)
        expectation.fulfill()
    }
    func showError (_ error : APIError) {
        XCTAssertFalse(false)
        expectation.fulfill()
    }
    
    func testGetRatesShouldPostFailedCallbackIfNoData() {
        let weather = APIService(session: URLSessionFake(data: nil, response: nil, error: nil))
        let weatherService = WeatherModel(apiService: weather)
        weatherService.delegate = self
        
        weatherService.getWeather(city: "Roma")
       
        wait(for: [expectation], timeout: 0.5)
    }
    
    func testGetRatesShouldPostFailedCallbackIfIncorrectResponse() {
        let weather = APIService(session: URLSessionFake(data: FakeResponseData.weatherCorrectData, response: FakeResponseData.responseKO, error: nil))
        let weatherService = WeatherModel(apiService: weather)
        weatherService.delegate = self
        
        weatherService.getWeather(city: "New+York")
       
        wait(for: [expectation], timeout: 0.5)
    }
    
    func testGetRatesShouldPostFailedCallbackIfIncorrectData() {
        let weather = APIService(session: URLSessionFake(data: FakeResponseData.networkIncorrectData, response: FakeResponseData.responseOK, error: nil))
        let weatherService = WeatherModel(apiService: weather)
        weatherService.delegate = self
        
        weatherService.getWeather(city: "New+York")
       
        wait(for: [expectation], timeout: 0.5)
    }
    
    func testGetRatesShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        let weather = APIService(session: URLSessionFake(data: FakeResponseData.weatherCorrectData, response: FakeResponseData.responseOK, error: nil))
        let weatherService = WeatherModel(apiService: weather)
        weatherService.delegate = self
        let city = "Roma"
        weatherService.getWeather(city: city)
        wait(for: [expectation], timeout: 0.5)
    }

}
