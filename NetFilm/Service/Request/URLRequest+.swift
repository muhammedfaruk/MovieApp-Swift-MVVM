//
//  URLRequest+.swift
//  NetFilm
//
//  Created by Muhammed Faruk Söğüt on 23.10.2022.
//

import Alamofire

extension URLRequest {
    func perform<T>(completionHandler:@escaping(Result<T,Error>)->Void) -> DataRequest where T: Decodable {
        
        //Request Printing
        print("\n[Request][\(httpMethod ?? "")]: " + (url?.absoluteString ?? ""))
        
        if httpBody != nil, let requestBodyS = String(data: httpBody!, encoding: .utf8) {
            print("[Body]: \(requestBodyS)")
        }
        
        if let allHTTPHeader = allHTTPHeaderFields{
           print("[Header] : " +  allHTTPHeader.description + "\n")
        }
        //----------------------------------------------------------------
        
        
        
        let dataRequest = AF.request(self)
        dataRequest.seralize { data in
            completionHandler(data)
        }
        return dataRequest
    }
}
