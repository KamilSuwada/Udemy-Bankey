//
//  AccountSummaryVC.swift
//  Bankey
//
//  Created by Kamil Suwada on 28/05/2022.
//

import UIKit




class AccountSummaryVC: UIViewController {
    
    // Request Models:
    var profile: Profile?
    var accounts: Array<Account> = Array<Account>()
    
    // View Models:
    var headerViewModel = AccountSummaryHeaderView.ViewModel(welcomeMessage: "Welcome!", name: "", date: Date())
    var accountCellViewModels: Array<AccountSummaryCell.ViewModel> = []
    
    // Components:
    var headerView = AccountSummaryHeaderView(frame: .zero)
    var tableView = UITableView()
    lazy var refreshControl: UIRefreshControl =
    {
        let refresh = UIRefreshControl()
        refresh.tintColor = appColour
        refresh.addTarget(self, action: #selector(refreshContent), for: .valueChanged)
        return refresh
    }()
    
    
    lazy var logoutBarButtonItem: UIBarButtonItem =
    {
        let barButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logoutTapped))
        barButtonItem.tintColor = .label
        return barButtonItem
    }()
    
    // Networking:
    var profileManager: ProfileManageable = ProfileManager()
    var isLoaded = false
    
    
    var alertAction: () -> () =
    {
        return
    }
    
    
    lazy var errorAlert: UIAlertController =
    {
        let alert = UIAlertController(title: "", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        return alert
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    
}




// MARK: TableViewDelegate and DataSource conformance:
extension AccountSummaryVC: UITableViewDelegate, UITableViewDataSource {
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return accountCellViewModels.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard !accountCellViewModels.isEmpty else { return UITableViewCell() }
        
        if isLoaded
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: AccountSummaryCell.reuseID, for: indexPath) as! AccountSummaryCell
            let account = accountCellViewModels[indexPath.row]
            cell.configure(with: account)
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: SkeletonCell.reuseID, for: indexPath) as! SkeletonCell
            return cell
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
}




// MARK: style and layout:
extension AccountSummaryVC {
    
    func setup() {
        setupNavigationBar()
        setupTableView()
        setupTableHeaderView()
        setupSkeletons()
        fetchData()
    }
    
    
    private func setupSkeletons()
    {
        let row = Account.makeSkeleton()
        accounts = Array(repeating: row, count: 10)
        configureTableCells(with: self.accounts)
    }
    
    
    private func setupNavigationBar()
    {
        navigationItem.rightBarButtonItem = logoutBarButtonItem
    }
    
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.backgroundColor = appColour
        tableView.refreshControl = self.refreshControl
        
        // registering the tableViewCell
        tableView.register(AccountSummaryCell.self, forCellReuseIdentifier: AccountSummaryCell.reuseID)
        tableView.register(SkeletonCell.self, forCellReuseIdentifier: SkeletonCell.reuseID)
        tableView.rowHeight = AccountSummaryCell.rowHeight
        tableView.tableFooterView = UIView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    
    private func setupTableHeaderView() {
        var size = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        size.width = UIScreen.main.bounds.width
        headerView.frame.size = size
        
        tableView.tableHeaderView = headerView
    }
    
    
}




// MARK: Data fetch
extension AccountSummaryVC {
    
    
    
    private func fetchData()
    {
        let userID = "1"
        
        
        let group = DispatchGroup()
        
        group.enter()
        profileManager.fetchProfile(forUserID: userID) { result in
            switch result
            {
            case .success(let profile):
                self.profile = profile
            case .failure(let error):
                self.displayError(error)
            }
            group.leave()
        }
        
        
        group.enter()
        profileManager.fetchAccounts(forUserID: userID) { result in
            switch result
            {
            case .success(let accounts):
                self.accounts = accounts
            case .failure(let error):
                self.displayError(error)
            }
            group.leave()
        }
        
        
        group.notify(queue: .main)
        {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
                guard let profile = self?.profile, let self = self else { return }
                
                self.isLoaded = true
                self.configureTableHeaderView(with: profile)
                self.configureTableCells(with: self.accounts)
                self.tableView.reloadData()
                self.tableView.refreshControl?.endRefreshing()
            }
        }
    }
    
    
    
    private func displayError(_ error: NetworkError)
    {
        let titleAndMessage = self.titleAndMessage(for: error)
        self.tableView.refreshControl?.endRefreshing()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1)
        { [weak self] in
            self?.showErrorAlert(title: titleAndMessage.0, message: titleAndMessage.1) { return }
        }
    }
    
    
    
    private func titleAndMessage(for error: NetworkError) -> (String, String)
    {
        switch error
        {
        case .serverError:
            return ("Network Error", "Please check your network connection and try again.")
        case .decodingError:
            return ("Decoding Error", "Ups! Something went wrong on our end. Could not decode accounts! Please check again later and make sure your app is up to date.\n\nApp will now exit.")
        }
    }
    
    
    
    private func configureTableHeaderView(with profile: Profile)
    {
        let vm = AccountSummaryHeaderView.ViewModel(welcomeMessage: "Good Morning", name: profile.firstName, date: Date())
        headerView.configure(viewModel: vm)
    }
    
    
    
    private func configureTableCells(with accounts: Array<Account>)
    {
        accountCellViewModels = accounts.map({ account in
            AccountSummaryCell.ViewModel(accountType: account.type, accountName: account.name, balance: account.amount)
        })
    }
    
    
    
    private func showErrorAlert(title: String, message: String, completion: @escaping () -> ())
    {
        self.errorAlert.title = title
        self.errorAlert.message = message
        present(self.errorAlert, animated: true, completion: nil)
    }
    
    
    
    @objc private func logoutTapped()
    {
        resetSelf()
        NotificationCenter.default.post(name: .logout, object: nil)
    }
    
    
    
    @objc private func refreshContent()
    {
        resetSelf()
        setupSkeletons()
        tableView.reloadData()
        fetchData()
    }
    
    
    
    private func resetSelf()
    {
        profile = nil
        accounts.removeAll()
        isLoaded = false
    }
    
    
}




// MARK: For Profile Manager testing:
extension AccountSummaryVC
{
    func titleAndMessageForTesting(for error: NetworkError) -> (String, String)
    {
        return self.titleAndMessage(for: error)
    }
    
    
    func forceFetchProfile()
    {
        return
    }
}
