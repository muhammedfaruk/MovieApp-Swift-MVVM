//
//  TopRatedCell.swift
//  NetFilm
//
//  Created by Muhammed Faruk Söğüt on 17.02.2022.
//

import UIKit

class TopRatedCell: UICollectionViewCell {
    
    static var reuseID = "ropRatedCell"
    
    let imageView   = MyImage(frame: .zero)
    let view = UIView()
    
    let titleLabel = MyLabel(textSize: 18, color: .label, alignment: .left)
    let imdbLabel = MyLabel(textSize: 18, color: .systemOrange, alignment: .center)
    let releaseLabel = MyLabel(textSize: 18, color: .systemOrange, alignment: .left)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    func setup(movieInfo: MovieInfo){
        imageView.downloadImage(posterPath: movieInfo.posterPath)
        titleLabel.text = movieInfo.title
        imdbLabel.text = "\(movieInfo.voteAverage)"
        releaseLabel.text = movieInfo.releaseDate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        addSubViews(view: view,imageView,titleLabel,imdbLabel,releaseLabel)
        view.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
      
        NSLayoutConstraint.activate([
            
            view.centerXAnchor.constraint(equalTo:centerXAnchor),
            view.centerYAnchor.constraint(equalTo: centerYAnchor),
            view.widthAnchor.constraint(equalTo: widthAnchor,constant: -30),
            view.heightAnchor.constraint(equalToConstant: 120),
                        
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 150),
            
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor,constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: releaseLabel.topAnchor),
                       
            imdbLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imdbLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -5),
            imdbLabel.widthAnchor.constraint(equalToConstant: 40),
            imdbLabel.heightAnchor.constraint(equalToConstant: 40),
            
            releaseLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            releaseLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            releaseLabel.trailingAnchor.constraint(equalTo: imdbLabel.leadingAnchor),
            releaseLabel.heightAnchor.constraint(equalToConstant: 40),
            
            
        ])
        imageView.bringSubviewToFront(view)        
        view.backgroundColor = .systemGray5
        view.layer.cornerRadius = 10
    }
    
   
}
