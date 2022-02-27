//
//  DetailViewModel.swift
//  NetFilm
//
//  Created by Muhammed Faruk Söğüt on 22.02.2022.
//

import Foundation

final class DetailViewModel {
    
    var similarMovies : [MovieInfo] = []
    weak var detailOutPut : DetailVCOutPut?
    var isLoading : Bool = false
    
    func fetchDetail(movieID: Int) {
        changeLoading()
        NetworkManager.shared.getMovieDetail(id: movieID) {[weak self] detail, error in
            guard let self = self else {return}
            
            guard error == nil else {print(error!)
                return}
            self.detailOutPut?.saveDetails(detail: detail!)
            self.changeLoading()
        }
    }
    
    func fetchSimilarMovies(movieID: Int){
        NetworkManager.shared.getSimilarMovies(id: movieID) { movies, error in
            guard error == nil else {print(error!)
                return}
            self.detailOutPut?.saveSimilarMovies(movies: movies!)
        }
    }
    
    func changeLoading(){
        isLoading = !isLoading
        detailOutPut?.changeisLoading(isloading: isLoading)
    }
    
}
