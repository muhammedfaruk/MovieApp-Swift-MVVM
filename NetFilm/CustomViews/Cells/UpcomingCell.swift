//
//  UpcomingCell.swift
//  NetFilm
//
//  Created by Muhammed Faruk Söğüt on 18.02.2022.
//

import UIKit

class UpcomingCell: UICollectionViewCell {
    
    static var reuseID = "upcomingCell"
    let image = MyImage(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(imagePath: String){
        image.downloadImage(posterPath: imagePath)
    }
    
    private func configure() {
        addSubview(image)    
        NSLayoutConstraint.activate([
            image.centerYAnchor.constraint(equalTo: centerYAnchor),
            image.centerXAnchor.constraint(equalTo: centerXAnchor),
            image.heightAnchor.constraint(equalToConstant: 150),
            image.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
}


