//
//  Test.swift
//  Library
//
//  Created by LUKA Vouillemont on 11/02/2022.
//

import SwiftUI

struct Test: View {
    @State private var triggerAnimation: Bool = false
    @State private var isAnimated: Bool = false
    @State private var isAnimated2: Bool = false
    @State private var isAnimated3: Bool = false
    var body: some View {
        VStack {
            Button {
                triggerAnimation.toggle()
                withAnimation(.easeInOut(duration: 0.5).repeatForever(autoreverses: true)) {
                    isAnimated.toggle()
                }
                withAnimation(.easeInOut(duration: 0.5).repeatForever(autoreverses: true).delay(0.3)) {
                    isAnimated2.toggle()
                }
                withAnimation(.easeInOut(duration: 0.5).repeatForever(autoreverses: true).delay(0.6)) {
                    isAnimated3.toggle()
                }
            } label: {
                Text("Button")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.darkBlueSet)
                    .padding()
            }
            if triggerAnimation {
                HStack {
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 20, height: 20)
                        .scaleEffect(isAnimated ? 4.0 : 2.0)
                        .animation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true), value: 0)
                    Spacer()
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 20, height: 20)
                        .scaleEffect(isAnimated2 ? 4.0 : 2.0)
                    Spacer()
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 20, height: 20)
                        .scaleEffect(isAnimated3 ? 4.0 : 2.0)
                }
            }
        }
    }
}

struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Test()
    }
}
