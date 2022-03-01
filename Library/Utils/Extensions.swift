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

extension Color {
    static let lightgraySet = Color("lightgray")
    static let lightgrayFieldSet = Color("lightgrayField")
    static let lightgrayNavSet = Color("lightgrayNav")
    static let lightgrayEditItemSet = Color("lightgrayEditItem")
    static let darkBlueSet = Color("darkBlue")
    static let turquoiseSet = Color("turquoise")
    static let darkSet = Color("dark")
}

extension View {
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
    
    func getSafeArea() -> UIEdgeInsets {
        return UIApplication.shared.windows.first?.safeAreaInsets ?? UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

extension UIImage {

    public enum DataUnits: String {
        case byte, kilobyte, megabyte, gigabyte
    }

    func getSizeIn(_ type: DataUnits)-> String {

        guard let data = self.jpegData(compressionQuality: 0.7) else {
            return ""
        }

        var size: Double = 0.0

        switch type {
        case .byte:
            size = Double(data.count)
        case .kilobyte:
            size = Double(data.count) / 1024
        case .megabyte:
            size = Double(data.count) / 1024 / 1024
        case .gigabyte:
            size = Double(data.count) / 1024 / 1024 / 1024
        }

        return String(format: "%.2f", size)
    }
}
