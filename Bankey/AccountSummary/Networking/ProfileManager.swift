//
//  ProfileManager.swift
//  Bankey
//
//  Created by Kamil Suwada on 08/07/2022.
//

import Foundation


protocol ProfileManageable: AnyObject
{
    func fetchProfile(forUserID userID: String, completion: @escaping (Result<Profile,NetworkError>) -> Void)
    func fetchAccounts(forUserID userID: String, completion: @escaping (Result<Array<Account>, NetworkError>) -> Void)
}


class ProfileManager: ProfileManageable
{
    
    func fetchProfile(forUserID userID: String, completion: @escaping (Result<Profile, NetworkError>) -> Void)
    {
        let url = URL(string: "https://fierce-retreat-36855.herokuapp.com/bankey/profile/\(userID)")!
        
        URLSession.shared.dataTask(with: url)
        { data, response, error in
            DispatchQueue.main.async
            {
                guard let data = data, error == nil else { completion(.failure(.serverError)); return }
                
                do
                {
                    let profile = try JSONDecoder().decode(Profile.self, from: data)
                    completion(.success(profile))
                }
                catch
                {
                    completion(.failure(.serverError))
                }
            }
        }.resume()
    }
    
    
    
    func fetchAccounts(forUserID userID: String, completion: @escaping (Result<Array<Account>, NetworkError>) -> Void)
    {
        let url = URL(string: "https://fierce-retreat-36855.herokuapp.com/bankey/profile/\(userID)/accounts")!
        
        URLSession.shared.dataTask(with: url)
        { data, response, error in
            DispatchQueue.main.async
            {
                guard let data = data, error == nil else { completion(.failure(.serverError)); return }
                
                do
                {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    
                    let accounts = try decoder.decode(Array<Account>.self, from: data)
                    completion(.success(accounts))
                }
                catch
                {
                    completion(.failure(.decodingError))
                }
            }
        }.resume()
    }
    
}


enum NetworkError: Error
{
    case serverError
    case decodingError
}



enum AccountType: String, Codable {
    case Banking = "Banking"
    case CreditCard = "CreditCard"
    case Investment = "Investment"
}



struct Profile: Codable
{
    let id: String
    let firstName: String
    let lastName: String
    
    
    enum CodingKeys: String, CodingKey
    {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
    }
}




struct Account: Codable
{
    let id: String
    let type: AccountType
    let name: String
    let amount: Decimal
    let createdDateTime: Date
    
    static func makeSkeleton() -> Account
    {
        return Account(id: "1", type: .Banking, name: "Account Name", amount: 0.0, createdDateTime: Date())
    }
}
