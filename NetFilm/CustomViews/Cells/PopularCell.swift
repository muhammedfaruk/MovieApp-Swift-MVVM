//
//  PopularCell.swift
//  NetFilm
//
//  Created by Muhammed Faruk Söğüt on 16.02.2022.
//

import UIKit
import UIFontComplete

class PopularCell: UICollectionViewCell {
    static var reuseID = "PopularCell"
    
    let imageView   = MyImage(frame: .zero)
    var label       = UILabel()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(movie: MovieInfo, itemIndex: Int) {
        imageView.downloadImage(posterPath: movie.posterPath)
        configureLabel(itemIndex: String(itemIndex))
    }
    
    func configureLabel(itemIndex: String){
        let strokeTextAttributes = [
            NSAttributedString.Key.strikethroughColor : UIColor.black,
          NSAttributedString.Key.strokeColor : UIColor.white,
          NSAttributedString.Key.foregroundColor : UIColor.black,
          NSAttributedString.Key.strokeWidth : -2.0,
            NSAttributedString.Key.font : UIFont(font: .helveticaBold, size: 150)!]
          as [NSAttributedString.Key : Any]

        label.attributedText = NSMutableAttributedString(string: itemIndex, attributes: strokeTextAttributes)
        
    }
    
    
    func configure(){
        addSubview(imageView)
        addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo:topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 50),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: 20),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
                        
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.widthAnchor.constraint(equalToConstant: 250),
            label.heightAnchor.constraint(equalToConstant: 120),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 5),
        ])
        
        layer.cornerRadius = 10
        clipsToBounds = true
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0.5)
        layer.shadowOpacity = 0.2
    }
    
}
