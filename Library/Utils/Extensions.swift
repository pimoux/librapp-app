//
//  Extensions.swift
//  Library
//
//  Created by LUKA Vouillemont on 20/01/2022.
//

import Foundation
import SwiftUI

extension Date {
    static func ISOStringFromDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        
        return dateFormatter.string(from: date).appending("Z")
    }
    
    static func dateFromISOString(string: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        return dateFormatter.date(from: string)
    }
}

extension Color {
    static let lightgraySet = Color("lightgray")
    static let lightgrayFieldSet = Color("lightgrayField")
    static let lightgrayNavSet = Color("lightgrayNav")
    static let lightgrayEditItemSet = Color("lightgrayEditItem")
    static let darkBlueSet = Color("darkBlue")
}
