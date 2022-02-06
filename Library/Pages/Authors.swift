//
//  Authors.swift
//  Library
//
//  Created by LUKA Vouillemont on 03/01/2022.
//

import SwiftUI

struct Authors: View {
    @State private var searchFilter: String = ""
    @EnvironmentObject var authorHandler: AuthorHandler
    @State private var isPresentedCreateAuthor: Bool = false
    var body: some View {
        NavigationView {
            ZStack {
                lightgrayNav.edgesIgnoringSafeArea(.top)
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
                        Section(header: Text("\(authorHandler.authors.filter({$0.firstname.contains(searchFilter) || $0.lastname.contains(searchFilter) || searchFilter.isEmpty}).count) AUTEURS DISPONIBLES")) {
                            ForEach(authorHandler.authors.filter({$0.firstname.contains(searchFilter) || $0.lastname.contains(searchFilter) || searchFilter.isEmpty}), id: \.id) { author in
                                NavigationLink(destination: AuthorDetail(author: author)) {
                                    HStack {
                                        Text("\(author.firstname) \(author.lastname)")
                                    }
                                }
                            }
                        }
                    }
                    .sheet(isPresented: $isPresentedCreateAuthor) {
                        CreateAuthor()
                    }
                    .background(lightgray)
                    .listStyle(.plain)
                }
                .navigationBarTitle("Auteurs", displayMode: .inline)
                .navigationBarItems(leading: addAuthor, trailing: editAuthor)
            }
        }
    }
    
    var addAuthor: some View {
        Button {
            self.isPresentedCreateAuthor.toggle()
        } label: {
            Image(systemName: "plus")
                .foregroundColor(darkBlue)
        }
    }
    
    var editAuthor: some View {
//        NavigationLink(destination: EditAuthor()) {
//            Text("edit")
//                .foregroundColor(darkBlue)
//                .fontWeight(.regular)
//        }
        Text("edit")
            .foregroundColor(darkBlue)
            .fontWeight(.regular)
    }
}

struct Authors_Previews: PreviewProvider {
    static var previews: some View {
        Authors()
            .environmentObject(AuthorHandler())
    }
}
