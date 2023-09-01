//
//  UIViewController+Ext.swift
//  NetFilm
//
//  Created by Muhammed Faruk Söğüt on 2.09.2023.
//

import UIKit

extension UIViewController {
    func add(childVC : UIViewController, containerView: UIView){
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
}
