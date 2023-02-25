//
//  DollarTest.swift
//  BalunchonP9Tests
//
//  Created by Mikungu Giresse on 16/02/23.
//

import XCTest

@testable import BalunchonP9

final class DollarTest: XCTestCase, DollarModelDelegate {
    //MARK: -Accessible
    let expectation = XCTestExpectation(description: "Wait for queue change.")
    //Test if there is an error
    func testGetRateShouldPostFailedCallbackIfError() {
        let dollar = APIService(session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        let dollarService = DollarModel(apiService: dollar)
        dollarService.delegate = self
        
        dollarService.getRates()
        
        wait(for: [expectation], timeout: 0.5)
    }
    //MARK: -Delegate
    func didReceiveDollarValue (_ value : Double) {
        let rate = 1.07115
        print (value)
        XCTAssertTrue(true)
        XCTAssertEqual(rate, value)
        expectation.fulfill()
    }
    func didReceiveError (_ error : APIError) {
        XCTAssertFalse(false)
        expectation.fulfill()
    }
    //Test if there is no data
    func testGetRatesShouldPostFailedCallbackIfNoData() {
        let dollar = APIService(session: URLSessionFake(data: nil, response: nil, error: nil))
        let dollarService = DollarModel(apiService: dollar)
        dollarService.delegate = self
        
        dollarService.getRates()
        
        wait(for: [expectation], timeout: 0.5)
    }
    //Test if there is incorrect response
    func testGetRatesShouldPostFailedCallbackIfIncorrectResponse() {
        let dollar = APIService(session: URLSessionFake(data: FakeResponseData.exchangeRateCorrectData, response: FakeResponseData.responseKO, error: nil))
        let dollarService = DollarModel(apiService: dollar)
        dollarService.delegate = self
        
        dollarService.getRates()
        
        wait(for: [expectation], timeout: 0.5)
    }
    //Test if there is incorrect data
    func testGetRatesShouldPostFailedCallbackIfIncorrectData() {
        let dollar = APIService(session: URLSessionFake(data: FakeResponseData.networkIncorrectData, response: FakeResponseData.responseOK, error: nil))
        let dollarService = DollarModel(apiService: dollar)
        dollarService.delegate = self
        
        dollarService.getRates()
        
        wait(for: [expectation], timeout: 0.5)
    }
    //Test if there is no error with a correct data
    func testGetRatesShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        let dollar = APIService(session: URLSessionFake(data: FakeResponseData.exchangeRateCorrectData, response: FakeResponseData.responseOK, error: nil))
        let dollarService = DollarModel(apiService: dollar)
        dollarService.delegate = self
        
        dollarService.getRates()
        
        wait(for: [expectation], timeout: 0.5)
    }
    
}
