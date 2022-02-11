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
    @EnvironmentObject var authorVM: AuthorViewModel
    
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
            authorVM.createAuthor(body: body)
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.lightgraySet.edgesIgnoringSafeArea(.all)
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
                        Button {
                            submitAuthorData()
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
