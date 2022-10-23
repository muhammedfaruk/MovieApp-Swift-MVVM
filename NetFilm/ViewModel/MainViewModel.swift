//
//  MainViewModel.swift
//  NetFilm
//
//  Created by Muhammed Faruk Söğüt on 16.02.2022.
//

import Foundation


enum Movietype: String {
    case popular    = "popular"
    case topRated   = "top_rated"
    case upcoming   = "upcoming"
    case latest     = "now_playing"
}

final class MainViewModel {
    
    lazy var serviceEndpoint: ServiceEndpoint = {
        return ServiceEndpoint()
    }()
    
    weak var mainVCOutPut : MainVCOutPut?
   
    var isLoading : Bool = false
    
    func fetchPopularMovies(){
        serviceEndpoint.getMovieData(movieType: Movietype.popular.rawValue, page: "1") { result in
            switch result {
            case .success(let data):
                self.mainVCOutPut?.saveMovies(movieType: .popularMovies, list: data.results)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchTopRatedMovies(){
        serviceEndpoint.getMovieData(movieType: Movietype.topRated.rawValue, page: "1") { result in
            switch result {
            case .success(let data):
                self.mainVCOutPut?.saveMovies(movieType: .topRatedMovies, list: data.results)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchUpcomingMovies(){
        serviceEndpoint.getMovieData(movieType: Movietype.upcoming.rawValue, page: "1") { result in
            switch result {
            case .success(let data):
                self.mainVCOutPut?.saveMovies(movieType: .upcomingMovies, list: data.results)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchLatestMovies(){
        serviceEndpoint.getMovieData(movieType: Movietype.latest.rawValue, page: "1") { result in
            self.changeLoading()
            switch result {
            case .success(let data):
                self.mainVCOutPut?.saveMovies(movieType: .latestMovies, list: data.results)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchData() {
        changeLoading()
        fetchPopularMovies()
        fetchTopRatedMovies()
        fetchUpcomingMovies()
        fetchLatestMovies()
    }
    
    //change loading indicator scroll and reload collection view data.
    func changeLoading(){
        isLoading = !isLoading
        self.mainVCOutPut?.changeLoadingAndReloadData(isLoading: self.isLoading)
    }
    
}

