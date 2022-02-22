//
//  MyBodyLabell.swift
//  NetFilm
//
//  Created by Muhammed Faruk Söğüt on 21.02.2022.
//

import UIKit

class MyBodyLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(textAlignment: NSTextAlignment) {
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        configure()
    }
    
    private func configure(){
        numberOfLines                       = 0
        textColor                           = .secondaryLabel
        adjustsFontSizeToFitWidth           = true
        font                                = UIFont.preferredFont(forTextStyle: .body)
        adjustsFontForContentSizeCategory   = true
        minimumScaleFactor                  = 0.75
        lineBreakMode                       = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
        
    }

}
