//
//  ServiceEndpoint.swift
//  NetFilm
//
//  Created by Muhammed Faruk Söğüt on 29.08.2023.
//

import Alamofire


protocol ServiceEndpoint {
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String] {get}
    var parameters: [String: Any] {get}
    var queryItems: [URLQueryItem] {get}
    var encoding: ParameterEncoding {get}
}

extension ServiceEndpoint {
    var headers: [String: String] { [:] }
    var parameters: [String: Any] { [:] }    
    var url: String { "\(ServiceBase.shared.baseURL)\(path)"}
}

extension ServiceEndpoint {
    var encoding: ParameterEncoding {
        switch method {
        case .get: return URLEncoding.default
        default: return JSONEncoding.default
        }
    }
}
