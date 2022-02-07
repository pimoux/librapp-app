//
//  CircleItem.swift
//  Library
//
//  Created by LUKA Vouillemont on 07/02/2022.
//

import SwiftUI

struct CircleItem: View {
    var color: Color
    var x: CGFloat
    var y: CGFloat
    
    var body: some View {
        Circle()
            .fill(color)
            .offset(x: x, y: y)
    }
}

struct CircleItem_Previews: PreviewProvider {
    static var previews: some View {
        CircleItem(
            color: .turquoiseSet,
            x: 200 / 2,
            y: 200 / 1.3
        )
    }
}
