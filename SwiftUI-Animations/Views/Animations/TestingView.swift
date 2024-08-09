//
//  TestingView.swift
//  SwiftUI-Animations
//
//  Created by CS Prasad on 08/08/24.
//

import SwiftUI

struct TestingView: View {
    @State private var tentacleAngle: Double = 0.0

    var body: some View {
        ZStack {
            Circle()
                .fill(.blue)
                .frame(width: 100, height: 100)
            
            GeometryReader { geometry in
                SpiderView()
                    .position(x: geometry.size.width / 2 + 48, y: geometry.size.height / 2 + 65)
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}

struct SpiderView: View {
    var body: some View {
        ZStack {
            ForEach(0..<8) { index in
                Path { path in
                    let angle = Double(index) * .pi / 7
                    let radius = 70.0 // Adjust leg length
                    let startX = 50.0 * cos(angle)
                    let startY = 50.0 * sin(angle)
                    path.move(to: CGPoint(x: startX, y: startY))
                    path.addLine(to: CGPoint(x: startX + radius * cos(angle), y: startY + radius * sin(angle)))
                }
                .stroke(.black, lineWidth: 2)
            }
        }
        .frame(width: 100, height: 100) // Adjust the frame size as needed
        .animation(
            .linear(duration: 5)
            .repeatForever(autoreverses: true), value: true)
    }
}




struct TestingView_Previews: PreviewProvider {
    static var previews: some View {
        TestingView()
    }
}
