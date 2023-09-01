//
//  DetailViewModel.swift
//  NetFilm
//
//  Created by Muhammed Faruk Söğüt on 22.02.2022.
//

import Foundation

protocol DetailViewModelInterface {
    var service: MovieDetailServiceProtocol? {get}
    var movieId: Int {get}
    var similarMovies: [MovieInfo] {get}
    var movieDetail: MovieDetail? {get}
    var numberOfItemsInSection: Int {get}
        
    func viewDidLoad()
    func similarMovieAtIndexPath(indexPath: IndexPath) -> MovieInfo
}

final class DetailViewModel {
    var movieId: Int
    var similarMovies: [MovieInfo] = []
    var movieDetail: MovieDetail?
    
    var service: MovieDetailServiceProtocol?
    weak var view : DetailVCInterface?
    
    init(service: MovieDetailServiceProtocol, movieId: Int) {
        self.service = service
        self.movieId = movieId
    }
}

extension DetailViewModel: DetailViewModelInterface {
    
    func viewDidLoad() {
        fetchDetail()
        //fetchSimilarMovies()
        view?.configureHeaderView()
        view?.configureCollectionView()
    }
        
    private func fetchDetail() {
        view?.startLoading()
        service?.getMovieDetail(id: movieId, page: "1") { result in
            self.view?.endLoading()
            switch result {
            case .success(let detail):
                self.movieDetail = detail
                self.view?.configureDetailUIElement()
            case .failure(let error):
                print(error.localizedDescription)
            }

        }
    }
    
    private func fetchSimilarMovies(){
        service?.getSimilarMovies(id: movieId) { result in
            switch result {
            case .success(let data):
                self.similarMovies = data.results
                self.view?.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}


//MARK: - Collection View Data
extension DetailViewModel {
    var numberOfItemsInSection: Int { similarMovies.count }
    
    func similarMovieAtIndexPath(indexPath: IndexPath) -> MovieInfo {
        return similarMovies[indexPath.item]
    }
}
