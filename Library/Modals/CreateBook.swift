//
//  CreateBook.swift
//  Library
//
//  Created by LUKA Vouillemont on 14/01/2022.
//

import SwiftUI
import Combine

struct CreateBook: View {
    @State private var title: String = ""
    @State private var nbPages: String = ""
    @State private var prix: String = ""
    @State private var selectedAuthor: String = ""
    @State private var isAlert: Bool = false
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var authorVM: AuthorViewModel
    @EnvironmentObject var bookVM: BookViewModel
    
    init() {
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.lightgraySet.edgesIgnoringSafeArea(.all)
                VStack(alignment: .leading) {
                    Text("Ajouter un livre")
                        .bold()
                        .font(.largeTitle)
                        .padding()
                    Form {
                        InputField(header: "Titre", textContent: $title)
                        Section(header: Text("Nombre de pages")
                                    .bold()
                                    .font(.title)
                                    .textCase(.none)
                                    .foregroundColor(.black)) {
                            TextField("Nombre de pages", text: $nbPages)
                                .background(.white)
                                .cornerRadius(10)
                                .keyboardType(.numberPad)
                                .onReceive(Just(nbPages)) { newPageNum in
                                    let filtered = newPageNum.filter { "0123456789".contains($0) }
                                    if filtered != newPageNum {
                                        self.nbPages = filtered
                                    }
                                }
                        }
                        Section(header: Text("Prix")
                                    .bold()
                                    .font(.title)
                                    .textCase(.none)
                                    .foregroundColor(.black)) {
                            TextField("Prix", text: $prix)
                                .background(.white)
                                .cornerRadius(10)
                                .keyboardType(.decimalPad)
                                .onReceive(Just(prix)) { price in
                                    let filtered = price.filter { "0123456789.".contains($0) }
                                    if filtered != price {
                                        self.nbPages = filtered
                                    }
                                }
                        }
                        Section(header: Text("")) {
                            Picker("Auteur", selection: $selectedAuthor) {
                                ForEach(authorVM.authors.sorted{ (cur, new) in
                                    return cur.firstname < new.firstname
                                }, id: \.id) { author in
                                    Text("\(author.firstname) \(author.lastname)").tag(author.iri!)
                                }
                                .navigationBarTitle("Auteurs disponible")
                            }
                        }
                        Button {
                            if let prix = Double(prix), let nbPages = Int(nbPages) {
                                if prix > 0 && nbPages > 0 && title != "" && selectedAuthor != "" {
                                    let body: [String: Any] = [
                                        "title": title,
                                        "nbPages": nbPages,
                                        "prix": prix,
                                        "author": selectedAuthor
                                    ]
                                    bookVM.createBook(body: body)
                                    presentationMode.wrappedValue.dismiss()
                                } else {
                                    isAlert = true
                                }
                            } else {
                                isAlert = true
                            }
                        } label: {
                            Text("Ajouter")
                                .bold()
                                .font(.title3)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical)
                                .background(Color("darkBlue"))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                }
                .alert(isPresented: $isAlert) {
                    let titleError = Text("Données incorrecte")
                    let messageError = Text("Les champs n'ont pas été remplis ou ne sont pas remplis correctement")
                    return Alert(title: titleError, message: messageError)
                }
            }
            .navigationBarTitle("Nouveau livre", displayMode: .inline)
        }
    }
}

struct CreateBook_Previews: PreviewProvider {
    static var previews: some View {
        CreateBook()
            .environmentObject(AuthorViewModel())
            .environmentObject(BookViewModel())
    }
}
