//
//  AppDelegate.swift
//  Bankey
//
//  Created by Kamil Suwada on 19/05/2022.
//

import UIKit


let appColour: UIColor = .systemTeal


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    let loginVC = LoginViewController()
    let onboardingVC = OnboardingContainerViewController()
    let mainVC = MainVC()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        
        
        loginVC.delegate = self
        onboardingVC.delegate = self
        registerForNotifications()
        
        displayLogin()
        
        return true
    }
    
    
    
    private func registerForNotifications()
    {
        NotificationCenter.default.addObserver(self, selector: #selector(didLogout), name: .logout, object: nil)
    }
    
    
    
    private func displayLogin()
    {
        setRootVC(loginVC)
    }
    
    
    
    private func displayNextScreen()
    {
        if LocalState.hasOnboarded == true
        {
            prepMainVC()
            setRootVC(mainVC)
        }
        else
        {
            setRootVC(onboardingVC)
        }
    }
    
    
    
    private func prepMainVC()
    {
        mainVC.selectedIndex = 0 // selection of tab bar.
        mainVC.setStatusBar()
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().backgroundColor = appColour
    }
    
}




// MARK: OnboardingContainerViewControllerDelegate:
extension AppDelegate: OnboardingContainerViewControllerDelegate {
    func didFinishOnboarding() {
        LocalState.hasOnboarded = true
        prepMainVC()
        setRootVC(mainVC, animated: true)
    }
}




// MARK: LoginViewControllerDelegate:
extension AppDelegate: LoginViewControllerDelegate {
    func didLogIn() {
        displayNextScreen()
    }
}



// MARK: LogoutDelegate:
extension AppDelegate: LogoutDelegate {
    @objc func didLogout() {
        setRootVC(loginVC, animated: true)
    }
}





// MARK: SetRootVC:
extension AppDelegate {
    func setRootVC(_ vc: UIViewController, animated: Bool = true) {
        
        guard animated, let window = self.window else {
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
            return
        }
        
        window.rootViewController = vc
        window.makeKeyAndVisible()
        UIView.transition(with: window, duration: 0.25, options: .transitionCrossDissolve, animations: nil, completion: nil)
        
    }
}

