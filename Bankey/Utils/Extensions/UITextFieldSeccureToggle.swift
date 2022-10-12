//
//  UITextFieldSeccureToggle.swift
//  Bankey
//
//  Created by Kamil Suwada on 03/07/2022.
//

import UIKit

let passwordToggleButton = UIButton(type: .custom)


extension UITextField
{
    func enablePasswordToggle()
    {
        passwordToggleButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        passwordToggleButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .selected)
        passwordToggleButton.addTarget(self, action: #selector(togglePasswordView), for: .touchUpInside)
        rightView = passwordToggleButton
        rightViewMode = .always
    }
    
    
    
    @objc func togglePasswordView(_ sender: Any)
    {
        isSecureTextEntry.toggle()
        passwordToggleButton.isSelected.toggle()
    }
}
