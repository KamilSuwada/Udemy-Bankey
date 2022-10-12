//
//  DummyVC.swift
//  Bankey
//
//  Created by Kamil Suwada on 28/05/2022.
//

import UIKit




class DummyVC: UIViewController {
    
    let stackView = UIStackView()
    let label = UILabel()
    let button = UIButton(type: .system)
    
    weak var logoutDelegate: LogoutDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
}




// MARK: style and layout:
extension DummyVC {
    
    func style() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Welcome!"
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = .filled()
        button.setTitle("ACTION!", for: [])
        button.addTarget(self, action: #selector(buttonTapped), for: .primaryActionTriggered)
    }
    
    
    func layout() {
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(button)
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    
    @objc func buttonTapped(sender: UIButton) {
        
        // ACTION!
        
        logoutDelegate?.didLogout()
        
        
    }
    
}
