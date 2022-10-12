//
//  Date+Utils.swift
//  Bankey
//
//  Created by Kamil Suwada on 03/07/2022.
//

import Foundation




extension Date
{
    
    
    
    static var bankeyDateFormatter: DateFormatter
    {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        return formatter
    }
    
    
    
    var monthDayYearString: String
    {
        let formatter = Date.bankeyDateFormatter
        formatter.dateFormat = "MMM d, yyyy"
        return formatter.string(from: self)
    }
    
    
    
    
}
