//
//  SimilarCell.swift
//  NetFilm
//
//  Created by Muhammed Faruk Söğüt on 22.02.2022.
//

import UIKit

class SimilarCell: UICollectionViewCell {
    
    static var reuseID = "similarCell"
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
            image.trailingAnchor.constraint(equalTo: trailingAnchor),
            image.leadingAnchor.constraint(equalTo: leadingAnchor),
            image.topAnchor.constraint(equalTo: topAnchor),
            image.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
