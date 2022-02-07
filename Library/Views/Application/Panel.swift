//
//  Panel.swift
//  Library
//
//  Created by LUKA Vouillemont on 03/01/2022.
//

import SwiftUI

struct Panel: View {
    @EnvironmentObject private var booksVM: BookViewModel
    @EnvironmentObject private var authorsVM: AuthorViewModel
    var body: some View {
        NavigationView {
            VStack {
                Text("Bienvenue sur la page administrateur")
                    .bold()
                    .multilineTextAlignment(.center)
                    .font(.largeTitle)
                List {
                    Section(header: Text("VOTRE BIBLIOTHEQUE")) {
                        Text("\(authorsVM.authorsNumber) Auteurs")
                        Text("\(booksVM.booksNumber) Bouquins")
                    }
                }
                .navigationBarTitle("Admin", displayMode: .inline)
                .listStyle(.plain)
            }
            .background(Color("lightgray"))
        }
    }
}

struct Panel_Previews: PreviewProvider {
    static var previews: some View {
        Panel()
            .environmentObject(BookViewModel())
            .environmentObject(AuthorViewModel())
    }
}
