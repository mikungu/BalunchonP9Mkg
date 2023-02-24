//
//  Weathers.swift
//  BalunchonP9
//
//  Created by Mikungu Giresse on 23/01/23.
//

import Foundation
struct Weathers : Decodable {
    let weather: [Weather]
    let main : Main
    let dt : Double
    //let id : Int
    
    
}
struct Weather : Decodable {
    let id : Int
    //let main : String
    let description : String
    
    //let icon : String
   // var weatherIconUrl : URL {
    //    let urlString = "http://openweathermap.org/img/wn/\(icon)@2x.png"
     //   return URL (string: urlString)!
   // }
}
struct Main : Decodable {
    let temp : Double
    let humidity: Int
}

protocol WeatherModelDelegate: AnyObject {
    func showWeather (_ value : Weathers)
    func showError (_ error: APIError)
}

final class WeatherModel {
    //MARK: -Property
    private let apiService : APIService
    
    init ( apiService : APIService = APIService()) {
        self.apiService = apiService
    }
    
    //MARK: -Accessible
    weak var delegate : WeatherModelDelegate?
    //function getWeather where we precise the url, method and callback to launch a call API
    func getWeather(city: String) {
        
        let url = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=e6fff2754c23ec123583c168c16e8258"
        let method: HTTPMethod = .post
        
        let callback: (Result<Weathers, Error>)-> Void = { result in
            switch result {
            case .success(let model):
                
                self.delegate?.showWeather(model)
            case .failure(let error):
                guard let error = error as? APIError else { break }
                self.delegate?.showError(error)
                
            }
            
        }
        self.apiService.makeCall(urlString: url, method: method, completion: callback)
    }
    
}
