//
//  NetworkManager.swift
//  NetFilm
//
//  Created by Muhammed Faruk Söğüt on 23.10.2022.
//

import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    func performRequest<T : Decodable>(type: T.Type, endpoint:ServiceEndpoint, completion: @escaping ((Result<T, CustomNetworkError>)->Void)) {
        AF.request(endpoint.url, method: endpoint.method, parameters: endpoint.parameters, encoding: endpoint.encoding, headers: HTTPHeaders(endpoint.headers))
            .validate()
            .response { response in
                print("request url: \(response.request?.url)")
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
                
    func getMovieData(movieType: String, page:String, completionHandler: @escaping (Result<MovieData, CustomNetworkError>) -> Void) {
        let request = ApiRouter.getMovieData(movieType: movieType, page: page)
        performRequest(type: MovieData.self, endpoint: request, completion: completionHandler)
    }
    
    func getMovieDetail(id: Int, page:String, completionHandler: @escaping (Result<MovieDetail, CustomNetworkError>) -> Void) {
        let request = ApiRouter.getMovieDetail(id: id, page: page)
        performRequest(type: MovieDetail.self, endpoint: request, completion: completionHandler)
    }
    
    func getSimilarMovies(id: Int, completionHandler: @escaping (Result<MovieData, CustomNetworkError>) -> Void) {
        let request = ApiRouter.getSimilarMovies(id: id)
        performRequest(type: MovieData.self, endpoint: request, completion: completionHandler)
    }
    
}

enum CustomNetworkError: Error {
    case decodingError
    case message(_ message:String)
}
