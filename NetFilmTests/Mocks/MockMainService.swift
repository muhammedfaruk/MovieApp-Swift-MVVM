//
//  MockMainService.swift
//  NetFilmTests
//
//  Created by Muhammed Faruk Söğüt on 4.09.2023.
//

import XCTest
@testable import NetFilm

class MockMainService: MainServiceProtocol {
    func getMovieData(movieType: String, page: String, completionHandler: @escaping (Result<MovieData, CustomNetworkError>) -> Void) {
        
    }
}
