//
//  AccountSummaryVC.swift
//  Bankey
//
//  Created by Kamil Suwada on 28/05/2022.
//

import UIKit




class AccountSummaryVC: UIViewController {
    
    
    struct Profile {
        let firstName: String
        let lastName: String
    }
    
    
    var profile: Profile?
    var accounts: Array<AccountSummaryCell.ViewModel> = []
    
    
    var headerView = AccountSummaryHeaderView(frame: .zero)
    var tableView = UITableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    
}




// MARK: TableViewDelegate and DataSource conformance:
extension AccountSummaryVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accounts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard !accounts.isEmpty else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: AccountSummaryCell.reuseID, for: indexPath) as! AccountSummaryCell
        let account = accounts[indexPath.row]
        cell.configure(with: account)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}




// MARK: style and layout:
extension AccountSummaryVC {
    
    func setup() {
        setupTableView()
        setupTableHeaderView()
        fetchProfile()
        fetchAccounts()
    }
    
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.backgroundColor = appColour
        
        // registering the tableViewCell
        tableView.register(AccountSummaryCell.self, forCellReuseIdentifier: AccountSummaryCell.reuseID)
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
    
    
    private func fetchAccounts() {
        let savings = AccountSummaryCell.ViewModel(accountType: .Banking,
                                                   accountName: "Basic Savings",
                                                   balance: 929466.23)
        
        let chequing = AccountSummaryCell.ViewModel(accountType: .Banking,
                                                   accountName: "No-Fee All-In Chequing",
                                                    balance: 17562.44)
        
        let visa = AccountSummaryCell.ViewModel(accountType: .CreditCard,
                                                   accountName: "Visa Avion Card",
                                                balance: 412.83)
        
        let mastercard = AccountSummaryCell.ViewModel(accountType: .CreditCard,
                                                   accountName: "Student Mastercard",
                                                   balance: 50.83)
        
        let inv1 = AccountSummaryCell.ViewModel(accountType: .Investment,
                                                   accountName: "Tax-Free Saver",
                                                balance: 2000.00)
        
        let inv2 = AccountSummaryCell.ViewModel(accountType: .Investment,
                                                   accountName: "Growth Fund",
                                                balance: 15000.00)
        
        accounts.append(savings)
        accounts.append(chequing)
        accounts.append(visa)
        accounts.append(mastercard)
        accounts.append(inv1)
        accounts.append(inv2)
    }
    
    
    private func fetchProfile() {
        
    }
    
    
}
