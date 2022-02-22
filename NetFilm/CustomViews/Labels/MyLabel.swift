//
//  MyLabel.swift
//  NetFilm
//
//  Created by Muhammed Faruk Söğüt on 18.02.2022.
//

import UIKit
import UIFontComplete

class MyLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init (textSize: CGFloat, color: UIColor, alignment: NSTextAlignment){
        self.init(frame: .zero)
        font = UIFont.init(font: .helveticaBold, size: textSize)
        textColor = color
        numberOfLines = 0
        textAlignment = alignment
    }
    
    private func configure(){
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
