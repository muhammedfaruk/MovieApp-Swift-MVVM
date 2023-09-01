//
//  MovieDetailService.swift
//  NetFilm
//
//  Created by Muhammed Faruk Söğüt on 2.09.2023.
//

import Foundation

protocol MovieDetailServiceProtocol {
    func getMovieDetail(id: Int, page:String, completionHandler: @escaping (Result<MovieDetail, CustomNetworkError>) -> Void)
    func getSimilarMovies(id: Int, completionHandler: @escaping (Result<MovieData, CustomNetworkError>) -> Void)
}

class MovieDetailService: MovieDetailServiceProtocol {
    func getMovieDetail(id: Int, page: String, completionHandler: @escaping (Result<MovieDetail, CustomNetworkError>) -> Void) {
        let request = ApiRouter.getMovieDetail(id: id, page: page)
        NetworkManager.shared.performRequest(type: MovieDetail.self, endpoint: request, completion: completionHandler)
    }
    
    func getSimilarMovies(id: Int, completionHandler: @escaping (Result<MovieData, CustomNetworkError>) -> Void) {
        let request = ApiRouter.getSimilarMovies(id: id)
        NetworkManager.shared.performRequest(type: MovieData.self, endpoint: request, completion: completionHandler)
    }
}
