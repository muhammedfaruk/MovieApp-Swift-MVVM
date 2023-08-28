//
//  LoadingView.swift
//  NetFilm
//
//  Created by Muhammed Faruk Söğüt on 28.08.2023.
//

import UIKit

class LoadingView {
    internal static var spinner: UIActivityIndicatorView?
    
    static func show() {
        DispatchQueue.main.async {
            if spinner == nil, let window = UIApplication.shared.keyWindow {
                let frame = UIScreen.main.bounds
                let spinner = UIActivityIndicatorView(frame: frame)
                spinner.backgroundColor = UIColor.black.withAlphaComponent(0.2)
                spinner.style = .large
                window.addSubview(spinner)
                
                spinner.startAnimating()
                self.spinner = spinner
            }
        }
    }
    
    static func hide() {
        DispatchQueue.main.async {
            spinner?.stopAnimating()
            spinner?.removeFromSuperview()
            spinner = nil
        }
    }
    
}
