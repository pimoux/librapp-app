//
//  LoadingCircles.swift
//  Library
//
//  Created by LUKA Vouillemont on 13/02/2022.
//

import SwiftUI

struct LoadingCircles: View {
    var shouldAnimate: Bool
    var body: some View {
        HStack {
            Circle()
                .fill(Color.blue)
                .frame(width: 20, height: 20)
                .scaleEffect(shouldAnimate ? 1.0 : 0.5)
                .animation(shouldAnimate ?
                           Animation
                            .easeInOut(duration: 0.5)
                            .repeatForever():
                            Animation.default,
                           value: shouldAnimate
                )
            Circle()
                .fill(Color.blue)
                .frame(width: 20, height: 20)
                .scaleEffect(shouldAnimate ? 1.0 : 0.5)
                .animation(shouldAnimate ?
                           Animation
                            .easeInOut(duration: 0.5)
                            .repeatForever()
                            .delay(0.3):
                            Animation.default,
                           value: shouldAnimate
                )
            Circle()
                .fill(Color.blue)
                .frame(width: 20, height: 20)
                .scaleEffect(shouldAnimate ? 1.0 : 0.5)
                .animation(shouldAnimate ?
                           Animation
                            .easeInOut(duration: 0.5)
                            .repeatForever()
                            .delay(0.6):
                            Animation.default,
                           value: shouldAnimate
                )
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

struct LoadingCircles_Previews: PreviewProvider {
    static var previews: some View {
        LoadingCircles(shouldAnimate: false)
    }
}
