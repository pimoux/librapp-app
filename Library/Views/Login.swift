//
//  Login.swift
//  Library
//
//  Created by LUKA Vouillemont on 01/02/2022.
//

import SwiftUI

struct Login: View {
    @State private var email: String = ""
    @State private var password: String = ""
    
    public func login() {
        
    }
    
    var body: some View {
        VStack {
            Text("Se connecter")
                .font(.largeTitle)
                .bold()
                .padding(.vertical)
            Image(systemName: "book.closed.circle")
                .font(.system(size: 200))
                .padding(.vertical)
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
            HStack {
                Spacer()
                Text("Mot de passe oublié?")
                    .foregroundColor(darkBlue)
            }
            SubmitButton(callback: login(), label: "Se connecter")
                .padding(.top, 30)
            HStack {
                Text("Pas encore inscrit ?")
                    .fontWeight(.medium)
                Text("Inscrivez vous ici")
                    .bold()
                    .foregroundColor(darkBlue)
            }
            .padding(.vertical, 20)
        }
        .padding(.horizontal)
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
