//
//  ViewController.swift
//  Bankey
//
//  Created by Kamil Suwada on 19/05/2022.
//

import UIKit


protocol LoginViewControllerDelegate: AnyObject {
    func didLogIn()
}


protocol LogoutDelegate: AnyObject {
    func didLogout()
}


class LoginViewController: UIViewController {
    
    
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let loginView = LoginView()
    let signInButton = UIButton(type: .system)
    let errorMessageLabel = UILabel()
    
    
    let name = ""
    let pass = ""
    
    
    weak var delegate: LoginViewControllerDelegate?
    
    
    var username: String? {
        return loginView.usernameTextField.text
    }
    
    
    var password: String? {
        return loginView.passwordTextField.text
    }

    
    var leadingEdgeOnScreen: CGFloat = 16
    var leadingEdgeOffScreen: CGFloat = -1000
    
    var titleLeadingAnchor: NSLayoutConstraint?
    var subtitleLeadingAnchor: NSLayoutConstraint?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }

    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        signInButton.configuration?.showsActivityIndicator = false
        loginView.usernameTextField.text = ""
        loginView.passwordTextField.text = ""
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animate()
    }
    

}




// MARK: Style and Layout:
extension LoginViewController {
   
   
   private func style() {
       
       // title:
       titleLabel.translatesAutoresizingMaskIntoConstraints = false
       titleLabel.textAlignment = .center
       titleLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
       titleLabel.adjustsFontForContentSizeCategory = true
       titleLabel.text = "Bankey"
       titleLabel.alpha = 0
       
       
       // subtitle:
       subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
       subtitleLabel.textAlignment = .center
       subtitleLabel.font = UIFont.preferredFont(forTextStyle: .title3)
       subtitleLabel.numberOfLines = 0
       subtitleLabel.adjustsFontForContentSizeCategory = true
       subtitleLabel.text = "Your premium source for all things banking!"
       subtitleLabel.alpha = 0
       
       
       // loginView:
       loginView.translatesAutoresizingMaskIntoConstraints = false
       loginView.alpha = 0
       
       
       // signInButton:
       signInButton.translatesAutoresizingMaskIntoConstraints = false
       signInButton.configuration = .filled()
       signInButton.configuration?.imagePadding = 8 // for indicator spacing
       signInButton.setTitle("Sign In", for: [])
       signInButton.addTarget(self, action: #selector(signInTapped), for: .primaryActionTriggered)
       signInButton.alpha = 0
       
       
       // Error label:
       errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
       errorMessageLabel.textAlignment = .center
       errorMessageLabel.textColor = .systemRed
       errorMessageLabel.numberOfLines = 0
       errorMessageLabel.isHidden = true
   }
   
   
   private func layout() {
       view.addSubview(loginView)
       view.addSubview(signInButton)
       view.addSubview(errorMessageLabel)
       view.addSubview(titleLabel)
       view.addSubview(subtitleLabel)
       
       
       NSLayoutConstraint.activate([
        // loginView:
        loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
        view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 1),
        
        
        // signInButton:
        signInButton.heightAnchor.constraint(equalToConstant: 40),
        signInButton.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
        signInButton.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
        signInButton.topAnchor.constraint(equalToSystemSpacingBelow: loginView.bottomAnchor, multiplier: 2),
        
        
        // errorLabel:
        errorMessageLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
        errorMessageLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor),
        errorMessageLabel.topAnchor.constraint(equalToSystemSpacingBelow: signInButton.bottomAnchor, multiplier: 4),
        
        
        // subtitleLabel:
        subtitleLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
        loginView.topAnchor.constraint(equalToSystemSpacingBelow: subtitleLabel.bottomAnchor, multiplier: 3),
        
        
        // titleLabel:
        titleLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor),
        subtitleLabel.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 3)
       ])
       
       titleLeadingAnchor = titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingEdgeOffScreen)
       titleLeadingAnchor?.isActive = true
       
       subtitleLeadingAnchor = subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingEdgeOffScreen)
       subtitleLeadingAnchor?.isActive = true
   }
   
   
}




// MARK: Sign In:
extension LoginViewController {
    
    
    @objc func signInTapped(sender: UIButton)
    {
        errorMessageLabel.isHidden = true
        signInButton.configuration?.showsActivityIndicator = false
        signInButton.setTitle("Sign In", for: [])
        login()
    }
    
    
    private func login() {
        guard let username = username, let password = password else { assertionFailure("Username / Password should never be nil!"); return }
        
        
//        if username.isEmpty || password.isEmpty
//        {
//            signInButton.configuration?.showsActivityIndicator = false
//            signInButton.setTitle("Sign In", for: [])
//            configureView(withMessage: "Username / Password cannot be blank!")
//            return
//        }
        
        
        if username == name && password == pass
        {
            signInButton.configuration?.showsActivityIndicator = true
            signInButton.setTitle("Signing In", for: [])
            shootOutOnLogin()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                self.delegate?.didLogIn()
                self.signInButton.setTitle("Sign In", for: [])
            }
        }
        else
        {
            configureView(withMessage: "Incorrect credentials")
        }
    }
    
    
    private func configureView(withMessage message: String) {
        errorMessageLabel.isHidden = false
        errorMessageLabel.text = message
        shakeButton()
    }
    
    
}




// MARK: Animations:
extension LoginViewController
{
    
    
    
    private func animate()
    {
        let animator1 = UIViewPropertyAnimator(duration: 2.5, curve: .easeInOut)
        {
            self.titleLeadingAnchor?.constant = self.leadingEdgeOnScreen
            self.view.layoutIfNeeded()
        }
        
        
        let animator2 = UIViewPropertyAnimator(duration: 2.5, curve: .easeInOut)
        {
            self.subtitleLeadingAnchor?.constant = self.leadingEdgeOnScreen
            self.view.layoutIfNeeded()
        }
        
        
        let animator3 = UIViewPropertyAnimator(duration: 2, curve: .easeInOut)
        {
            self.loginView.alpha = 1
            self.signInButton.alpha = 1
            self.subtitleLabel.alpha = 1
            self.titleLabel.alpha = 1
            self.view.layoutIfNeeded()
        }
        
        
        animator1.startAnimation()
        animator2.startAnimation(afterDelay: 0.5)
        animator3.startAnimation(afterDelay: 1)
    }
    
    
    
    private func shakeButton()
    {
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position.x"
        animation.values = [0, 20, -20, 10, 0]
        animation.keyTimes = [0, 0.16, 0.5, 0.83, 1]
        animation.duration = 0.4
        
        animation.isAdditive = true
        signInButton.layer.add(animation, forKey: "shake")
    }
    
    
    
    private func shootOutOnLogin()
    {
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position.x"
        animation.values = [0, 1000]
        animation.keyTimes = [0, 1]
        animation.duration = 1.0
        
        animation.isAdditive = true
        signInButton.layer.add(animation, forKey: "shoot")
        loginView.layer.add(animation, forKey: "shoot")
        titleLabel.layer.add(animation, forKey: "shoot")
        subtitleLabel.layer.add(animation, forKey: "shoot")
    }
    
    
    
    
}

