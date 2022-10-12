//
//  AccountSummaryCell.swift
//  Bankey
//
//  Created by Kamil Suwada on 28/05/2022.
//

import UIKit




class AccountSummaryCell: UITableViewCell {
    
    
    enum AccountType: String {
        case Banking = "Banking"
        case CreditCard = "Credit Card"
        case Investment = "Investment"
    }
    
    
    struct ViewModel {
        let accountType: AccountType
        let accountName: String
        let balance: Decimal
        
        var formattedBalance: NSMutableAttributedString {
            return CurrencyFormatter().makeAttributedCurrency(balance)
        }
    }
    
    
    var viewModel: ViewModel? = nil
    
    
    static let reuseID = "AccountSummaryCell"
    static let rowHeight: CGFloat = 112
    
    
    let typeLabel = UILabel()
    let dividerView = UIView()
    let nameLabel = UILabel()
    let balanceStackView = UIStackView()
    let balanceLabel = UILabel()
    let balanceAmmountLabel = UILabel()
    let chevron = UIImageView()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        layout()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}




// MARK: Setup and style:
extension AccountSummaryCell {
    
    
    private func setup() {
        typeLabel.setUpLabelProgramatically(withText: "Account Type", withFont: .caption1, forView: contentView)
        dividerView.setUpViewProgramaticallyAsDivider(fillWithColour: appColour, forView: contentView)
        nameLabel.setUpLabelProgramatically(withText: "No-Fee All-In Chequing", withFont: .body, forView: contentView)
        balanceLabel.setUpLabelProgramatically(withText: "Some balance", withFont: .body, forView: balanceStackView, withTextAllignement: .right)
        balanceAmmountLabel.setUpLabelProgramatically(withText: "$000,000,000,000.00", withFont: .body, forView: balanceStackView, withTextAllignement: .right)
        balanceStackView.setUpStackViewProgramatically(forAxis: .vertical, withSpacing: 0, withItems: [balanceLabel, balanceAmmountLabel], forView: contentView)
        chevron.setUpImageViewProgramatically(withImage: UIImage(systemName: "chevron.right")!.withTintColor(appColour, renderingMode: .alwaysOriginal), forView: contentView)
    }
    
    
    private func layout() {
        NSLayoutConstraint.activate([
            
            // Type label
            
            typeLabel.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 2),
            typeLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            
            
            // Divider view
            
            dividerView.topAnchor.constraint(equalToSystemSpacingBelow: typeLabel.bottomAnchor, multiplier: 1),
            dividerView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            dividerView.widthAnchor.constraint(equalToConstant: 90),
            dividerView.heightAnchor.constraint(equalToConstant: 4),
            
            
            // Name label
            
            nameLabel.topAnchor.constraint(equalToSystemSpacingBelow: dividerView.topAnchor, multiplier: 2),
            nameLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 2),
            
            
            // Stack view
            
            balanceStackView.topAnchor.constraint(equalToSystemSpacingBelow: dividerView.bottomAnchor, multiplier: 0),
            balanceStackView.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 4),
            trailingAnchor.constraint(equalToSystemSpacingAfter: balanceStackView.trailingAnchor, multiplier: 4),
            
            
            // Chevron
            
            chevron.topAnchor.constraint(equalToSystemSpacingBelow: dividerView.bottomAnchor, multiplier: 1),
            trailingAnchor.constraint(equalToSystemSpacingAfter: chevron.trailingAnchor, multiplier: 1)
        ])
    }
    
    
}




// MARK: configuration:
extension AccountSummaryCell {
    func configure(with vm: ViewModel) {
        typeLabel.text = vm.accountName
        nameLabel.text = vm.accountName
        balanceAmmountLabel.attributedText = vm.formattedBalance
        
        switch vm.accountType {
        case.Banking:
            dividerView.backgroundColor = appColour
            balanceLabel.text = "Current balance"
        case .CreditCard:
            dividerView.backgroundColor = .systemOrange
            balanceLabel.text = "Balance"
        case .Investment:
            dividerView.backgroundColor = .systemPurple
            balanceLabel.text = "Value"
        }
    }
}
