//
//  AuthViewModel.swift
//  Library
//
//  Created by LUKA Vouillemont on 10/02/2022.
//

import Foundation

class AuthViewModel: ObservableObject {
    @Published var credentials: LoginModel = LoginModel()
    @Published var isAuthenticated: Bool = false
    
    func login(completion: @escaping (Bool) -> Void) {
        
        let defaults = UserDefaults.standard
        AuthService().login(credentials: credentials) { result in
            switch result {
            case .success(let token):
                defaults.setValue(token, forKey: "jwt")
                completion(true)
            case .failure(let error):
                completion(false)
                print(error.localizedDescription)
            }
        }
    }
    
    func setIsAuthenticated(isAuthenticated: Bool) {
        self.isAuthenticated = isAuthenticated
    }
}
