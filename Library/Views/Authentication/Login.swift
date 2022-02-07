//
//  Login.swift
//  Library
//
//  Created by LUKA Vouillemont on 01/02/2022.
//

import SwiftUI

struct Login: View {
    
    @State private var credentials = LoginModel()
    @State private var maxCircleHeight: CGFloat = 0
    
    var body: some View {
        VStack {
            
            GeometryReader{ proxy -> AnyView in
                
                let height = proxy.frame(in: .global).height
                
                DispatchQueue.main.async {
                    if maxCircleHeight == 0 {
                        maxCircleHeight = height
                    }
                }
                
                return AnyView(
                    ZStack {
                        CircleItem(color: .darkSet, x: getRect().width / 2, y: -height / 1.3)
                        CircleItem(color: .darkSet, x: -getRect().width / 2, y: -height / 1.5)
                        CircleItem(color: .turquoiseSet, x: 0, y: -height / 1.3)
                        .rotationEffect(.init(degrees: -5))
                    }
                )
            }
            .frame(maxHeight: getRect().width)
            
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
                    textContent: $credentials.email,
                    paddingValue: 25,
                    isSecure: false
                )
                
                EntryField(
                    placeholder: "blablabla",
                    label: "Mot de passe",
                    textContent: $credentials.password,
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
            .padding(.top, -maxCircleHeight / 1.7)
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .overlay(
            HStack {
                Text("Déjà membre ?")
                    .fontWeight(.bold)
                    .foregroundColor(.darkSet)
                
                Button {
                    print("salut")
                } label: {
                    Text("Se connecter")
                        .fontWeight(.bold)
                        .foregroundColor(.turquoiseSet)
                }
            },
            alignment: .bottom
        )
        .background(
            HStack {
                CircleItem(color: .turquoiseSet, x: -30, y: 0)
                .frame(width: 70, height: 70)
                
                Spacer(minLength: 0)
                
                CircleItem(color: .darkSet, x: 40, y: 20)
                .frame(width: 110, height: 110)
            }
                .offset(y: getSafeArea().bottom + 30),
            alignment: .bottom
        )
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
