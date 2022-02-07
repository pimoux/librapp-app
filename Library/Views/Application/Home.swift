//
//  Home.swift
//  Library
//
//  Created by LUKA Vouillemont on 06/02/2022.
//

import SwiftUI

struct Home: View {
    @StateObject var bookVM = BookViewModel()
    @StateObject var authorVM = AuthorViewModel()
    var body: some View {
        TabView {
            Panel()
                .tabItem {
                    VStack {
                        Image(systemName: "person")
                        Text("Admin")
                    }
                }
            Books()
                .tabItem {
                    VStack {
                        Image(systemName: "book.closed")
                        Text("Livres")
                    }
                }
            Authors()
                .tabItem {
                    VStack {
                        Image(systemName: "person.3")
                        Text("Auteurs")
                    }
                }
        }
        .environmentObject(bookVM)
        .environmentObject(authorVM)
        .accentColor(.darkBlueSet)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
