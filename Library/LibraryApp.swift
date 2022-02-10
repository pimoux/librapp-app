//
//  LibraryApp.swift
//  Library
//
//  Created by LUKA Vouillemont on 02/01/2022.
//

import SwiftUI

@main
struct LibraryApp: App {
    @StateObject private var authVM: AuthViewModel = AuthViewModel()
    var body: some Scene {
        WindowGroup {
            if authVM.isAuthenticated {
                Home().environmentObject(authVM)
            } else {
                Welcome().environmentObject(authVM)
            }
        }
    }
}
