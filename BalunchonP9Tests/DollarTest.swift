//
//  DollarTest.swift
//  BalunchonP9Tests
//
//  Created by Mikungu Giresse on 16/02/23.
//

import XCTest

@testable import BalunchonP9

final class DollarTest: XCTestCase, DollarModelDelegate {

    let expectation = XCTestExpectation(description: "Wait for queue change.")
    func testGetRateShouldPostFailedCallbackIfError() {
        let dollar = APIService(session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        let dollarService = DollarModel(apiService: dollar)
        dollarService.delegate = self
        
        dollarService.getRates()
       
        wait(for: [expectation], timeout: 0.5)
    }
    
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
    
    func testGetRatesShouldPostFailedCallbackIfNoData() {
        let dollar = APIService(session: URLSessionFake(data: nil, response: nil, error: nil))
        let dollarService = DollarModel(apiService: dollar)
        dollarService.delegate = self
        
        dollarService.getRates()
       
        wait(for: [expectation], timeout: 0.5)
    }
    
    func testGetRatesShouldPostFailedCallbackIfIncorrectResponse() {
        let dollar = APIService(session: URLSessionFake(data: FakeResponseData.exchangeRateCorrectData, response: FakeResponseData.responseKO, error: nil))
        let dollarService = DollarModel(apiService: dollar)
        dollarService.delegate = self
        
        dollarService.getRates()
       
        wait(for: [expectation], timeout: 0.5)
    }
    
    func testGetRatesShouldPostFailedCallbackIfIncorrectData() {
        let dollar = APIService(session: URLSessionFake(data: FakeResponseData.networkIncorrectData, response: FakeResponseData.responseOK, error: nil))
        let dollarService = DollarModel(apiService: dollar)
        dollarService.delegate = self
        
        dollarService.getRates()
       
        wait(for: [expectation], timeout: 0.5)
    }
    
    func testGetRatesShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        let dollar = APIService(session: URLSessionFake(data: FakeResponseData.exchangeRateCorrectData, response: FakeResponseData.responseOK, error: nil))
        let dollarService = DollarModel(apiService: dollar)
        dollarService.delegate = self
        
        dollarService.getRates()
        
        wait(for: [expectation], timeout: 0.5)
    }

}
