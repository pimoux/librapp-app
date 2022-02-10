//
//  Login.swift
//  Library
//
//  Created by LUKA Vouillemont on 01/02/2022.
//

import SwiftUI

struct Login: View {
    @EnvironmentObject private var loginVM: AuthViewModel
    var body: some View {
        VStack {
            Text("Se connecter")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.darkSet)
                .kerning(1.9)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            EntryField(
                placeholder: "john@doe.com",
                label: "Adresse mail",
                textContent: $loginVM.credentials.email,
                paddingValue: 25,
                isSecure: false
            )
            
            EntryField(
                placeholder: "blablabla",
                label: "Mot de passe",
                textContent: $loginVM.credentials.password,
                paddingValue: 20,
                isSecure: true
            )
            
            Button {
                print("salut")
            } label: {
                Text("Mot de passe oublié ?")
                    .fontWeight(.bold)
                    .foregroundColor(.darkSet)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.top, 10)
            
            Button {
                loginVM.login() { success in
                    loginVM.isAuthenticated = success
                }
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

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login().environmentObject(AuthViewModel())
    }
}
