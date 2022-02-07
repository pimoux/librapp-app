//
//  DataRow.swift
//  Library
//
//  Created by LUKA Vouillemont on 07/02/2022.
//

import SwiftUI

struct DataRow: View {
    var label: String
    var data: String
    var body: some View {
        HStack {
            Text(label)
            Spacer()
            Text(data)
        }
    }
}

struct DataRow_Previews: PreviewProvider {
    static var previews: some View {
        DataRow(label: "ID", data: String(18))
    }
}
