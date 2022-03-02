//
//  AuthService.swift
//  Library
//
//  Created by LUKA Vouillemont on 10/02/2022.
//

import Foundation

enum AuthenticationError: Error {
    case invalidCredentials
    case custom(errorMessage: String)
}

class AuthService {
    
    func login(credentials: LoginModel, completion: @escaping (Result<String, AuthenticationError>) -> Void) {
        guard let url = URL(string: "\(Endpoints.devBaseUrl.rawValue)/api/login_check") else {
            completion(.failure(.custom(errorMessage: "URL incorrecte")))
            return
        }
        
        let body: [String: String] = [
            "username": credentials.email,
            "password": credentials.password
        ]
        let serializedBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "accept")
        request.httpBody = serializedBody
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.custom(errorMessage: "No data")))
                return
            }
            
            guard let loginResponse = try? JSONDecoder().decode(LoginResponse.self, from: data) else {
                completion(.failure(.invalidCredentials))
                return
            }
            
            completion(.success(loginResponse.token))
        }
        .resume()
    }
    
}
