//
//
//  MeshGradientBackground.swift
//  SwiftUI-Animations
//
/// Created by `C S Prasad` on `27/03/26`
///
/// ### Social
/// `Instagram` : ``@csprasad.ios`` • `X` : ``@csprasad_ios`` • `Github` : ``@csprasad``
///

import SwiftUI

// MARK: - Interactive Mesh Background
struct MeshGradientBackground: View {
    @State private var appear = false
    
    var body: some View {
        ZStack {
            Color(.systemBackground)
            
            Circle()
                .fill(Color.purple.opacity(0.2))
                .blur(radius: 100)
                .offset(x: appear ? -100 : 100, y: appear ? -200 : 200)
            
            Circle()
                .fill(Color.blue.opacity(0.15))
                .blur(radius: 100)
                .offset(x: appear ? 150 : -150, y: appear ? 100 : -100)
        }
        .animation(
            .linear(duration: 10).repeatForever(autoreverses: true),
            value: appear
        )
        .onAppear {
            appear = true
        }
    }
}
