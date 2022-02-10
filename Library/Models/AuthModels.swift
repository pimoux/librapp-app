//
//  AuthModels.swift
//  Library
//
//  Created by LUKA Vouillemont on 06/02/2022.
//

import Foundation

struct RegisterModel {
    var firstname: String = ""
    var lastname: String = ""
    var email: String = ""
    var password: String = ""
    var repeatPassword: String = ""
}

struct LoginModel {
    var email: String = ""
    var password: String = ""
}

struct LoginResponse: Decodable {
    var token: String
}
