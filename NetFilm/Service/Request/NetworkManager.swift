//
//  NetworkManager.swift
//  NetFilm
//
//  Created by Muhammed Faruk Söğüt on 23.10.2022.
//

import Alamofire


enum CustomNetworkError: Error {
    case decodingError
    case message(_ message:String)
}

protocol NetworkManagerProtocol {
    func performRequest<T : Decodable>(type: T.Type, endpoint:ServiceEndpoint, completion: @escaping ((Result<T, CustomNetworkError>)->Void))
}

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    func performRequest<T : Decodable>(type: T.Type, endpoint:ServiceEndpoint, completion: @escaping ((Result<T, CustomNetworkError>)->Void)) {
        
        print("** URL **: \(endpoint.url)")
        print("** URL **: \(endpoint.parameters)")
        
        AF.request(endpoint.url, method: endpoint.method, parameters: endpoint.parameters, encoding: endpoint.encoding, headers: HTTPHeaders(endpoint.headers))
            .validate()
            .response { response in
                
                print("** HEADER **: \(String(describing: response.request?.headers))")
                if response.request?.httpBody != nil {
                    print("** BODY **: \(String(describing: response.request?.httpBody))")
                }
                
                switch response.result {
                case .success(let data):
                    guard let data = data else {
                        completion(.failure(.message("Data is nil")))
                        return
                    }
                    do {
                        let decodedObject = try JSONDecoder().decode(type, from: data)
                        completion(.success(decodedObject))
                    } catch {
                        completion(.failure(.message(error.localizedDescription)))
                    }
                case .failure(let error):
                    completion(.failure(.message(error.localizedDescription)))
                }
            }
    }
}
