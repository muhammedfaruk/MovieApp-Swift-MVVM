//
//  ApiRouter.swift
//  NetFilm
//
//  Created by Muhammed Faruk Söğüt on 23.10.2022.
//

import Foundation
import Alamofire

protocol Requestable {
    //var headers: [String: String] {get} -> if we need header we can use.
    var path: String {get}
    var method: HTTPMethod {get}
}

enum ApiRouter: Requestable {
    case getMovieData(movieType: String, page:String)
    case getMovieDetail(id: Int, page:String)
    case getSimilarMovies(id: Int)
}

extension ApiRouter {
    
    var method: HTTPMethod {
        switch self {
        case .getMovieData: return .get
        case .getMovieDetail: return .get
        case .getSimilarMovies: return .get
        }
    }
    
    var path: String {
        
        let apiCommonPath:String = "/3/movie/"
        
        switch self {
        case .getMovieData(let movieType, _): return apiCommonPath + "\(movieType)"
        case .getMovieDetail(let id, _): return apiCommonPath + "\(id)"
        case .getSimilarMovies(let id): return apiCommonPath +  "\(id)/similar"
        }
    
    }
    
    func asURLRequest() -> URLRequest {
        guard var components = URLComponents(string: ServiceBase.shared.baseURL) else { fatalError("URLComponents cannot be created") }
        
        components.path = path
        
//        //Add Query Param        
        if case .getMovieData(_, let page) = self {
            components.queryItems = [URLQueryItem(name: "api_key", value: ApiKey.apiKey),
                                      URLQueryItem(name: "language", value: "en-US"),
                                      URLQueryItem(name: "page", value: page)]
        }else if case .getMovieDetail(_, let page) = self {
            components.queryItems = [URLQueryItem(name: "api_key", value: ApiKey.apiKey),
                                     URLQueryItem(name: "language", value: "en-US"),
                                     URLQueryItem(name: "page", value: page)]
        }else if case .getSimilarMovies = self {
            components.queryItems = [URLQueryItem(name: "api_key", value: ApiKey.apiKey),
                                     URLQueryItem(name: "language", value: "en-US")]
        }
        
        
        
        var request = URLRequest(url: components.url!)
        request.httpMethod = method.rawValue
        request.cachePolicy = .reloadIgnoringLocalCacheData
        
        // Common Headers
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        
        do {
            
            switch self {
                //URLEncoding without param
            case .getMovieData, .getMovieDetail, .getSimilarMovies:
                request = try Alamofire.URLEncoding.default.encode(request, with: nil)
                break
            }
            
        } catch {
            return request
        }
                
        return request
    }
    
}

