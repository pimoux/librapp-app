//
//  SubmitButton.swift
//  Library
//
//  Created by LUKA Vouillemont on 01/02/2022.
//

import SwiftUI

func doSomething() {
    print("salut")
}

struct SubmitButton: View {
    var callback: ()
    var label: String
    
    var body: some View {
        Button {
            callback
        } label: {
            Text(label)
                .bold()
                .font(.title3)
                .frame(maxWidth: .infinity)
                .padding(.vertical)
                .background(Color("darkBlue"))
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }
}

struct SubmitButton_Previews: PreviewProvider {
    static var previews: some View {
        SubmitButton(callback: doSomething(), label: "Ajouter")
    }
}
