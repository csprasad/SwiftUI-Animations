//
//  SplashView.swift
//  SwiftUI-Animations
//
/// Created by `C S Prasad` on `16/07/23`
///
/// ### Social
/// `Instagram` : ``@csprasad.ios`` • `X` : ``@csprasad_ios`` • `Github` : ``@csprasad``
///

import SwiftUI

struct SplashView: View {
    @State private var lightScale: CGFloat = 0.45
    
    var body: some View {
        VStack {
            Spacer()
            
            ZStack {
                // Animated Background
                AnimatedCircles(lightScale: $lightScale)
                
                // Static Overlay (Profile)
                Circle()
                    .frame(width: 150, height: 150)
                    .foregroundColor(.black.opacity(0.4))
                    .shadow(color: .white.opacity(0.5), radius: 10)
                    .overlay {
                        Image("Profile")
                            .resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                    }
            }
            .frame(height: 350)
            .drawingGroup()
            
            
            
            // Username
            Text("@CSPrasad_iOS")
                .font(.system(size: 20, weight: .bold, design: .monospaced))
                .foregroundColor(.primary)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(.ultraThinMaterial)
                .cornerRadius(15)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.primary.opacity(0.1), lineWidth: 1)
                )
                .padding(.bottom, 50)
            Spacer()
        }
        .ignoresSafeArea(.all, edges: .bottom)
    }
}

// MARK: - Isolated Component
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
        .animation(
            .spring(response: 0.9, dampingFraction: 1, blendDuration: 1)
            .repeatForever(autoreverses: true),
            value: lightScale
        )
        .onAppear {
            lightScale = 1
        }
    }
}
