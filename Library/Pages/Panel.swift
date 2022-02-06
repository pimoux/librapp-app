//
//  Panel.swift
//  Library
//
//  Created by LUKA Vouillemont on 03/01/2022.
//

import SwiftUI

struct Panel: View {
    @EnvironmentObject private var books: BookHandler
    @EnvironmentObject private var authors: AuthorHandler
    var body: some View {
        NavigationView {
            VStack {
                Text("Bienvenue sur la page administrateur")
                    .bold()
                    .multilineTextAlignment(.center)
                    .font(.largeTitle)
                List {
                    Section(header: Text("VOTRE BIBLIOTHEQUE")) {
                        Text("\(authors.authorsNumber) Auteurs")
                        Text("\(books.booksNumber) Bouquins")
                    }
                }
                .navigationBarTitle("Admin", displayMode: .inline)
                .listStyle(.plain)
            }
            .background(lightgray)
        }
    }
}

struct Panel_Previews: PreviewProvider {
    static var previews: some View {
        Panel()
            .environmentObject(BookHandler())
            .environmentObject(AuthorHandler())
    }
}
