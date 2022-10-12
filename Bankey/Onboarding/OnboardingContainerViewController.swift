//
//  OnboardingContainerViewController.swift
//  Bankey
//
//  Created by Kamil Suwada on 22/05/2022.
//

import UIKit


protocol OnboardingContainerViewControllerDelegate: AnyObject {
    func didFinishOnboarding()
}


class OnboardingContainerViewController: UIViewController {

    
    let pageViewController: UIPageViewController
    var pages = [UIViewController]()
    var currentVC: UIViewController {
        
        didSet {
            guard let index = pages.firstIndex(of: currentVC) else { print("could not unwrap index"); return }
            nextButton.isHidden = index == pages.count - 1
            doneButton.isHidden = !(index == pages.count - 1)
            previousButton.isHidden = index == 0
            closeButton.isHidden = !(index == pages.count - 1)
        }
        
    }
    
    
    let closeButton = UIButton(type: .system)
    let previousButton = UIButton(type: .system)
    let nextButton = UIButton(type: .system)
    let doneButton = UIButton(type: .system)
    
    weak var delegate: OnboardingContainerViewControllerDelegate?
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        let page1 = OnboardingViewController(resourceName: "delorean", description: "Bankey is faster, easier to use and has a brand new look and feel that will make you feel like you are back in the 1989!")
        let page2 = OnboardingViewController(resourceName: "world", description: "Move your money around the world quickly and securely!")
        let page3 = OnboardingViewController(resourceName: "thumbs", description: "Learn more at www.bankey.com")
        
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        
        currentVC = pages.first!
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        style()
        layout()
    }
    
    
    private func setup() {
        view.backgroundColor = .systemPurple
        
        // VERY IMPORTANT!!!
        
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        
        // VERY IMPORTANT!!!
        
        pageViewController.dataSource = self
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: pageViewController.view.topAnchor),
            view.leadingAnchor.constraint(equalTo: pageViewController.view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: pageViewController.view.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: pageViewController.view.bottomAnchor),
        ])
        
        pageViewController.setViewControllers([pages.first!], direction: .forward, animated: false, completion: nil)
        currentVC = pages.first!
    }
    
    
    private func style() {
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.setTitle("Close", for: [])
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .primaryActionTriggered)
        
        view.addSubview(closeButton)
        
        
        previousButton.translatesAutoresizingMaskIntoConstraints = false
        previousButton.setTitle("Previous", for: [])
        previousButton.addTarget(self, action: #selector(previousButtonTapped), for: .primaryActionTriggered)
        
        view.addSubview(previousButton)
        
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.setTitle("Next", for: [])
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .primaryActionTriggered)
        
        view.addSubview(nextButton)
        
        
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.setTitle("Done", for: [])
        doneButton.addTarget(self, action: #selector(doneButtonTapped), for: .primaryActionTriggered)
        
        view.addSubview(doneButton)
    }
    
    
    private func layout() {
        
        NSLayoutConstraint.activate([
            closeButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2),
            closeButton.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor, multiplier: 2),
            
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: previousButton.bottomAnchor, multiplier: 4),
            previousButton.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: nextButton.bottomAnchor, multiplier: 4),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: nextButton.trailingAnchor, multiplier: 1),
            
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalToSystemSpacingBelow: doneButton.bottomAnchor, multiplier: 4),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: doneButton.trailingAnchor, multiplier: 1)
        ])
        
    }
}




// MARK: - UIPageViewControllerDataSource
extension OnboardingContainerViewController: UIPageViewControllerDataSource {

    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return getPreviousViewController(from: viewController)
    }

    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return getNextViewController(from: viewController)
    }

    
    private func getPreviousViewController(from viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index - 1 >= 0 else { return nil }
        currentVC = pages[index - 1]
        return pages[index - 1]
    }

    
    private func getNextViewController(from viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index + 1 < pages.count else { return nil }
        currentVC = pages[index + 1]
        return pages[index + 1]
    }

    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }

    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return pages.firstIndex(of: self.currentVC) ?? 0
    }
}




// MARK: Actions:
extension OnboardingContainerViewController {
    
    @objc func closeButtonTapped() {
        delegate?.didFinishOnboarding()
    }
    
    
    @objc func doneButtonTapped() {
        delegate?.didFinishOnboarding()
    }
    
    
    @objc func previousButtonTapped() {
        guard let nextVC = getPreviousViewController(from: self.currentVC) else { return }
        pageViewController.setViewControllers([nextVC], direction: .forward, animated: false)
        currentVC = nextVC
    }
    
    
    @objc func nextButtonTapped() {
        guard let nextVC = getNextViewController(from: self.currentVC) else { return }
        pageViewController.setViewControllers([nextVC], direction: .forward, animated: false)
        currentVC = nextVC
    }
    
}
