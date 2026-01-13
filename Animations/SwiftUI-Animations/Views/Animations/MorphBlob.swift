//
//  MorphBlob.swift
//  SwiftUI-Animations
//
//  Created by codeAlligator on 13/01/26.
//

import SwiftUI

struct MorphBlob: View {
    @State private var timePhase: CGFloat = 0

    // Easy to experiment
    private let steps = 180
    private let baseRadiusRatio: CGFloat = 0.35
    private let primaryAmplitude: CGFloat = 20
    private let secondaryAmplitude: CGFloat = 15
    private let primaryFrequency: CGFloat = 3
    private let secondaryFrequency: CGFloat = 5
    private let timeScale: CGFloat = 1.2

    var body: some View {
        Canvas { ctx, size in
            let center = CGPoint(x: size.width / 2, y: size.height / 2)
            let radius = min(size.width, size.height) * baseRadiusRatio

            var points: [CGPoint] = []
            points.reserveCapacity(steps)

            // Generate blob points
            for i in 0..<steps {
                let angle = CGFloat(i) / CGFloat(steps) * .pi * 2

                let distortion =
                    sin(angle * primaryFrequency + timePhase) * primaryAmplitude +
                    cos(angle * secondaryFrequency - timePhase) * secondaryAmplitude

                let r = radius + distortion

                points.append(
                    CGPoint(
                        x: center.x + r * cos(angle),
                        y: center.y + r * sin(angle)
                    )
                )
            }

            // Build smooth curved path
            var path = Path()
            path.move(to: points[0])

            for i in 1..<points.count {
                let prev = points[i - 1]
                let curr = points[i]
                let mid = CGPoint(
                    x: (prev.x + curr.x) / 2,
                    y: (prev.y + curr.y) / 2
                )
                path.addQuadCurve(to: mid, control: prev)
            }

            path.closeSubpath()

            // Fill
            ctx.fill(
                path,
                with: .linearGradient(
                    Gradient(colors: [.pink, .orange, .purple]),
                    startPoint: .zero,
                    endPoint: CGPoint(x: size.width, y: size.height)
                )
            )

            // Subtle edge for depth
            ctx.stroke(
                path,
                with: .color(.white.opacity(0.15)),
                lineWidth: 1
            )
        }
        .ignoresSafeArea()
        .task {
            var lastTime = CACurrentMediaTime()

            while !Task.isCancelled {
                let now = CACurrentMediaTime()
                let delta = now - lastTime
                lastTime = now

                timePhase += CGFloat(delta) * timeScale
                try? await Task.sleep(nanoseconds: 16_000_000)
            }
        }
    }
}

