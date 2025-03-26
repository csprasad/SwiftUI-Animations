//
//  RandomAnimationView.swift
//  Gradient
//
//  Created by CSPrasad on 25/06/23.
//

import SwiftUI

struct RandomAnimationView: View {
    @State private var bubbleFloating = false
    @State private var stoveMoving = false
    @State private var leftVaporizes = false
    @State private var middleVaporizes = false
    @State private var rightVaporizes = false
    
    var body: some View {
        ZStack {
            // Background
            LinearGradient(gradient: Gradient(colors: [Color.white, Color.gray.opacity(0.2), Color.gray.opacity(0.5)]),
                           startPoint: .top,
                           endPoint: .bottom)
                .ignoresSafeArea()
            
            // Vapor Animations
            VaporView(imageName: "vapor_middle", delay: 0.2, isAnimating: $middleVaporizes)
                .offset(x: 60, y: -65)
            VaporView(imageName: "vapor_right", delay: 0.0, isAnimating: $rightVaporizes)
                .offset(x: 60, y: -65)
            
            // Pot & Stove
            VStack {
                PotView(isMoving: $stoveMoving)
                Image("stove")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
            }
            .position(x: 200, y: 450)
            
            // Floating Bubbles
            if bubbleFloating {
                ForEach(0..<6, id: \.self) { _ in
                    BubbleView()
                }
            }
        }
        .onAppear {
            bubbleFloating = true
        }
    }
}

// MARK: - Vapor Animation
struct VaporView: View {
    let imageName: String
    let delay: Double
    @Binding var isAnimating: Bool

    var body: some View {
        Image(imageName)
            .blur(radius: 20)
            .blendMode(.plusDarker)
            .mask(Rectangle().offset(y: isAnimating ? 0 : 40)) // Alternative to clipShape
            .onAppear {
                withAnimation(Animation.timingCurve(0.68, -0.6, 0.32, 1.6)
                    .delay(delay)
                    .speed(0.8)
                    .repeatForever(autoreverses: false)) {
                    isAnimating = true
                }
            }
    }
}

// MARK: - Pot Animation
struct PotView: View {
    @Binding var isMoving: Bool

    var body: some View {
        Image("pot")
            .resizable()
            .scaledToFit()
            .frame(width: 100, height: 100)
            .rotationEffect(.degrees(isMoving ? 0 : -30))
            .onAppear {
                withAnimation(.interpolatingSpring(stiffness: 100, damping: 3).repeatForever(autoreverses: false)) {
                    isMoving = true
                }
            }
    }
}

// MARK: - Floating Bubble
struct BubbleView: View {
    @State private var position = CGPoint(x: 0, y: 0)

    var body: some View {
        Image("bubble")
            .resizable()
            .scaledToFit()
            .frame(width: 30, height: 30)
            .rotationEffect(.degrees(Double.random(in: -30...30)))
            .offset(x: position.x, y: position.y)
            .onAppear {
                let randomX = CGFloat.random(in: -50...100)
                let randomY = CGFloat.random(in: -200...0)
                withAnimation(Animation.linear(duration: Double.random(in: 5.0...10.0)).repeatForever(autoreverses: false)) {
                    position = CGPoint(x: randomX, y: randomY)
                }
            }
    }
}
