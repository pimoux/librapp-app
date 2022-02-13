//
//  CreateAuthor.swift
//  Library
//
//  Created by LUKA Vouillemont on 14/01/2022.
//

import SwiftUI

struct CreateAuthor: View {
    @State private var authorData: CreateAuthorModel = CreateAuthorModel()
    @State private var isAlert: Bool = false
    @State private var shouldAnimate = false
    @State private var displayLoading = false
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var authorVM: AuthorViewModel
    
    init() {
        UITableView.appearance().backgroundColor = .clear
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
                        InputField(header: "Prénom", textContent: $authorData.firstname)
                        InputField(header: "Nom", textContent: $authorData.lastname)
                        Section(header: Text("Date de naissance")
                                    .bold()
                                    .font(.title)
                                    .textCase(.none)
                                    .foregroundColor(.black)) {
                            DatePicker("", selection: $authorData.datns, displayedComponents: .date)
                                .datePickerStyle(.wheel)
                        }
                        InputField(header: "Lieu d'habitation", textContent: $authorData.location)
                        Button {
                            if authorData.firstname != "" && authorData.lastname != "" && authorData.location != "" && authorData.datns <= Date.now {
                                self.displayLoading.toggle()
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                                    self.shouldAnimate.toggle()
                                }
                                let body: [String: Any] = [
                                    "firstname": authorData.firstname,
                                    "lastname": authorData.lastname,
                                    "datns": Date.ISOStringFromDate(date: authorData.datns),
                                    "location": authorData.location
                                ]
                                authorVM.createAuthor(body: body)
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
