//
//  Playground-TestFile.swift
//  SwiftUI-Animations
//
//  Created by CS Prasad on 31/07/23.
//

import SwiftUI

struct Playground_TestFile: View {
    @State private var isFanRotating = false
    @State private var rotationAngle: Double = 0.0

    var body: some View {
        VStack {
            Image(systemName: "calender.fill").renderingMode(.template)
                .resizable()
                .frame(width: 150, height: 150)
                .foregroundColor(.white)
//                .background(.red)
                .rotationEffect(.degrees(rotationAngle))
                .animation(.default)
            Button(action: {
                isFanRotating.toggle()
                rotateFan()
            }) {
                Text(isFanRotating ? "Stop Rotation" : "Start Rotation")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
    }

    private func rotateFan() {
        if isFanRotating {
            withAnimation(Animation.linear(duration: 2.0).repeatForever(autoreverses: false)) {
                rotationAngle += 360
            }
        } else {
            rotationAngle = 0.0
        }
    }
}

struct Playground_TestFile_Previews: PreviewProvider {
    static var previews: some View {
        Playground_TestFile()
    }
}
