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
            KakashiShape()
                .stroke(style: StrokeStyle(lineWidth: 1.5, lineCap: .round, lineJoin: .round))
                .foregroundColor(.primary.opacity(0.3))
            
            // Animated Drawing Shape
            KakashiShape()
                .trim(from: strokeStart, to: strokeEnd)
                .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
                .foregroundColor(.primary)
                .animation(
                    .linear(duration: 3.0).repeatForever(autoreverses: false),
                    value: isAnimating
                )
        }
        .padding(.top, 80)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                isAnimating = true
                strokeEnd = 1.0
                strokeStart = 0.7
            }
        }
    }
}

#Preview {
    KakashiView()
}
