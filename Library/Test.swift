//
//  Test.swift
//  Library
//
//  Created by LUKA Vouillemont on 11/02/2022.
//

import SwiftUI

struct Test: View {
    @State private var shouldAnimate = false
    @State private var displayLoading = false
    
    var body: some View {
        VStack {
            Button {
                self.displayLoading.toggle()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                    self.shouldAnimate.toggle()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.displayLoading.toggle()
                    self.shouldAnimate.toggle()
                }
            } label: {
                if displayLoading {
                    HStack {
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 20, height: 20)
                            .scaleEffect(shouldAnimate ? 1.0 : 0.5)
                            .animation(Animation.easeInOut(duration: 0.5).repeatForever(), value: shouldAnimate)
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 20, height: 20)
                            .scaleEffect(shouldAnimate ? 1.0 : 0.5)
                            .animation(Animation.easeInOut(duration: 0.5).repeatForever().delay(0.3), value: shouldAnimate)
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 20, height: 20)
                            .scaleEffect(shouldAnimate ? 1.0 : 0.5)
                            .animation(Animation.easeInOut(duration: 0.5).repeatForever().delay(0.6), value: shouldAnimate)
                    }
                } else {
                    Text("Animate")
                }
            }
            .disabled(shouldAnimate)
        }
    }
}

struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Test()
    }
}
