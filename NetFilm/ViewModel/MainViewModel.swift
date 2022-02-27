//
//  MainViewModel.swift
//  NetFilm
//
//  Created by Muhammed Faruk Söğüt on 16.02.2022.
//

import Foundation

final class MainViewModel {
    
    weak var mainVCOutPut : MainVCOutPut?
   
    var isLoading : Bool = false
    
    func fetchData() {
        
        let dispathGroup = DispatchGroup()
        changeLoading()
        //Get popular Movies
        dispathGroup.enter()
        NetworkManager.shared.getMovieData(serviceType: .popular) { movieInfo, error in
            guard error == nil else {print(error!)
                dispathGroup.leave()
                return}
            self.mainVCOutPut?.saveMovies(movieType: .popularMovies, list: movieInfo!)
            dispathGroup.leave()
        }
        
        //Get top Rated Movies
        dispathGroup.enter()
        NetworkManager.shared.getMovieData(serviceType: .topRated) { movieInfo, error in
            guard error == nil else {print(error!)
                dispathGroup.leave()
                return}
            self.mainVCOutPut?.saveMovies(movieType: .topRatedMovies, list: movieInfo!)
            dispathGroup.leave()
        }
        
        //Get top Rated Movies
        dispathGroup.enter()
        NetworkManager.shared.getMovieData(serviceType: .upcoming) { movieInfo, error in
            guard error == nil else {print(error!)
                dispathGroup.leave()
                return}
            self.mainVCOutPut?.saveMovies(movieType: .upcomingMovies, list: movieInfo!)
            dispathGroup.leave()
        }
        
        //Get Latest Movies
        dispathGroup.enter()
        NetworkManager.shared.getMovieData(serviceType: .latest) { movieInfo, error in
            guard error == nil else {print(error!)
                dispathGroup.leave()
                return}
            self.mainVCOutPut?.saveMovies(movieType: .latestMovies, list: movieInfo!)
            dispathGroup.leave()
        }
        
        
        //UI updated on the main thread.
        dispathGroup.notify(queue: .main) {
            self.changeLoading()            
        }
    }
    
    //change loading indicator scroll and reload collection view data.
    func changeLoading(){
        isLoading = !isLoading
        self.mainVCOutPut?.changeLoadingAndReloadData(isLoading: self.isLoading)
    }
    
}

