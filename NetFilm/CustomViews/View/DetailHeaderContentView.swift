//
//  DetailHeaderContentView.swift
//  NetFilm
//
//  Created by Muhammed Faruk Söğüt on 21.02.2022.
//

import UIKit

class DetailHeaderContentView: UIView {

    let imageView = UIImageView()
    let label = MyLabel(textSize: 15, color: .white, alignment: .left)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
       
    func setLabelText (text: String,systemImage: String){
        label.text = text
        imageView.image = UIImage(systemName: systemImage)?.withTintColor(.systemOrange, renderingMode: .alwaysOriginal)
        configure()
    }
    
    private func configure(){
        addSubViews(view: imageView,label)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 20),
            imageView.heightAnchor.constraint(equalToConstant: 20),
            
            
            label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor,constant: 5),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.heightAnchor.constraint(equalToConstant: 20)
        ])
        
    }

}
