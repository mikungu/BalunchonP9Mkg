//
//  APIService.swift
//  BalunchonP9
//
//  Created by Mikungu Giresse on 25/01/23.
//

import Foundation

enum HTTPMethod: String {
    case get = "Get"
    case post = "Post"
}
enum APIError: Error {
    case url
    case responseCode
    case invalidData
    case parsing
    case anyerror
}

class APIService {
    // MARK: - Property
    
    private let session: URLSession
    private var task : URLSessionDataTask?
    
    // MARK: - Lifecyle
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    //MARK: -Accessible
    func makeCall <T: Decodable> (urlString: String, method: HTTPMethod, completion: @escaping (Result<T, Error>)->Void){
        guard let url = URL(string: urlString) else {
            completion(.failure(APIError.url))
            return
        }
       // var task : URLSessionDataTask?
        task?.cancel()
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        task = self.session.dataTask(with: request, completionHandler: { data, response, error in
            DispatchQueue.main.async {
                guard error == nil else {
                    completion(.failure (APIError.anyerror))
                    return
                }
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    completion(.failure(APIError.responseCode))
                    return
                }
                guard let data = data else {
                    completion(.failure(APIError.invalidData))
                    return
                }
                
                do {
                    let model = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(model))
                } catch {
                    completion(.failure(APIError.parsing))
                }
                if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                           print(json)
                    }
            }
        })
        
        task?.resume()
    }
    
}






