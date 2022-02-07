//
//  EntryField.swift
//  Library
//
//  Created by LUKA Vouillemont on 07/02/2022.
//

import SwiftUI

struct EntryField: View {
    var placeholder: String
    var label: String
    var textContent: Binding<String>
    var paddingValue: CGFloat
    var isSecure: Bool
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(label)
                .fontWeight(.bold)
                .foregroundColor(.gray)
            if isSecure {
                SecureField(placeholder, text: textContent)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.darkSet)
                    .padding(.top, paddingValue)
            } else {
                TextField(placeholder, text: textContent)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.darkSet)
                    .padding(.top, paddingValue)
            }
            
            Divider()
        }
        .padding(.top, 20)
    }
}

struct EntryField_Previews: PreviewProvider {
    static var previews: some View {
        EntryField(
            placeholder: "john@doe.com",
            label: "Adresse mail",
            textContent: .constant("test"),
            paddingValue: 20,
            isSecure: false
        )
    }
}
