//
//  UIImageViewExtensions.swift
//  Bankey
//
//  Created by Kamil Suwada on 28/05/2022.
//

import UIKit




extension UIImageView {
    
    
    func setUpImageViewProgramatically(withImage image: UIImage, forView view: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.image = image
        view.addSubview(self)
    }
    
    
}
