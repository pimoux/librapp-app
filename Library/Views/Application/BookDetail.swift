//
//  BookDetail.swift
//  Library
//
//  Created by LUKA Vouillemont on 12/01/2022.
//

import SwiftUI

struct BookDetail: View {
    var book: BookModel
    @State private var selectedImage: UIImage? = nil
    @State private var openPhotoLibrary: Bool = false
    
    func getDateFromISOString(_ isoDateString: String) -> Date {
        let dateFormatter = ISO8601DateFormatter()
        let date = dateFormatter.date(from: isoDateString)
        if let date = date {
            return date
        } else {
            return Date()
        }
    }
    
    var body: some View {
        ZStack {
            Color.lightgraySet.edgesIgnoringSafeArea(.all)
            VStack {
                List {
                    Section(header: Text("Détails")
                                .bold()
                                .font(.largeTitle)
                                .foregroundColor(.black)
                                ) {
                        DataRow(label: "ID", data: String(book.id!))
                        DataRow(label: "Titre", data: book.title)
                        DataRow(label: "Nombre de pages", data: String(book.nbPages!))
                        DataRow(label: "Prix", data: "\(String(format: "%.2f", book.prix!))€")
                        DataRow(label: "Auteur", data: "\(book.author!.firstname) \(book.author!.lastname)")
                        DataRow(label: "Créé le", data: Date.formatDate(date: book.createdAt))
                    }
                }
                .listStyle(.plain)
                .background(Color.lightgraySet)
                Text("Page de couverture")
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                if selectedImage != nil {
                    Button {
                        selectedImage = nil
                    } label: {
                        Text("supprimer la page de couverture")
                            .fontWeight(.medium)
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading)
                    }
                }
                ScrollView {
                    VStack {
                        Button {
                            openPhotoLibrary = true
                        } label: {
                            Text(selectedImage == nil ? "Ajouter une page de couverture" : "Modifier la page de couverture")
                        }
                        
                        if let image = selectedImage {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 220, maxHeight: 330)
                            Button {
                                
                            } label: {
                                Text("Sauvegarder")
                            }

                        }

                        Text("Dernière modification il y a \(getDateFromISOString(book.updatedAt).timeAgo())")
                    }
                }
            }
        }
        .sheet(isPresented: $openPhotoLibrary) {
            ImagePicker(selectedImage: $selectedImage, sourceType: .photoLibrary)
        }
    }
}

struct BookDetail_Previews: PreviewProvider {
    static var previews: some View {
        BookDetail(
            book: BookModel(
                id: 3,
                title: "Les incouchables",
                nbPages: 245,
                prix: 21.99,
                author: AuthorModel(
                    id: 3,
                    firstname: "Jean-Marie",
                    lastname: "Lepeigne",
                    datns: "2022-01-02T19:30:13+00:00",
                    location: "France",
                    iri: "/api/authors/3"
                ),
                createdAt: "2022-02-17T16:44:01+00:00",
                updatedAt: "2022-02-17T16:44:01+00:00"
            )
        )
    }
}
