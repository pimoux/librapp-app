//
//  Books.swift
//  Library
//
//  Created by LUKA Vouillemont on 03/01/2022.
//

import SwiftUI

struct Books: View {
    @State private var searchFilter: String = ""
    @EnvironmentObject var bookList: BookHandler
    @State private var isPresented: Bool = false
    var body: some View {
        NavigationView {
            ZStack {
                lightgray.edgesIgnoringSafeArea(.all)
                VStack {
                    VStack {
                        HStack {
                            Image(systemName: "magnifyingglass")
                            TextField("Search", text: $searchFilter)
                        }
                        .padding(10)
                        .background(lightgrayField)
                        .cornerRadius(8)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    
                    List {
                        Section(header: Text("\(bookList.books.filter({$0.title.lowercased().contains(searchFilter.lowercased()) || searchFilter.isEmpty}).count) LIVRES DISPONIBLES")) {
                            ForEach(bookList.books.filter({$0.title.lowercased().contains(searchFilter.lowercased()) || searchFilter.isEmpty}), id: \.id) { book in
                                NavigationLink(destination: BookDetail(book: book)) {
                                    HStack {
                                        Text(book.title)
                                    }
                                }
                            }
                        }
                    }
                    .sheet(isPresented: $isPresented) {
                        CreateBook()
                    }
                    .background(lightgray)
                    .listStyle(.plain)
                }
                .navigationBarTitle("Livres", displayMode: .inline)
                .navigationBarItems(leading: addBook, trailing: editBook)
            }
        }
    }
    
    var addBook: some View {
        Button {
            self.isPresented.toggle()
        } label: {
            Image(systemName: "plus")
                .foregroundColor(darkBlue)
        }
    }
    
    var editBook: some View {
        Text("edit")
            .foregroundColor(darkBlue)
            .fontWeight(.regular)
    }
}

struct Books_Previews: PreviewProvider {
    static var previews: some View {
        Books()
            .environmentObject(BookHandler())
    }
}