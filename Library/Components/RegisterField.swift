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
    var body: some View {
        TextField(placeholder, text: textContent)
            .padding()
            .background(lightgrayField)
            .cornerRadius(10)
            .padding(paddingDirection, CGFloat(paddingValue))
            .foregroundColor(lightgrayEditItem)
    }
}

struct RegisterField_Previews: PreviewProvider {
    static var previews: some View {
        RegisterField(placeholder: "Mot de passe", textContent: .constant("mot de passe"), paddingDirection: .vertical, paddingValue: 10)
    }
}
