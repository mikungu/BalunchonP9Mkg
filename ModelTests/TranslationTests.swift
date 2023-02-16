//
//  TranslationTests.swift
//  TranslationTests
//
//  Created by Mikungu Giresse on 05/02/23.
//

import XCTest

@testable import BalunchonP9

final class TranslationTests: XCTestCase, TranslationModelDelegate {
    let expectation = XCTestExpectation(description: "Wait for queue change.")
    // Test if there is an error
    func testGetRatesShouldPostFailedCallbackIfError() {
        //Given
        let translation = APIService(session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        let translationService = TranslationModel(apiService: translation)
        translationService.delegate = self
        
        translationService.getTranslation(sentence: "test1")
       
        wait(for: [expectation], timeout: 0.5)
    }
    
    func didTranslation (_ valueFR : String) {
        let sentence = "Je suis en route"
        XCTAssertFalse(true)
        expectation.fulfill()
        XCTAssertTrue(true)
        XCTAssertEqual(sentence, valueFR)
        expectation.fulfill()
    }
    func didShowError (_ error : APIError) {
        XCTAssertFalse(false)
        expectation.fulfill()
    }
    
    func testGetRatesShouldPostFailedCallbackIfNoData() {
        let translation = APIService(session: URLSessionFake(data: nil, response: nil, error: nil))
        let translationService = TranslationModel(apiService: translation)
        translationService.delegate = self
        
        translationService.getTranslation(sentence: "test2")
       
        wait(for: [expectation], timeout: 0.5)
    }
    
    func testGetRatesShouldPostFailedCallbackIfIncorrectResponse() {
        let translation = APIService(session: URLSessionFake(data: FakeResponseData.translationCorrectData, response: FakeResponseData.responseKO, error: nil))
        let translationService = TranslationModel(apiService: translation)
        translationService.delegate = self
        
        translationService.getTranslation(sentence: "test3")
       
        wait(for: [expectation], timeout: 0.5)
    }
    
    func testGetRatesShouldPostFailedCallbackIfIncorrectData() {
        let dollar = APIService(session: URLSessionFake(data: FakeResponseData.networkIncorrectData, response: FakeResponseData.responseOK, error: nil))
        let exchangeRateService = TranslationModel(apiService: dollar)
        exchangeRateService.delegate = self
        
        exchangeRateService.getTranslation(sentence: "test4")
       
        wait(for: [expectation], timeout: 0.5)
    }
    
    func testGetRatesShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        let translation = APIService(session: URLSessionFake(data: FakeResponseData.translationCorrectData, response: FakeResponseData.responseOK, error: nil))
        let translationService = TranslationModel(apiService: translation)
        translationService.delegate = self
        let sentence = "Je suis en route"
        translationService.getTranslation(sentence: sentence)
        wait(for: [expectation], timeout: 0.5)
    }
    
   
}
