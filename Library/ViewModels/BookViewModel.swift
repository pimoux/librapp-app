//
//  BookHandler.swift
//  Library
//
//  Created by LUKA Vouillemont on 13/01/2022.
//

import Foundation

class BookViewModel: ObservableObject {
    @Published var books = [BookModel]()
    @Published var booksNumber: Int = 0
    
    init() {
        self.getBooks()
    }
    
    public func getBooks() {
        guard let url = URL(string: "\(baseURL)/books") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(BooksResponse.self, from: data)
                DispatchQueue.main.async {
                    self.books = decodedResponse.books
                    self.booksNumber = decodedResponse.booksNumber
                }
            } catch let DecodingError.dataCorrupted(context) {
                print(context)
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch let DecodingError.typeMismatch(type, context)  {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch {
                print("error: ", error)
            }

        }.resume()
    }
    
    public func createBook(body: [String: Any]) {
        guard let url = URL(string: "\(baseURL)/books") else {
            return
        }
        
        var request = URLRequest(url: url)
        let serializedBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        
        request.httpMethod = "POST"
        request.httpBody = serializedBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "accept")
        
        URLSession.shared.dataTask(with: request) { (_, response, _) in
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 201 {
                    DispatchQueue.main.async {
                        self.getBooks()
                    }
                } else {
                    print("An error occured in create book: status \(response.statusCode)")
                }
            }
        }.resume()
    }
    
    public func editBook(id: Int, title: String?, nbPages: Int?, cost prix: Double?, writtenBy author: String?) {
        guard let url = URL(string: "\(baseURL)/books/\(id)") else {
            return
        }
        
        var body: [String: Any] = [:]
        if let title = title {
            body["title"] = title
        }
        if let nbPages = nbPages {
            body["nbPages"] = nbPages
        }
        if let prix = prix {
            body["prix"] = prix
        }
        if let author = author {
            body["author"] = author
        }
        var request = URLRequest(url: url)
        let serializedBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        
        request.httpMethod = "PATCH"
        request.httpBody = serializedBody
        request.setValue("application/merge-patch+json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            
            var res: AuthorModel?
            do {
                res = try JSONDecoder().decode(AuthorModel.self, from: data!)
                if let res = res {
                    print(res)
                }
                if let response = response as? HTTPURLResponse {
                    if response.statusCode == 200 {
                        print("book edited successfully")
                    } else if response.statusCode == 404 {
                        print("book not found")
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        
        task.resume()
    }
    
    public func deleteBook(id: Int) {
        guard let url = URL(string: "\(baseURL)/books/\(id)") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 204 {
                    print("book deleted")
                } else if response.statusCode == 404 {
                    print("book not found")
                }
            }
        }
        task.resume()
    }
}
