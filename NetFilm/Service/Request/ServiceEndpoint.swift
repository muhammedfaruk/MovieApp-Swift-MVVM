//
//  ServiceEndpoint.swift
//  NetFilm
//
//  Created by Muhammed Faruk Söğüt on 23.10.2022.
//

import Alamofire

class ServiceEndpoint {
    
    var dataRequest: DataRequest?
    
    typealias performResponseHandler<T : Decodable> = Result<T, Error>
    
        
    func performRequest<T : Decodable>(request:ApiRouter,  completionHandler: @escaping (performResponseHandler<T>) -> Void){
        self.dataRequest = request.asURLRequest().perform { (data: performResponseHandler<T>) in
            
            if case .failure(let error) = data{
                print(error)
                let info = (error as NSError).userInfo
                if case let  invalidTokenError = info["InvalidTokenError"] as? Bool, invalidTokenError == true {
                    //Get Token Again. ** We dont need get token again for this service
//                    self.getTokenAgain { isSuccess in
//                        if isSuccess {
//                            self.performRequest(request: request, completionHandler: completionHandler)
//                        }else{
//                            completionHandler(data)
//                        }
//                    }
                    print(error.localizedDescription)
                }
                
            }else{
                completionHandler(data)
            }
            
        }
    }
    
    //Used when InvalidTokenError
    private func getTokenAgain(completionHandler: @escaping (_ isSuccess:Bool) -> Void){

    }

    
    func getMovieData(movieType: String, page:String, completionHandler: @escaping (Result<MovieData, Error>) -> Void) {
        let request = ApiRouter.getMovieData(movieType: movieType, page: page)
        performRequest(request: request, completionHandler: completionHandler)
    }
    
    func getMovieDetail(id: Int, page:String, completionHandler: @escaping (Result<MovieDetail, Error>) -> Void) {
        let request = ApiRouter.getMovieDetail(id: id, page: page)
        performRequest(request: request, completionHandler: completionHandler)
    }
    
    func getSimilarMovies(id: Int, completionHandler: @escaping (Result<MovieData, Error>) -> Void) {
        let request = ApiRouter.getSimilarMovies(id: id)
        performRequest(request: request, completionHandler: completionHandler)
    }
    
}
