//
//  LoadingShowable.swift
//  NetFilm
//
//  Created by Muhammed Faruk Söğüt on 28.08.2023.
//

import UIKit

protocol LoadingShowable where Self: UIViewController {
    func showLoading()
    func hideLoading()
}

extension LoadingShowable {
    func showLoading() {
        LoadingView.show()
    }
    func hideLoading() {
        LoadingView.hide()
    }
}
