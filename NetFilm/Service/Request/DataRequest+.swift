//
//  DataRequest+.swift
//  NetFilm
//
//  Created by Muhammed Faruk Söğüt on 23.10.2022.
//

//
//  DataRequest+.swift
//
//  Created by Bekir Yeşilkaya on 23.06.2021.
//

import Foundation
import Alamofire

extension DataRequest {
    
    @discardableResult
    public func seralize<T: Decodable>(completionHandler: @escaping (AFDataResponse<T>) -> Void) -> Self {
        return self.responseDecodable(completionHandler: completionHandler)
    }
    
    func seralize<T: Decodable>(completionHandler:@escaping (Result<T,Error>) ->Void)  {
        _ = self.validate().seralize { (data: AFDataResponse<T>) in
                      
            switch data.result{
            case.success(let payload):
                completionHandler(.success(payload))
            case .failure(let error):
                completionHandler(.failure(error))
                print(error.localizedDescription)
            }
            
        }
    }
    
}
