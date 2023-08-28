//
//  MainViewModel.swift
//  NetFilm
//
//  Created by Muhammed Faruk Söğüt on 16.02.2022.
//

import Foundation


protocol MainViewModelInterface {
    var homeTitle : String {get}
    var serviceEndpoint: ServiceEndpoint {get}
    var collectionSectionList: [MovieSection] {get}
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
    
    var homeTitle: String {"NetFilm"}
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
//        getMovies(movieType: .topRated)
//        getMovies(movieType: .upcoming)
//        getMovies(movieType: .latest)
    }
    
    func getMovies(movieType: MovieType) {        
        serviceEndpoint.getMovieData(movieType: movieType.rawValue, page: "1") { result in
            self.view?.endLoading()
            switch result {
            case .success(let data):                
                self.setMovieList(movieType: movieType, data: data)
                self.configureCells()
            case .failure(let error):
                self.view?.showErrorMessage(message: error.localizedDescription)
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
                                 MovieSection(movieList: topRatedMovieList, cellType: .topRated, title: "Top Rated Movies"),
                                 MovieSection(movieList: latestMoviesList, cellType: .latest, title: "Lates Movies"),
                                 MovieSection(movieList: upcomingMoviesList, cellType: .upcoming, title: "Upcoming Movies")]
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


// MARK: - Welcome
struct User: Codable {
    let id: Int?
    let uid, password, firstName, lastName: String?
    let username, email: String?
    let avatar: String?
    let gender, phoneNumber, socialInsuranceNumber, dateOfBirth: String?
    let employment: Employment?
    let address: Address?
    let creditCard: CreditCard?
    let subscription: Subscription?

    enum CodingKeys: String, CodingKey {
        case id, uid, password
        case firstName = "first_name"
        case lastName = "last_name"
        case username, email, avatar, gender
        case phoneNumber = "phone_number"
        case socialInsuranceNumber = "social_insurance_number"
        case dateOfBirth = "date_of_birth"
        case employment, address
        case creditCard = "credit_card"
        case subscription
    }
}

// MARK: - Address
struct Address: Codable {
    let city, streetName, streetAddress, zipCode: String?
    let state, country: String?
    let coordinates: Coordinates?

    enum CodingKeys: String, CodingKey {
        case city
        case streetName = "street_name"
        case streetAddress = "street_address"
        case zipCode = "zip_code"
        case state, country, coordinates
    }
}

// MARK: - Coordinates
struct Coordinates: Codable {
    let lat, lng: Double?
}

// MARK: - CreditCard
struct CreditCard: Codable {
    let ccNumber: String?

    enum CodingKeys: String, CodingKey {
        case ccNumber = "cc_number"
    }
}

// MARK: - Employment
struct Employment: Codable {
    let title, keySkill: String?

    enum CodingKeys: String, CodingKey {
        case title
        case keySkill = "key_skill"
    }
}

// MARK: - Subscription
struct Subscription: Codable {
    let plan, status, paymentMethod, term: String?

    enum CodingKeys: String, CodingKey {
        case plan, status
        case paymentMethod = "payment_method"
        case term
    }
}
