//
//  CreateAuthor.swift
//  Library
//
//  Created by LUKA Vouillemont on 14/01/2022.
//

import SwiftUI

struct CreateAuthor: View {
    @State private var firstname: String = ""
    @State private var lastname: String = ""
    @State private var datns: Date = Date()
    @State private var location: String = ""
    @State private var isAlert: Bool = false
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var authorHandler: AuthorHandler
    
    init() {
        UITableView.appearance().backgroundColor = .clear
    }
    
    public func submitAuthorData() {
        if firstname != "" && lastname != "" && location != "" && datns <= Date.now {
            let body: [String: Any] = [
                "firstname": firstname,
                "lastname": lastname,
                "datns": Date.ISOStringFromDate(date: datns),
                "location": location
            ]
            authorHandler.createAuthor(body: body)
            presentationMode.wrappedValue.dismiss()
        } else {
            isAlert.toggle()
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                lightgray.edgesIgnoringSafeArea(.all)
                VStack(alignment: .leading) {
                    Text("Ajouter un auteur")
                        .bold()
                        .font(.largeTitle)
                        .padding()
                    Form {
                        InputField(header: "Prénom", textContent: $firstname)
                        InputField(header: "Nom", textContent: $lastname)
                        Section(header: Text("Date de naissance")
                                    .bold()
                                    .font(.title)
                                    .textCase(.none)
                                    .foregroundColor(.black)) {
                            DatePicker("", selection: $datns, displayedComponents: .date)
                                .datePickerStyle(.wheel)
                        }
                        InputField(header: "Lieu d'habitation", textContent: $location)
                        SubmitButton(callback: submitAuthorData(), label: "Ajouter")
                    }
                }
                .alert(isPresented: $isAlert) {
                    let titleError = Text("Données incorrecte")
                    let messageError = Text("Les champs n'ont pas été remplis ou ne sont pas remplis correctement")
                    return Alert(title: titleError, message: messageError)
                }
            }
            .navigationBarTitle("Nouvel auteur", displayMode: .inline)
        }
    }
}

struct CreateAuthor_Previews: PreviewProvider {
    static var previews: some View {
        CreateAuthor()
    }
}
