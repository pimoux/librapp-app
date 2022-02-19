//
//  CreateBook.swift
//  Library
//
//  Created by LUKA Vouillemont on 14/01/2022.
//

import SwiftUI
import Combine

struct CreateBook: View {
    @State private var bookData: CreateBookModel = CreateBookModel()
    @State private var isAlert: Bool = false
    @State private var shouldAnimate = false
    @State private var displayLoading = false
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
                        InputField(header: "Titre", textContent: $bookData.title)
                        Section(header: Text("Nombre de pages")
                                    .bold()
                                    .font(.title)
                                    .textCase(.none)
                                    .foregroundColor(.black)) {
                            TextField("Nombre de pages", text: $bookData.nbPages)
                                .background(.white)
                                .cornerRadius(10)
                                .keyboardType(.numberPad)
                                .onReceive(Just(bookData.nbPages)) { newPageNum in
                                    let filtered = newPageNum.filter { "0123456789".contains($0) }
                                    if filtered != newPageNum {
                                        self.bookData.nbPages = filtered
                                    }
                                }
                        }
                        Section(header: Text("Prix")
                                    .bold()
                                    .font(.title)
                                    .textCase(.none)
                                    .foregroundColor(.black)) {
                            TextField("Prix", text: $bookData.prix)
                                .background(.white)
                                .cornerRadius(10)
                                .keyboardType(.decimalPad)
                                .onReceive(Just(bookData.prix)) { price in
                                    let filtered = price.filter { "0123456789.".contains($0) }
                                    if filtered != price {
                                        self.bookData.nbPages = filtered
                                    }
                                }
                        }
                        Section(header: Text("")) {
                            Picker("Auteur", selection: $bookData.selectedAuthor) {
                                ForEach(authorVM.authors, id: \.id) { author in
                                    Text("\(author.firstname) \(author.lastname)").tag(author.iri!)
                                }
                                .navigationBarTitle("Auteurs disponible")
                            }
                        }
                        Button {
                            if let prix = Double(bookData.prix), prix > 0,
                               let nbPages = Int(bookData.nbPages), nbPages > 0,
                               bookData.title != "" && bookData.selectedAuthor != "" {
                                self.displayLoading.toggle()
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                                    self.shouldAnimate.toggle()
                                }
                                let body: [String: Any] = [
                                    "title": bookData.title,
                                    "nbPages": nbPages,
                                    "prix": prix,
                                    "author": bookData.selectedAuthor
                                ]
                                bookVM.createBook(body: body)
                                DispatchQueue.main.asyncAfter(deadline: .now() + 100) {
                                    self.displayLoading.toggle()
                                    self.shouldAnimate.toggle()
                                }
                                presentationMode.wrappedValue.dismiss()
                            } else {
                                isAlert = true
                            }
                        } label: {
                            if displayLoading {
                                LoadingCircles(shouldAnimate: shouldAnimate)
                                    .padding(.vertical)
                            } else {
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
                        .disabled(shouldAnimate)
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
