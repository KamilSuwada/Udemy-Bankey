//
//  CurrencyFormatterTests.swift
//  BankeyUnitTests
//
//  Created by Kamil Suwada on 03/07/2022.
//

import Foundation
import XCTest

@testable import Bankey

class Test: XCTestCase
{
    var formatter: CurrencyFormatter!
    
    
    override func setUp()
    {
        super.setUp()
        formatter = CurrencyFormatter()
    }
    
    
    
    func testBreakDollarsIntoCents() throws
    {
        let result = formatter.breakIntoDollarsAndCents(929466.23)
        XCTAssertEqual(result.0, "929,466")
        XCTAssertEqual(result.1, "23")
    }
    
    
    
    func testDollarsFormatted() throws
    {
        let result1 = formatter.dollarsFormatted(123.22)
        let result2 = formatter.dollarsFormatted(0.22)
        let result3 = formatter.dollarsFormatted(123123123.22)
        let result4 = formatter.dollarsFormatted(0)
        let result5 = formatter.dollarsFormatted(12)
        
        XCTAssertEqual(result1, "£123.22")
        XCTAssertEqual(result2, "£0.22")
        XCTAssertEqual(result3, "£123,123,123.22")
        XCTAssertEqual(result4, "£0.00")
        XCTAssertEqual(result5, "£12.00")
    }
    
    
    
}
