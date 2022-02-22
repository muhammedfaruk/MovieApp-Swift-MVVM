//
//  NetworkManager.swift
//  NetFilm
//
//  Created by Muhammed Faruk Söğüt on 16.02.2022.
//

import Foundation
import Alamofire

enum ServiceType: String {
    case popular    = "popular"
    case topRated   = "top_rated"
    case upcoming   = "upcoming"
    case latest     = "now_playing"
}

class NetworkManager {
    
    static var shared = NetworkManager()
    let baseURL = "https://api.themoviedb.org/3/movie/"
    let languageAndPage = "&language=en-US&page=1#"
    
    typealias completionHandler = ([MovieInfo]?,String?)->Void
    
    init() {}
    func getMovieData(serviceType: ServiceType, completion: @escaping completionHandler){
        
        let endURL = baseURL + "\(serviceType.rawValue)?api_key=7dd354fbedc4932b4863756f9df41e26" + languageAndPage
        
        let request = AF.request(endURL)
        
        request.validate().responseDecodable(of: MovieData.self) { response in
            switch response.result {
            case .success(let movieInfo):
                completion(movieInfo.results, nil)
            case .failure(let error):
                completion(nil, error.localizedDescription)
            }
        }
    }
    
    typealias completionHandler1 = (MovieDetail?,String?)->Void
    
    func getMovieDetail(id: Int, completion: @escaping completionHandler1){
        
        let endURL = baseURL + "\(id)?api_key=7dd354fbedc4932b4863756f9df41e26" + languageAndPage
        
        let request = AF.request(endURL)
        
        request.validate().responseDecodable(of: MovieDetail.self) { response in
            switch response.result {
            case .success(let movieInfo):
                completion(movieInfo, nil)
            case .failure(let error):
                completion(nil, error.localizedDescription)
            }
        }
    }
    
    
    
    func getSimilarMovies(id: Int, completion: @escaping completionHandler){
        
        let endURL = baseURL + "\(id)/similar?api_key=7dd354fbedc4932b4863756f9df41e26" + languageAndPage
        
        let request = AF.request(endURL)
        
        request.validate().responseDecodable(of: MovieData.self) { response in
            switch response.result {
            case .success(let movieInfo):
                completion(movieInfo.results, nil)
            case .failure(let error):
                completion(nil, error.localizedDescription)
            }
        }
    }
    
    
    func getImage(fromUrl url: String, completion: @escaping (UIImage?, String?) -> Void) {
            
            let request = AF.request(url)
            request.responseData { (response) in
                switch response.result {
                case .success:
                    guard let imageData = response.value,
                          let image = UIImage(data: imageData, scale: 1.0)
                    else { return }
                    completion(image,nil) // we got image
                case .failure (let error):
                    completion(nil, error.localizedDescription)
                }
            }
        }
    
    
}
