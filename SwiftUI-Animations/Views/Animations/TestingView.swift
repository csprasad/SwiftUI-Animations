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
            ZStack {
                ForEach(0..<8) { index in
                    Path { path in
                        let angle = Double(index) * .pi / 4
                        let radius = 50.0 // Adjust leg length
                        let startX = 50.0 * cos(angle)
                        let startY = 50.0 * sin(angle)
                        path.move(to: CGPoint(x: startX, y: startY))
                        path.addLine(to: CGPoint(x: startX + radius * cos(angle), y: startY + radius * sin(angle)))
                    }
                    .stroke(.black, lineWidth: 2)
                }
            }
        }
    }
}



struct TestingView_Previews: PreviewProvider {
    static var previews: some View {
        TestingView()
    }
}
