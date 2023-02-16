//
//  FakeResponseData.swift
//  BalunchonP9Tests
//
//  Created by Mikungu Giresse on 16/02/23.
//

import Foundation

class FakeResponseData {
    static let responseOK = HTTPURLResponse(url: URL(string: "www.openclassrooms.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    static let responseKO = HTTPURLResponse(url: URL(string: "www.openclassrooms.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    class NetworkError: Error {}
    static let error = NetworkError()
    
    static var exchangeRateCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "DollarData", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static var translationCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "TranslationData", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static var weatherCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "WeatherData", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return data
    }
    
    static let networkIncorrectData = "erreur".data(using: .utf8)!
    
}
