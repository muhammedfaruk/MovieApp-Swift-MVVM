//
//  MainService.swift
//  NetFilm
//
//  Created by Muhammed Faruk Söğüt on 2.09.2023.
//

import Foundation


protocol MainServiceProtocol {
    func getMovieData(movieType: String, page:String, completionHandler: @escaping (Result<MovieData, CustomNetworkError>) -> Void)
}

class MainService: MainServiceProtocol {
    func getMovieData(movieType: String, page: String, completionHandler: @escaping (Result<MovieData, CustomNetworkError>) -> Void) {
        let request = ApiRouter.getMovieData(movieType: movieType, page: page)
        NetworkManager.shared.performRequest(type: MovieData.self, endpoint: request, completion: completionHandler)
        
    }
}
