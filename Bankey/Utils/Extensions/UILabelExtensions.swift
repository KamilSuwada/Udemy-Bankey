//
//  UILabelExtensions.swift
//  Bankey
//
//  Created by Kamil Suwada on 28/05/2022.
//

import UIKit




extension UILabel {
    
    
    func setUpLabelProgramatically(withText text: String?, withFont font: UIFont.TextStyle, forView view: UIView, withTextAllignement allignment: NSTextAlignment = .left, withAttributedString attrString: NSMutableAttributedString? = nil) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.font = UIFont.preferredFont(forTextStyle: font)
        self.adjustsFontForContentSizeCategory = true
        
        if let text = text {
            self.text = text
        }
        
        if let attrString = attrString {
            self.attributedText = attrString
        }
        
        self.textAlignment = allignment
        
        
        view.addSubview(self)
    }
    
    
}
