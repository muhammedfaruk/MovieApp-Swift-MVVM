//
//  ServiceBase.swift
//  NetFilm
//
//  Created by Muhammed Faruk Söğüt on 23.10.2022.
//

import Foundation

final class ServiceBase {
    static let shared = ServiceBase()
    private init() {}
    
    var baseURL:String {
        return "https://api.themoviedb.org"
    }
    
    
}
