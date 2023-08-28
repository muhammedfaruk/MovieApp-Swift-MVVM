//
//  DetailViewModel.swift
//  NetFilm
//
//  Created by Muhammed Faruk Söğüt on 22.02.2022.
//

import Foundation

final class DetailViewModel {
    
    lazy var serviceEndpoint: NetworkManager = {
        return NetworkManager.shared
    }()
        
    weak var detailOutPut : DetailVCOutPut?
    var isLoading : Bool = false
    
    
    func fetchDetail(movieID: Int) {        
        serviceEndpoint.getMovieDetail(id: movieID, page: "1") { result in
            switch result {
            case .success(let data):
                self.detailOutPut?.saveDetails(detail: data)
            case .failure(let error):
                print(error.localizedDescription)
            }
        
        }
    }
    
    func fetchSimilarMovies(movieID: Int){
        serviceEndpoint.getSimilarMovies(id: movieID) { result in
            switch result {
            case .success(let data):
                self.detailOutPut?.saveSimilarMovies(movies: data.results)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func changeLoading(){
        isLoading = !isLoading
        detailOutPut?.changeisLoading(isloading: isLoading)
    }
    
}
