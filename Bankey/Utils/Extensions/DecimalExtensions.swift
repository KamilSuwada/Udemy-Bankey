//
//  DecimalExtensions.swift
//  Bankey
//
//  Created by Kamil Suwada on 28/05/2022.
//

import Foundation




extension Decimal {
    var doubleValue: Double {
        return NSDecimalNumber(decimal: self).doubleValue
    }
}
