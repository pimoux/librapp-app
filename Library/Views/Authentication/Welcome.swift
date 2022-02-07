//
//  Welcome.swift
//  Library
//
//  Created by LUKA Vouillemont on 06/02/2022.
//

import SwiftUI

struct Welcome: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Bienvenue sur librapp !")
                    .bold()
                    .font(.largeTitle)
                
            }
        }
    }
}

struct Welcome_Previews: PreviewProvider {
    static var previews: some View {
        Welcome()
    }
}
