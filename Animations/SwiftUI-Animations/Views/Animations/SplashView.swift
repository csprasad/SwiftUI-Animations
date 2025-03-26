//
//  SplashView.swift
//  SwiftUI-Animations
//
//  Created by CS Prasad on 16/07/23.
//

import SwiftUI

struct SplashView: View {
    @State private var isActive = false
    @State private var lightScale: CGFloat = 0.45
    @State private var CircleBG: Color = .white // Currently unused

    var body: some View {
        ZStack {
            // Background Circles with Animation
            AnimatedCircles(lightScale: $lightScale)

            // Profile Image in the Center
            Circle()
                .frame(width: 150, height: 150)
                .foregroundColor(.black.opacity(0.4))
                .shadow(color: .white, radius: 5)
                .overlay {
                    Image("Profile")
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                }

            // Username Text
            Text("@CSPrasad_iOS")
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(Color.black.opacity(0.2))
                .cornerRadius(10)
                .offset(y: 250)
                .foregroundColor(.black)
                .font(.system(size: 25, weight: .bold, design: .monospaced))
                .opacity(0.5)
        }
    }
}

// MARK: - Extracted Animated Circles Component
struct AnimatedCircles: View {
    @Binding var lightScale: CGFloat

    let colors: [String] = ["#D2CED2", "#A4A0A4", "#797579", "#504C50"]
    
    var body: some View {
        ZStack {
            ForEach(0..<colors.count, id: \.self) { index in
                Circle()
                    .frame(width: CGFloat(350 - (index * 50)), height: CGFloat(350 - (index * 50)))
                    .foregroundColor(Color(hex: colors[index]))
                    .shadow(color: .white, radius: 8)
                    .scaleEffect(lightScale)
            }
        }
        .onAppear {
            withAnimation(.spring(response: 0.9, dampingFraction: 1, blendDuration: 1).repeatForever(autoreverses: true)) {
                lightScale = 1
            }
        }
    }
}
