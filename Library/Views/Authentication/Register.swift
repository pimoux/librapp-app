//
//  Register.swift
//  Library
//
//  Created by LUKA Vouillemont on 01/02/2022.
//

import SwiftUI

struct Register: View {
    @State private var registerData = RegisterModel()
    
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
                        textContent: $registerData.firstname,
                        paddingDirection: .trailing,
                        paddingValue: 5,
                        isSecure: false
                    )
                    RegisterField(
                        placeholder: "Nom",
                        textContent: $registerData.lastname,
                        paddingDirection: .leading,
                        paddingValue: 5,
                        isSecure: false
                    )
                }
                .padding(.vertical, 10)
                RegisterField(
                    placeholder: "Email",
                    textContent: $registerData.email,
                    paddingDirection: .vertical,
                    paddingValue: 10,
                    isSecure: false
                )
                RegisterField(
                    placeholder: "Mot de passe",
                    textContent: $registerData.password,
                    paddingDirection: .vertical,
                    paddingValue: 10,
                    isSecure: true
                )
                RegisterField(
                    placeholder: "Répéter mot de passe",
                    textContent: $registerData.repeatPassword,
                    paddingDirection: .vertical,
                    paddingValue: 10,
                    isSecure: true
                )
                SubmitButton(callback: createAccount(), label: "Créer")
                    .padding(.top, 30)
                HStack {
                    Text("Déjà inscrit ?")
                        .fontWeight(.medium)
                    NavigationLink(destination: Login()) {
                        Text("Connectez vous ici")
                            .bold()
                            .foregroundColor(.darkBlueSet)
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
