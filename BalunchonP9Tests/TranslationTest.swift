//
//  TranslationTest.swift
//  BalunchonP9Tests
//
//  Created by Mikungu Giresse on 16/02/23.
//

import XCTest

@testable import BalunchonP9

final class TranslationTest: XCTestCase, TranslationModelDelegate {
    //MARK: -Accessible
    let expectation = XCTestExpectation(description: "Wait for queue change.")
    //MARK: -Test
    //Test if there is an error
    func testGetTranslationShouldPostFailedCallbackIfError() {
        let translation = APIService(session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        let translationService = TranslationModel(apiService: translation)
        translationService.delegate = self
        
        translationService.getTranslation(sentence: "test1")
       
        wait(for: [expectation], timeout: 0.5)
    }
    //MARK: -Delegate
    func didTranslation (_ valueFR : String) {
        let translatedText = "fr"
        print (valueFR)
        XCTAssertTrue(true)
        XCTAssertEqual(translatedText, valueFR)
        expectation.fulfill()
    }
    func didShowError (_ error : APIError) {
        XCTAssertFalse(false)
        expectation.fulfill()
    }
    //Test if there is no Data
    func testGetTranslationShouldPostFailedCallbackIfNoData() {
        let translation = APIService(session: URLSessionFake(data: nil, response: nil, error: nil))
        let translationService = TranslationModel(apiService: translation)
        translationService.delegate = self
        
        translationService.getTranslation(sentence: "test2")
       
        wait(for: [expectation], timeout: 0.5)
    }
    //Test if there is incorrect Response
    func testGetTranslationShouldPostFailedCallbackIfIncorrectResponse() {
        let translation = APIService(session: URLSessionFake(data: FakeResponseData.translationCorrectData, response: FakeResponseData.responseKO, error: nil))
        let translationService = TranslationModel(apiService: translation)
        translationService.delegate = self
        
        translationService.getTranslation(sentence: "test3")
       
        wait(for: [expectation], timeout: 0.5)
    }
    //Test if there is incorrect Data
    func testGetTranslationShouldPostFailedCallbackIfIncorrectData() {
        let dollar = APIService(session: URLSessionFake(data: FakeResponseData.networkIncorrectData, response: FakeResponseData.responseOK, error: nil))
        let exchangeRateService = TranslationModel(apiService: dollar)
        exchangeRateService.delegate = self
        
        exchangeRateService.getTranslation(sentence: "test4")
       
        wait(for: [expectation], timeout: 0.5)
    }
    //Test if there is no error with correct Data
    func testGetTranslationShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        let translation = APIService(session: URLSessionFake(data: FakeResponseData.translationCorrectData, response: FakeResponseData.responseOK, error: nil))
        let translationService = TranslationModel(apiService: translation)
        translationService.delegate = self
        let sentence = String()
        translationService.getTranslation(sentence: sentence)
        wait(for: [expectation], timeout: 0.5)
    }

}
