//
//  AuthorModels.swift
//  Library
//
//  Created by LUKA Vouillemont on 06/02/2022.
//

import Foundation

struct AuthorBookModel: Decodable {
    var id: Int
    var title: String
}

struct AuthorModel: Decodable {
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case firstname = "firstname"
        case lastname = "lastname"
        case datns = "datns"
        case location = "location"
        case iri = "@id"
    }
    var id: Int?
    var firstname: String
    var lastname: String
    var datns: String?
    var location: String?
    var iri: String?
}

struct AuthorBookResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case books = "hydra:member"
    }
    
    var books: [AuthorBookModel]
}

struct AuthorsResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case authors = "hydra:member"
        case authorsNumber = "hydra:totalItems"
    }
    var authors: [AuthorModel]
    var authorsNumber: Int
}
