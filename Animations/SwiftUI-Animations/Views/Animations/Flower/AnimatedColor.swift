//
//  AnimatedColor.swift
//  SwiftUI-Animations
//
//  Created by codeAlligator on 26/01/26.
//

import SwiftUI

struct AnimatedColor: AnimatableModifier {
    var progress: CGFloat

    var animatableData: CGFloat {
        get { progress }
        set { progress = newValue }
    }

    func body(content: Content) -> some View {
        content.foregroundStyle(
            LinearGradient(
                colors: [.purple, .pink, .orange],
                startPoint: .top,
                endPoint: .bottom
            )
        )
    }
}

