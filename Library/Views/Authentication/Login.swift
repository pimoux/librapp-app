//
//  Login.swift
//  Library
//
//  Created by LUKA Vouillemont on 01/02/2022.
//

import SwiftUI

struct Login: View {
    @EnvironmentObject private var loginVM: AuthViewModel
    @State private var isLoading: Bool = false
    @State private var isAlert: Bool = false
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
                isLoading = true
                loginVM.login() { success in
                    loginVM.setIsAuthenticated(isAuthenticated: success)
                    if !success {
                        isAlert = true
                    }
                    isLoading = false
                }
            } label: {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: Color.darkSet))
                        .scaleEffect(2)
                        .padding()
                } else {
                    Image(systemName: "arrow.right")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.darkSet)
                        .clipShape(Circle())
                        .shadow(color: .turquoiseSet.opacity(0.6), radius: 5, x: 0, y: 0)
                }
            }
            .alert(isPresented: $isAlert) {
                let titleError = Text("Informations incorrecte")
                let messageError = Text("Mauvais identifiant ou mot de passe, vérifiez si vous avez bien rempli les champs")
                return Alert(title: titleError, message: messageError)
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
