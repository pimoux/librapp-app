//
//  ViewExtension.swift
//  Library
//
//  Created by LUKA Vouillemont on 01/03/2022.
//

import Foundation
import SwiftUI

extension View {
    func getRect() -> CGRect {
        return UIScreen.main.bounds
    }
    
    func getSafeArea() -> UIEdgeInsets {
        return UIApplication.shared.windows.first?.safeAreaInsets ?? UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
