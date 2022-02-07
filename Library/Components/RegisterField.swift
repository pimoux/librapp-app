//
//  RegisterField.swift
//  Library
//
//  Created by LUKA Vouillemont on 01/02/2022.
//

import SwiftUI

struct RegisterField: View {
    var placeholder: String
    var textContent: Binding<String>
    var paddingDirection: Edge.Set
    var paddingValue: Int
    var isSecure: Bool
    var body: some View {
        if isSecure {
            SecureField(placeholder, text: textContent)
                .padding()
                .background(Color.lightgrayFieldSet)
                .cornerRadius(10)
                .padding(paddingDirection, CGFloat(paddingValue))
                .foregroundColor(.lightgrayEditItemSet)
        } else {
            TextField(placeholder, text: textContent)
                .padding()
                .background(Color.lightgrayFieldSet)
                .cornerRadius(10)
                .padding(paddingDirection, CGFloat(paddingValue))
                .foregroundColor(.lightgrayEditItemSet)
        }
    }
}

struct RegisterField_Previews: PreviewProvider {
    static var previews: some View {
        RegisterField(
            placeholder: "Mot de passe",
            textContent: .constant("mot de passe"),
            paddingDirection: .vertical,
            paddingValue: 10,
            isSecure: false
        )
    }
}
