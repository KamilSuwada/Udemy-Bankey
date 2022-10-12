//
//  AccountSummaryVCTests.swift
//  BankeyUnitTests
//
//  Created by Kamil Suwada on 08/07/2022.
//

import Foundation
import XCTest

@testable import Bankey

class AccountSummaryVCTests: XCTestCase
{
    var vc: AccountSummaryVC!
    var mockManager: MockProfileManager!
    
    
    override func setUp()
    {
        super.setUp()
        vc = AccountSummaryVC()
        mockManager = MockProfileManager()
        vc.profileManager = mockManager
        vc.loadViewIfNeeded()
    }
    
    
    func testShouldBeVisible() throws
    {
        let isViewLoaded = vc.isViewLoaded
        XCTAssertTrue(isViewLoaded)
    }
    
    
    func testTitleAndMessageForServerError() throws
    {
        let titleAndMessage = vc.titleAndMessageForTesting(for: .serverError)
        XCTAssertEqual("Network Error", titleAndMessage.0)
        XCTAssertEqual("Please check your network connection and try again.", titleAndMessage.1)
    }
    
    
    func testTitleAndMessageForDecodingError() throws
    {
        let titleAndMessage = vc.titleAndMessageForTesting(for: .decodingError)
        XCTAssertEqual("Decoding Error", titleAndMessage.0)
        XCTAssertEqual("Ups! Something went wrong on our end. Could not decode accounts! Please check again later and make sure your app is up to date.\n\nApp will now exit.", titleAndMessage.1)
    }
}




// MARK: Mock profile manager:
class MockProfileManager: ProfileManageable
{
    var profile: Profile?
    var error: NetworkError?
    
    
    func fetchProfile(forUserID userID: String, completion: @escaping (Result<Profile, NetworkError>) -> Void) {
        if error != nil
        {
            completion(.failure(error!))
        }
        
        profile = Profile(id: "1", firstName: "Kam", lastName: "Suwada")
        completion(.success(profile!))
    }
    
    
    func fetchAccounts(forUserID userID: String, completion: @escaping (Result<Array<Account>, NetworkError>) -> Void) {
        return
    }
}
