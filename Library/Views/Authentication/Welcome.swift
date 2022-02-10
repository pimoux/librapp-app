//
//  Welcome.swift
//  Library
//
//  Created by LUKA Vouillemont on 06/02/2022.
//

import SwiftUI

struct Welcome: View {
    @State private var showRegister: Bool = false
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
            
            ZStack {
                if showRegister {
                    Register(isRegistered: $showRegister).transition(.move(edge: .trailing))
                } else {
                    Login().transition(.move(edge: .leading))
                }
            }
            .padding(.top, -maxCircleHeight / 1.7)
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .overlay(
            HStack {
                Text(showRegister ? "Déjà membre ?" : "Nouveau membre ?")
                    .fontWeight(.bold)
                    .foregroundColor(.darkSet)
                
                Button {
                    withAnimation {
                        showRegister.toggle()
                    }
                } label: {
                    Text(showRegister ? "Se connecter" : "S'inscrire")
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

struct Welcome_Previews: PreviewProvider {
    static var previews: some View {
        Welcome()
    }
}
