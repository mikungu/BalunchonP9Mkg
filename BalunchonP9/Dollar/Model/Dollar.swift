//
//  Dollar.swift
//  BalunchonP9
//
//  Created by Mikungu Giresse on 24/01/23.
//

import Foundation

struct Dollar: Decodable {
    let rates: Rates
}

struct Rates: Decodable {
    let usd: Double
    
    enum CodingKeys: String, CodingKey {
        case usd = "USD"
    }
}

protocol DollarModelDelegate: AnyObject {
    func didReceiveError(_ error: APIError)
    func didReceiveDollarValue(_ value: Double)
}

final class DollarModel {
    //MARK: -Property
    private let apiService : APIService
    //MARK: -Lifecycle
    init ( apiService : APIService = APIService()) {
        self.apiService = apiService
    }
    
    //MARK: -Accessible
    
    weak var delegate: DollarModelDelegate?
    
    func getRates() {
        let url = "http://data.fixer.io/api/latest?access_key=6828305824724f292feaea538719ac6e&base=EUR&symbols=USD"
        let method: HTTPMethod = .post
        
        let callback: (Result<Dollar, Error>)-> Void = {  result in
            switch result {
            case .success(let model):
                self.delegate?.didReceiveDollarValue(model.rates.usd)
            case .failure(let error):
                guard let error = error as? APIError else { break }
                self.delegate?.didReceiveError(error)
            }
            
        }
        self.apiService.makeCall(urlString: url, method: method, completion: callback)
    }
}
