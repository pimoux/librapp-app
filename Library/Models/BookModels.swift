//
//  BookModels.swift
//  Library
//
//  Created by LUKA Vouillemont on 06/02/2022.
//

import Foundation

struct BookModel: Decodable {
    var id: Int?
    var title: String
    var nbPages: Int?
    var prix: Double?
    var author: AuthorModel?
}

struct BooksResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case books = "hydra:member"
        case booksNumber = "hydra:totalItems"
    }
    var books: [BookModel]
    var booksNumber: Int
}

struct CreateBookModel {
    var title: String = ""
    var nbPages: String = ""
    var prix: String = ""
    var selectedAuthor: String = ""
}
