//
//  AuthorDetail.swift
//  Library
//
//  Created by LUKA Vouillemont on 12/01/2022.
//

import SwiftUI

struct AuthorDetail: View {
    var author: AuthorModel
    @State private var authorBookList: [AuthorBookModel] = []
    @State private var isLoading: Bool = true
    
    var bookListHeader: Text {
        Text(isLoading ? "Chargement..." : "Livres (\(authorBookList.count))")
            .bold()
            .font(.largeTitle)
            .foregroundColor(.black)
    }
    
    public func formatDate(date: String) -> String {
        let dateFormatter = ISO8601DateFormatter()
        let outDateFormatter: DateFormatter = {
                let df = DateFormatter()
                df.dateFormat = "d MMMM yyyy"
                df.locale = Locale(identifier: "fr-FR")
                return df
            }()
        if let isoDate = dateFormatter.date(from: date) {
            return outDateFormatter.string(from: isoDate)
        }
        
        return "error"
    }
    
    public func getAuthorBooks() {
        guard let url = URL(string: "\(baseURL)/authors/\(author.id!)/books") else {
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
                let decodedResponse = try JSONDecoder().decode(AuthorBookResponse.self, from: data)
                DispatchQueue.main.async {
                    authorBookList = decodedResponse.books
                    isLoading = false
                }
            } catch {
                isLoading = false
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    var body: some View {
        ZStack {
            Color.lightgraySet.ignoresSafeArea(.all)
            List {
                Section(header: Text("Détails")
                            .bold()
                            .font(.largeTitle)
                            .foregroundColor(.black)
                            ) {
                    DataRow(label: "ID", data: String(author.id!))
                    DataRow(label: "Prénom", data: author.firstname)
                    DataRow(label: "Nom", data: author.lastname)
                    DataRow(label: "Date de naissance", data: formatDate(date: author.datns!))
                    DataRow(label: "Lieu d'habitation", data: author.location!)
                }
                
                Section(header: bookListHeader) {
                    ForEach(authorBookList, id: \.id) { book in
                        HStack {
                            Text(book.title)
                        }
                    }
                }
            }
            .listStyle(.plain)
            .background(Color.lightgraySet)
            .onAppear {
                getAuthorBooks()
            }
        }
    }
}

struct AuthorDetail_Previews: PreviewProvider {
    static var previews: some View {
        AuthorDetail(
            author: AuthorModel(
                id: 8,
                firstname: "John",
                lastname: "Doe",
                datns: "2022-01-02T19:29:40+00:00",
                location: "NY",
                iri: "/api/authors/8"
            )
        )
    }
}
