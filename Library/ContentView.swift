//
//  ContentView.swift
//  Library
//
//  Created by LUKA Vouillemont on 02/01/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var bookHandler = BookHandler()
    @StateObject var authorHandler = AuthorHandler()
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
        .environmentObject(bookHandler)
        .environmentObject(authorHandler)
        .accentColor(darkBlue)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}