//
//  KakashiView.swift
//  SwiftUI-Animations
//
/// Created by `C S Prasad` on `15/07/23`
///
/// ### Social
/// `Instagram` : ``@csprasad.ios`` • `X` : ``@csprasad_ios`` • `Github` : ``@csprasad``
///

import SwiftUI

struct KakashiView: View {
    @State private var strokeStart: CGFloat = 0
    @State private var strokeEnd: CGFloat = 0
    @State private var isAnimating: Bool = false
    
    var body: some View {
        ZStack {
            MeshGradientBackground()
                .ignoresSafeArea()
            
            KakashiShape()
                .stroke(style: StrokeStyle(lineWidth: 1, lineCap: .round, lineJoin: .round))
                .foregroundColor(.primary)
                .opacity(0.3)
            
            // Animated Drawing Path
            KakashiShape()
                .trim(from: strokeStart, to: strokeEnd)
                .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
                .foregroundColor(.primary)
                .animation(
                    .easeInOut(duration: 2.5)
                    .repeatForever(autoreverses: true),
                    value: isAnimating
                )
        }
        .onAppear {
            isAnimating = true
            strokeEnd = 1.0
        }
        .padding(.top, 80)
    }
}

#Preview {
    KakashiView()
}
