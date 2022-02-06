//
//  Models.swift
//  Library
//
//  Created by LUKA Vouillemont on 13/01/2022.
//

import Foundation

let baseURL: String = "https://librapp-back.herokuapp.com/api"

struct BookModel: Decodable {
    var id: Int?
    var title: String
    var nbPages: Int?
    var prix: Double?
    var author: AuthorModel?
}

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

struct BooksResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case books = "hydra:member"
        case booksNumber = "hydra:totalItems"
    }
    var books: [BookModel]
    var booksNumber: Int
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
