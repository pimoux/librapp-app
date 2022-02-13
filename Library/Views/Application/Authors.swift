//
//  Authors.swift
//  Library
//
//  Created by LUKA Vouillemont on 03/01/2022.
//

import SwiftUI

struct Authors: View {
    @State private var searchFilter: String = ""
    @EnvironmentObject var authorVM: AuthorViewModel
    @State private var isPresentedCreateAuthor: Bool = false
    var body: some View {
        NavigationView {
            ZStack {
                Color.lightgraySet.edgesIgnoringSafeArea(.top)
                VStack {
                    VStack {
                        HStack {
                            Image(systemName: "magnifyingglass")
                            TextField("Search", text: $searchFilter)
                        }
                        .padding(10)
                        .background(Color("lightgrayField"))
                        .cornerRadius(8)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    
                    List {
                        Section(header: Text(searchFilter.isEmpty ? "\(authorVM.authorsNumber) AUTEURS DISPONIBLES" : "\(authorVM.authors.filter({$0.firstname.lowercased().contains(searchFilter.lowercased()) || $0.lastname.lowercased().contains(searchFilter.lowercased()) || searchFilter.isEmpty}).count) AUTEURS DISPONIBLES")) {
                            ForEach(authorVM.authors.filter({$0.firstname.lowercased().contains(searchFilter.lowercased()) || $0.lastname.lowercased().contains(searchFilter.lowercased()) || searchFilter.isEmpty}), id: \.id) { author in
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
                    .background(Color.lightgraySet)
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
                .foregroundColor(.darkBlueSet)
        }
    }
    
    var editAuthor: some View {
//        NavigationLink(destination: EditAuthor()) {
//            Text("edit")
//                .foregroundColor(.darkBlueSet)
//                .fontWeight(.regular)
//        }
        Text("edit")
            .foregroundColor(.darkBlueSet)
            .fontWeight(.regular)
    }
}

struct Authors_Previews: PreviewProvider {
    static var previews: some View {
        Authors()
            .environmentObject(AuthorViewModel())
    }
}
