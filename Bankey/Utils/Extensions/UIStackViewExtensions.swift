//
//  UIStackViewExtensions.swift
//  Bankey
//
//  Created by Kamil Suwada on 28/05/2022.
//

import UIKit




extension UIStackView {
    
    
    func setUpStackViewProgramatically(forAxis axis: NSLayoutConstraint.Axis, withSpacing spacing: CGFloat, withItems items: Array<UIView>, forView view: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.axis = axis
        self.spacing = spacing
        
        for item in items {
            self.addArrangedSubview(item)
        }
        
        view.addSubview(self)
    }
    
    
}
