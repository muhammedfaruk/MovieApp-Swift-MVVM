//
//  ApiRouter.swift
//  NetFilm
//
//  Created by Muhammed Faruk Söğüt on 23.10.2022.
//

import Foundation
import Alamofire


enum ApiRouter: ServiceEndpoint {
    case getMovieData(movieType: String, page:String)
    case getMovieDetail(id: Int, page:String)
    case getSimilarMovies(id: Int)
}

extension ApiRouter {
    
    var headers: [String : String] {
        return ["application/json": "Accept"]
    }
    
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
    
    var parameters: [String : Any] {
        switch self {
        case .getMovieData(_, let page):
            return ["api_key": ApiKey.apiKey,
                    "language": "en-US",
                    "page": page]
            
        case .getMovieDetail(_, let page):
            return ["api_key": ApiKey.apiKey,
                    "language": "en-US",
                    "page": page]
            
        case .getSimilarMovies(_):
            return ["api_key": ApiKey.apiKey,
                    "language": "en-US",]
        }
    }
            
}

