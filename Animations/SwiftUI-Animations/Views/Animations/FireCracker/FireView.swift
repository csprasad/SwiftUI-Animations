//
//  FireView.swift
//  SwiftUI-Animations
//
//  Created by codeAlligator on 30/01/26.
//

import SwiftUI

struct FireView: View {
    @State private var flicker = false

    var body: some View {
        FireShape()
            .fill(
                LinearGradient(
                    colors: [.yellow, .orange, .red],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .frame(width: 30, height: 50)
            .scaleEffect(flicker ? 1.1 : 0.95)
            .shadow(color: .orange, radius: 12)
            .onAppear {
                withAnimation(
                    .easeInOut(duration: 0.15)
                        .repeatForever(autoreverses: true)
                ) {
                    flicker.toggle()
                }
            }
    }
}

struct FireShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addQuadCurve(
            to: CGPoint(x: rect.minX, y: rect.midY),
            control: CGPoint(x: rect.midX - 10, y: rect.midY + 10)
        )
        path.addQuadCurve(
            to: CGPoint(x: rect.midX, y: rect.minY),
            control: CGPoint(x: rect.minX + 5, y: rect.minY)
        )
        path.addQuadCurve(
            to: CGPoint(x: rect.maxX, y: rect.midY),
            control: CGPoint(x: rect.maxX - 5, y: rect.minY)
        )
        path.addQuadCurve(
            to: CGPoint(x: rect.midX, y: rect.maxY),
            control: CGPoint(x: rect.midX + 10, y: rect.midY + 10)
        )
        return path
    }
}

