//
//  UIimageView+.swift
//  NetFilm
//
//  Created by Muhammed Faruk Söğüt on 23.10.2022.
//

import Foundation
import UIKit
import AlamofireImage

extension UIImageView {
    public func imageFromUrl(urlString: String?, placeHolderImage:UIImage?) {
        
        image = placeHolderImage
        
        if var urlS = urlString{
            
            //Servis may return image url without base url so control it
            if !urlS.hasPrefix("http") {
                urlS = "https://image.tmdb.org/t/p/w500" + urlS
            }
            
            if let url = URL(string: urlS) {
                self.af.setImage(withURL: url)
            }
            
        }
    }
}
