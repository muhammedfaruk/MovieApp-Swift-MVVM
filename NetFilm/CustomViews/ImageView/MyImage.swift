//
//  MyImage.swift
//  NetFilm
//
//  Created by Muhammed Faruk Söğüt on 18.02.2022.
//

import UIKit

class MyImage: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        contentMode = .scaleAspectFill
    }
    
    private func configure(){
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        layer.cornerRadius = 10
        contentMode = .scaleAspectFill
    }
    
    func downloadImage(posterPath: String) {
        imageFromUrl(urlString: posterPath, placeHolderImage: UIImage())
    }
}
