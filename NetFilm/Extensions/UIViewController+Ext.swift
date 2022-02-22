//
//  UIViewController+Ext.swift
//  NetFilm
//
//  Created by Muhammed Faruk Söğüt on 19.02.2022.
//

import Foundation
import UIKit
import NVActivityIndicatorView


extension UIViewController {
    
    func makeDarkModeAllView(){
        UIApplication.shared.windows.forEach { window in
            window.overrideUserInterfaceStyle = .dark
        }
    }
   
    

    
}
