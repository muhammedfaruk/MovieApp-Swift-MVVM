//
//  HeaderLabelCell.swift
//  NetFilm
//
//  Created by Muhammed Faruk Söğüt on 16.02.2022.
//

import UIKit

class HeaderLabelCell: UICollectionViewCell {
    
    static var reuseId = "HeaderCellId"
        
        let label: UILabel = {
            let label = UILabel()
            label.text = "POPULAR FILMS"
            label.font = .boldSystemFont(ofSize: 20)
            return label
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            self.addSubview(label)
            label.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                label.topAnchor.constraint(equalTo: topAnchor),
                label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
                label.trailingAnchor.constraint(equalTo: trailingAnchor),
                label.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }}
