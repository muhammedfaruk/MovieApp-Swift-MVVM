//
//  ServiceEndpoint.swift
//  NetFilm
//
//  Created by Muhammed Faruk Söğüt on 23.10.2022.
//

import Alamofire

class ServiceEndpoint {
    
    
    private var possibleEmptyResponseCodes: Set<Int> {
        var defaultSet = DataResponseSerializer.defaultEmptyResponseCodes
        defaultSet.insert(200)
        defaultSet.insert(201)
        return defaultSet
    }
    
    func performRequest<T : Decodable>(type: T.Type, endpoint:Endpoint, completion: @escaping ((Result<T, CustomNetworkError>)->Void)) {
        
        //        AF.request(endpoint.url, method: endpoint.method, parameters: endpoint.parameters, encoding: endpoint.encoding, headers: HTTPHeaders(endpoint.headers)).validate().responseDecodable(of: type) { response in
        //            switch response.result {
        //            case .success(let decodedObject):
        //                completion(.success(decodedObject))
        //            case .failure(let error):
        //                completion(.failure(.message(error.localizedDescription)))
        //            }
        //        }
        
        AF.request(endpoint.url, method: endpoint.method, parameters: endpoint.parameters, encoding: endpoint.encoding, headers: HTTPHeaders(endpoint.headers))
            .validate()
            .response(responseSerializer: DataResponseSerializer(emptyResponseCodes: possibleEmptyResponseCodes)) { response in
                
                print("request body: \(response.request?.httpBody)")
                print("request body: \(response.request?.url)")
                
                switch response.result {
                case .success(let data):
                    do {
                        let decodedObject = try JSONDecoder().decode(type, from: data)
                        completion(.success(decodedObject))
                    } catch {
                        //let decodingError = APIClientError.decoding(error: error as? DecodingError)
                        completion(.failure(.message(error.localizedDescription)))
                    }
                case .failure(_):
                    completion(.failure(.message("hata")))
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
    
    func user(id: Int, completionHandler: @escaping (Result<User, CustomNetworkError>) -> Void) {
        let request = ApiRouter.user
        performRequest(type: User.self, endpoint: request, completion: completionHandler)
    }
    
}



protocol Endpoint {
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get}
    var parameters: [String: Any] { get }
    var encoding: ParameterEncoding { get }
}

extension Endpoint {
    var headers: [String: String] { [:] }
    var parameters: [String: Any] { [:] }
    var url: String { "\(ServiceBase.shared.baseURL)\(path)"}
}

extension Endpoint {
    var encoding: ParameterEncoding {
        switch method {
        case .get: return URLEncoding.default
        default: return JSONEncoding.default
        }
    }
}

enum CustomNetworkError: Error {
    case decodingError
    case message(_ message:String)
}
