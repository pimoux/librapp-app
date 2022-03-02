//
//  BookHandler.swift
//  Library
//
//  Created by LUKA Vouillemont on 13/01/2022.
//

import Foundation
import UIKit

class BookViewModel: ObservableObject {
    @Published var books = [BookModel]()
    @Published var booksNumber: Int = 0
    
    init() {
        self.getBooks()
    }
    
    public func getBooks() {
        guard let url = URL(string: "\(Endpoints.devBaseUrl.rawValue)/api/books") else {
            return
        }
        
        guard let token = UserDefaults.standard.string(forKey: "jwt") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
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
        guard let url = URL(string: "\(Endpoints.devBaseUrl.rawValue)/api/books") else {
            return
        }
        
        guard let token = UserDefaults.standard.string(forKey: "jwt") else {
            return
        }
        
        var request = URLRequest(url: url)
        let serializedBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        
        request.httpMethod = "POST"
        request.httpBody = serializedBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "accept")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
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
    
    public func publishCoverPage(id: Int, file: UIImage, filename: String) {
        guard let url = URL(string: "\(Endpoints.devBaseUrl.rawValue)/api/books/\(id)/image") else {
            return
        }
        
        guard let token = UserDefaults.standard.string(forKey: "jwt") else {
            return
        }
        
        guard let size = Double(file.getSizeIn(.megabyte)), size < 2 else {
            print("The file is too large")
            return
        }
        
        let imageData: Data = file.jpegData(compressionQuality: 0.7) ?? Data()
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        let bodyBoundary = "--------------------------\(UUID().uuidString)"
        request.addValue("multipart/form-data; boundary=\(bodyBoundary)", forHTTPHeaderField: "Content-Type")
        let requestData = createRequestBody(imageData: imageData, boundary: bodyBoundary, attachmentKey: "file", fileName: filename)
        
        request.addValue("\(requestData.count)", forHTTPHeaderField: "content-length")
        request.httpBody = requestData
        
        URLSession.shared.dataTask(with: request) { _, response, _ in
    
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 201 {
                    DispatchQueue.main.async {
                        self.getBooks()
                    }
                } else if response.statusCode == 422 {
                    print("status 422: server cannot execute the request correctly")
                } else {
                    print("an error occured")
                }
            }
        }
        .resume()
    }
    
    func createRequestBody(imageData: Data, boundary: String, attachmentKey: String, fileName: String) -> Data{
        let lineBreak = "\r\n"
        var requestBody = Data()
        
        requestBody.append("\(lineBreak)--\(boundary + lineBreak)" .data(using: .utf8)!)
        requestBody.append("Content-Disposition: form-data; name=\"\(attachmentKey)\"; filename=\"\(fileName)\"\(lineBreak)" .data(using: .utf8)!)
        requestBody.append("Content-Type: image/png \(lineBreak + lineBreak)" .data(using: .utf8)!)
        requestBody.append(imageData)
        requestBody.append("\(lineBreak)--\(boundary)--\(lineBreak)" .data(using: .utf8)!)
        
        return requestBody
    }
}
