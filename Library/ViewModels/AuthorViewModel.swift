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
}
