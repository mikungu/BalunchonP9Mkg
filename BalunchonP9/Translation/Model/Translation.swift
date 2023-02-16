//
//  Translation.swift
//  BalunchonP9
//
//  Created by Mikungu Giresse on 25/01/23.
//

import Foundation

struct Translation : Decodable {
    let data : [String : [Translations]]
    
    func returnTranslate() -> String {
        return data["translations"]![0].translatedText
    }
}

struct Translations : Decodable {
    let translatedText : String
    let detectedSourceLanguage : String
}

protocol TranslationModelDelegate: AnyObject {
    func didTranslation (_ valueFR : String)
    func didShowError (_ error : APIError)
}

final class TranslationModel {
    //MARK: -Property
    private let apiService : APIService
    
    init ( apiService : APIService = APIService()) {
        self.apiService = apiService
    }
    
    //MARK: -Accessible
    
    weak var delegate : TranslationModelDelegate?
    
    func getTranslation (sentence: String) {
        let url = "https://translation.googleapis.com/language/translate/v2?key=AIzaSyA6eKP0-AlONngf3g_KEul7W7KpnJK2JxM&q=\(sentence)&target=en&format=text"
        
        let method: HTTPMethod = .post
        
        let callback: (Result<Translation, Error>)-> Void = { result in
            switch result {
            case .success(let model):
                self.delegate?.didTranslation(model.returnTranslate())
                
            case .failure(let error):
                guard let error = error as? APIError else { break }
                self.delegate?.didShowError(error)
            }
            
        }
        
        self.apiService.makeCall(urlString: url, method: method, completion: callback)
        
    }
    
    
}
