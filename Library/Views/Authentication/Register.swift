//
//  Register.swift
//  Library
//
//  Created by LUKA Vouillemont on 01/02/2022.
//

import SwiftUI

struct Register: View {
    @State private var registration: RegisterModel = RegisterModel()
    var body: some View {
        VStack {
            Text("S'inscrire")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.darkSet)
                .kerning(1.9)
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack {
                EntryField(
                    placeholder: "John",
                    label: "Nom",
                    textContent: $registration.firstname,
                    paddingValue: 25,
                    isSecure: false
                )
                EntryField(
                    placeholder: "Doe",
                    label: "Prénom",
                    textContent: $registration.lastname,
                    paddingValue: 20,
                    isSecure: false
                )
            }
            EntryField(
                placeholder: "john@doe.fr",
                label: "Adresse mail",
                textContent: $registration.email,
                paddingValue: 20,
                isSecure: false
            )
            HStack {
                EntryField(
                    placeholder: "blablabla",
                    label: "Mot de passe",
                    textContent: $registration.password,
                    paddingValue: 20,
                    isSecure: true
                )
                EntryField(
                    placeholder: "blablabla",
                    label: "Répéter mot de passe",
                    textContent: $registration.repeatPassword,
                    paddingValue: 20,
                    isSecure: true
                )
            }
            
            Button {
                print("salut")
            } label: {
                Image(systemName: "arrow.right")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.darkSet)
                    .clipShape(Circle())
                    .shadow(color: .turquoiseSet.opacity(0.6), radius: 5, x: 0, y: 0)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 10)
        }
        .padding()
    }
}

struct Register_Previews: PreviewProvider {
    static var previews: some View {
        Register()
    }
}
