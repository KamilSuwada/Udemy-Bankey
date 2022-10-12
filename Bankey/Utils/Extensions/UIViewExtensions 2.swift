//
//  UIViewExtensions.swift
//  Bankey
//
//  Created by Kamil Suwada on 28/05/2022.
//

import UIKit




extension UIView {
    
    
    func setUpViewProgramaticallyAsDivider(fillWithColour colour: UIColor?, forView view: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        if let colour = colour {
            self.backgroundColor = colour
        }
        view.addSubview(self)
    }
    
    
}
