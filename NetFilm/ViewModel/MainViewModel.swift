//
//  MainViewModel.swift
//  NetFilm
//
//  Created by Muhammed Faruk Söğüt on 16.02.2022.
//

import Foundation


protocol MainViewModelInterface {
    var serviceEndpoint: ServiceEndpoint {get}
    var collectionSectionList: [MovieSection] {get set}
    var popularMovieList   : [MovieInfo] {get}
    var topRatedMovieList  : [MovieInfo] {get}
    var upcomingMoviesList : [MovieInfo] {get}
    var latestMoviesList   : [MovieInfo] {get}
    var numberOfSections: Int {get}
        
    func viewDidLoad()
    func fetchData()
    
    func getMovies(movieType: MovieType)
    func setMovieList(movieType: MovieType, data: MovieData)
    
    func configureCells()
    func numberOfItemsInSection(sectionIndex: Int) -> Int
    func getSection(indexPath: IndexPath) -> MovieSection
    func getSectionTitle(indexPath: IndexPath) -> String
    func getMovie(indexPath: IndexPath) -> MovieInfo
}

final class MainViewModel: MainViewModelInterface {
        
    var collectionSectionList: [MovieSection] = []
    
    var popularMovieList: [MovieInfo] = []
    var topRatedMovieList: [MovieInfo] = []
    var upcomingMoviesList: [MovieInfo] = []
    var latestMoviesList: [MovieInfo] = []
        
    lazy var serviceEndpoint: ServiceEndpoint = {
        return ServiceEndpoint()
    }()
        
    weak var view : MainViewInterface?
}

extension MainViewModel {
    
    func viewDidLoad() {
        fetchData()
        view?.configureCollectionView()
        view?.registerCollectionCells()
    }
    
    func fetchData() {
        view?.startLoading()
        getMovies(movieType: .popular)
        getMovies(movieType: .topRated)
        getMovies(movieType: .upcoming)
        getMovies(movieType: .latest)
    }
    
    func getMovies(movieType: MovieType) {        
        serviceEndpoint.getMovieData(movieType: movieType.rawValue, page: "1") { result in
            self.view?.endLoading()
            switch result {
            case .success(let data):                
                self.setMovieList(movieType: movieType, data: data)
                self.configureCells()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func setMovieList(movieType: MovieType, data: MovieData) {
        switch movieType {
        case .popular:
            popularMovieList = data.results
        case .topRated:
            topRatedMovieList = data.results
        case .upcoming:
            upcomingMoviesList = data.results
        case .latest:
            latestMoviesList = data.results
        }
    }
    
    func configureCells() {
        collectionSectionList = [MovieSection(movieList: popularMovieList, cellType: .popular, title: "Popular Movies"),
                                 MovieSection(movieList: popularMovieList, cellType: .topRated, title: "Top Rated Movies"),
                                 MovieSection(movieList: popularMovieList, cellType: .latest, title: "Lates Movies"),
                                 MovieSection(movieList: popularMovieList, cellType: .upcoming, title: "Upcoming Movies")]
        view?.reloadData()
    }
}


//MARK: - Collection View Data
extension MainViewModel {
    var numberOfSections: Int {
        collectionSectionList.count
    }
    
    func numberOfItemsInSection(sectionIndex: Int) -> Int {
        collectionSectionList[sectionIndex].movieList.count
    }
    
    func getSection(indexPath: IndexPath) -> MovieSection {
        collectionSectionList[indexPath.section]
    }
    
    func getSectionTitle(indexPath: IndexPath) -> String {
        collectionSectionList[indexPath.section].title
    }
    
    func getMovie(indexPath: IndexPath) -> MovieInfo {
        let sectionType = getSection(indexPath: indexPath).cellType
        
        switch sectionType {
        case .popular:
            return popularMovieList[indexPath.item]
        case .topRated:
            return topRatedMovieList[indexPath.item]
        case .upcoming:
            return upcomingMoviesList[indexPath.item]
        case .latest:
            return latestMoviesList[indexPath.item]
        }
        
    }
    
    func getMovieId(indexPath: IndexPath) -> Int {
        collectionSectionList[indexPath.section].movieList[indexPath.item].id
    }
}
