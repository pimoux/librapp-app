//
//  Date.swift
//  Library
//
//  Created by LUKA Vouillemont on 01/03/2022.
//

import Foundation

extension Date {
    
    static func ISOStringFromDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        
        return dateFormatter.string(from: date).appending("Z")
    }
    
    static func formatDate(date: String) -> String {
        let dateFormatter = ISO8601DateFormatter()
        let outDateFormatter: DateFormatter = {
                let df = DateFormatter()
                df.dateFormat = "d MMMM yyyy"
                df.locale = Locale(identifier: "fr-FR")
                return df
            }()
        if let isoDate = dateFormatter.date(from: date) {
            return outDateFormatter.string(from: isoDate)
        }
        
        return "error"
    }
    
    func timeAgo() -> String {
            let calendar = Calendar.current
            let minuteAgo = calendar.date(byAdding: .minute, value: -1, to: Date())!
            let hourAgo = calendar.date(byAdding: .hour, value: -1, to: Date())!
            let dayAgo = calendar.date(byAdding: .day, value: -1, to: Date())!
            let weekAgo = calendar.date(byAdding: .weekOfYear, value: -1, to: Date())!
            let monthAgo = calendar.date(byAdding: .month, value: -1, to: Date())!
            let yearAgo = calendar.date(byAdding: .year, value: -1, to: Date())!
            if minuteAgo < self {
                let diff = Calendar.current.dateComponents([.second], from: self, to: Date()).second ?? 0
                return "\(diff) seconde\(diff <= 1 ? "" : "s")"
            } else if hourAgo < self {
                let diff = Calendar.current.dateComponents([.minute], from: self, to: Date()).minute ?? 0
                return "\(diff) minute\(diff <= 1 ? "" : "s")"
            } else if dayAgo < self {
                let diff = Calendar.current.dateComponents([.hour], from: self, to: Date()).hour ?? 0
                return "\(diff) heure\(diff <= 1 ? "" : "s")"
            } else if weekAgo < self {
                let diff = Calendar.current.dateComponents([.day], from: self, to: Date()).day ?? 0
                return "\(diff) jour\(diff <= 1 ? "" : "s")"
            } else if monthAgo < self {
                let diff = Calendar.current.dateComponents([.weekOfYear], from: self, to: Date()).weekOfYear ?? 0
                return "\(diff) semaine\(diff <= 1 ? "" : "s")"
            } else if yearAgo < self {
                let diff = Calendar.current.dateComponents([.month], from: self, to: Date()).month ?? 0
                return "\(diff) mois"
            }
            let diff = Calendar.current.dateComponents([.year], from: self, to: Date()).year ?? 0
            return "\(diff) année\(diff <= 1 ? "" : "s")"
        }
}
