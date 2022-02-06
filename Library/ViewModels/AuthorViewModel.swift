//
//  AuthorHandler.swift
//  Library
//
//  Created by LUKA Vouillemont on 13/01/2022.
//

import Foundation

class AuthorViewModel: ObservableObject {
    @Published var authors = [AuthorModel]()
    @Published var authorsNumber: Int = 0
    
    init() {
        self.getAuthors()
    }
    
    public func getAuthors() {
        guard let url = URL(string: "\(baseURL)/authors") else {
            print("ERROR WITH URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(AuthorsResponse.self, from: data)
                DispatchQueue.main.async {
                    self.authors = decodedResponse.authors
                    self.authorsNumber = decodedResponse.authorsNumber
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
    
    public func createAuthor(body: [String: Any]) {
        guard let url = URL(string: "\(baseURL)/authors") else {
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
                        self.getAuthors()
                    }
                } else {
                    print("An error occured in create author: status \(response.statusCode)")
                }
            }
        }.resume()
    }
    
    public func editAuthor(id: Int, body: [String: Any]) {
        guard let url = URL(string: "\(baseURL)/authors/\(id)") else {
            return
        }
        
        var request = URLRequest(url: url)
        let serializedBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        
        request.httpMethod = "PATCH"
        request.httpBody = serializedBody
        request.setValue("application/merge-patch+json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
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
                        print("author edited successfully")
                    } else if response.statusCode == 404 {
                        print("author not found")
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    public func deleteAuthor(id: Int) {
        guard let url = URL(string: "\(baseURL)/authors/\(id)") else {
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
                    print("author deleted")
                } else if response.statusCode == 404 {
                    print("author not found")
                }
            }
        }
        task.resume()
    }
}
