//
//  WeatherTest.swift
//  BalunchonP9Tests
//
//  Created by Mikungu Giresse on 16/02/23.
//

import XCTest

@testable import BalunchonP9

final class WeatherTest: XCTestCase, WeatherModelDelegate {

    let expectation = XCTestExpectation(description: "Wait for queue change.")
    // Test if there is an error
    func testGetWeatherShouldPostFailedCallbackIfError() {

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
        XCTAssertTrue(true)
        XCTAssertEqual(humidity, value.main.humidity)
        XCTAssertEqual(temp, value.main.temp)
        XCTAssertEqual(idWeather, value.weather[0].id)
        XCTAssertEqual(description, value.weather[0].description)
        expectation.fulfill()
    }
    func showError (_ error : APIError) {
        XCTAssertFalse(false)
        expectation.fulfill()
    }
    
    func testGetWeatherShouldPostFailedCallbackIfNoData() {
        let weather = APIService(session: URLSessionFake(data: nil, response: nil, error: nil))
        let weatherService = WeatherModel(apiService: weather)
        weatherService.delegate = self
        
        weatherService.getWeather(city: "Roma")
       
        wait(for: [expectation], timeout: 0.5)
    }
    
    func testGetWeatherShouldPostFailedCallbackIfIncorrectResponse() {
        let weather = APIService(session: URLSessionFake(data: FakeResponseData.weatherCorrectData, response: FakeResponseData.responseKO, error: nil))
        let weatherService = WeatherModel(apiService: weather)
        weatherService.delegate = self
        
        weatherService.getWeather(city: "Roma")
       
        wait(for: [expectation], timeout: 0.5)
    }
    
    func testGetWeatherShouldPostFailedCallbackIfIncorrectData() {
        let weather = APIService(session: URLSessionFake(data: FakeResponseData.networkIncorrectData, response: FakeResponseData.responseOK, error: nil))
        let weatherService = WeatherModel(apiService: weather)
        weatherService.delegate = self
        
        weatherService.getWeather(city: "New+York")
       
        wait(for: [expectation], timeout: 0.5)
    }
    
    func testGetWeatherShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        let weather = APIService(session: URLSessionFake(data: FakeResponseData.weatherCorrectData, response: FakeResponseData.responseOK, error: nil))
        let weatherService = WeatherModel(apiService: weather)
        weatherService.delegate = self
        let city = "Roma"
        weatherService.getWeather(city: city)
        wait(for: [expectation], timeout: 0.5)
    }

}
