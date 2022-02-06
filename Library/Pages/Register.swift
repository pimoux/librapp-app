//
//  Register.swift
//  Library
//
//  Created by LUKA Vouillemont on 01/02/2022.
//

import SwiftUI

struct Register: View {
    @State private var firstname: String = ""
    @State private var lastname: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var repeatPassword: String = ""
    
    public func createAccount() {
        
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Créer un compte")
                    .bold()
                    .font(.largeTitle)
                    .padding(.bottom, 80)
                HStack {
                    RegisterField(
                        placeholder: "Prénom",
                        textContent: $firstname,
                        paddingDirection: .trailing,
                        paddingValue: 5
                    )
                    RegisterField(
                        placeholder: "Nom",
                        textContent: $lastname,
                        paddingDirection: .leading,
                        paddingValue: 5
                    )
                }
                .padding(.vertical, 10)
                RegisterField(
                    placeholder: "Email",
                    textContent: $email,
                    paddingDirection: .vertical,
                    paddingValue: 10
                )
                RegisterField(
                    placeholder: "Mot de passe",
                    textContent: $password,
                    paddingDirection: .vertical,
                    paddingValue: 10
                )
                RegisterField(
                    placeholder: "Répéter mot de passe",
                    textContent: $repeatPassword,
                    paddingDirection: .vertical,
                    paddingValue: 10
                )
                SubmitButton(callback: createAccount(), label: "Créer")
                    .padding(.top, 30)
                HStack {
                    Text("Déjà inscrit ?")
                        .fontWeight(.medium)
                    NavigationLink(destination: Login()) {
                        Text("Connectez vous ici")
                            .bold()
                            .foregroundColor(darkBlue)
                    }
                }
                .padding(.vertical, 20)
            }
            .padding(.horizontal)
            .padding(.bottom, 80)
        }
    }
}

struct Register_Previews: PreviewProvider {
    static var previews: some View {
        Register()
    }
}
