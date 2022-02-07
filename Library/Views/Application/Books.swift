//
//  Books.swift
//  Library
//
//  Created by LUKA Vouillemont on 03/01/2022.
//

import SwiftUI

struct Books: View {
    @State private var searchFilter: String = ""
    @EnvironmentObject var bookVM: BookViewModel
    @State private var isPresented: Bool = false
    var body: some View {
        NavigationView {
            ZStack {
                Color.lightgraySet.edgesIgnoringSafeArea(.all)
                VStack {
                    VStack {
                        HStack {
                            Image(systemName: "magnifyingglass")
                            TextField("Search", text: $searchFilter)
                        }
                        .padding(10)
                        .background(Color.lightgrayFieldSet)
                        .cornerRadius(8)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    
                    List {
                        Section(header: Text("\(bookVM.books.filter({$0.title.lowercased().contains(searchFilter.lowercased()) || searchFilter.isEmpty}).count) LIVRES DISPONIBLES")) {
                            ForEach(bookVM.books.filter({$0.title.lowercased().contains(searchFilter.lowercased()) || searchFilter.isEmpty}), id: \.id) { book in
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
                    .background(Color.lightgraySet)
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
                .foregroundColor(.darkBlueSet)
        }
    }
    
    var editBook: some View {
        Text("edit")
            .foregroundColor(.darkBlueSet)
            .fontWeight(.regular)
    }
}

struct Books_Previews: PreviewProvider {
    static var previews: some View {
        Books()
            .environmentObject(BookViewModel())
    }
}
