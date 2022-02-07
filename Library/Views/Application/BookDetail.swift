//
//  BookDetail.swift
//  Library
//
//  Created by LUKA Vouillemont on 12/01/2022.
//

import SwiftUI

struct BookDetail: View {
    var book: BookModel
    var body: some View {
        ZStack {
            Color.lightgraySet.edgesIgnoringSafeArea(.all)
            List {
                Section(header: Text("Détails")
                            .bold()
                            .font(.largeTitle)
                            .foregroundColor(.black)
                            ) {
                    DataRow(label: "ID", data: String(book.id!))
                    DataRow(label: "Titre", data: book.title)
                    DataRow(label: "Nombre de pages", data: String(book.nbPages!))
                    DataRow(label: "Prix", data: "\(String(format: "%.2f", book.prix!))€")
                    DataRow(label: "Auteur", data: "\(book.author!.firstname) \(book.author!.lastname)")
                }
            }
            .listStyle(.plain)
            .background(Color.lightgraySet)
        }
    }
}

struct BookDetail_Previews: PreviewProvider {
    static var previews: some View {
        BookDetail(
            book: BookModel(
                id: 3,
                title: "Les incouchables",
                nbPages: 245,
                prix: 21.99,
                author: AuthorModel(
                    id: 3,
                    firstname: "Jean-Marie",
                    lastname: "Lepeigne",
                    datns: "2022-01-02T19:30:13+00:00",
                    location: "France",
                    iri: "/api/authors/3"
                )
            )
        )
    }
}
