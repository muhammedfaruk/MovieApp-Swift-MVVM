//
//  AlertShowable.swift
//  NetFilm
//
//  Created by Muhammed Faruk Söğüt on 28.08.2023.
//

import UIKit

protocol AlertShowable {}

extension AlertShowable where Self : UIViewController {
    func showAlert(
        title: String = "",
        message: String,
        preferredStyle: UIAlertController.Style = .alert,
        completion: (() -> Void)? = nil
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: completion)
    }
}
