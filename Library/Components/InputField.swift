//
//  InputField.swift
//  Library
//
//  Created by LUKA Vouillemont on 19/01/2022.
//

import SwiftUI

struct InputField: View {
    var header: String
    var textContent: Binding<String>
    var body: some View {
        Section(header: Text(header)
                    .bold()
                    .font(.title)
                    .textCase(.none)
                    .foregroundColor(.black)) {
            TextField(header, text: textContent)
                .background(.white)
                .cornerRadius(10)
        }
    }
}

struct InputField_Previews: PreviewProvider {
    static var previews: some View {
        InputField(header: "Nom", textContent: .constant("test"))
    }
}
