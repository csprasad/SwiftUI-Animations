//
//  FusePath.swift
//  SwiftUI-Animations
//
//  Created by codeAlligator on 30/01/26.
//

import SwiftUI

struct FusePath {
    let path: Path
    let points: [CGPoint]

    static func make() -> FusePath {
        let start = CGPoint(x: 200, y: 80)
        let end = CGPoint(x: 200, y: 500)

        let segments = 90
        var points: [CGPoint] = []

        // Small horizontal drift accumulator (very important)
        var drift: CGFloat = 0

        for i in 0...segments {
            let t = CGFloat(i) / CGFloat(segments)

            // Vertical position (mostly straight)
            let y = start.y + (end.y - start.y) * t

            // Very subtle organic drift
            drift += CGFloat.random(in: -1.2...1.2)
            drift = drift.clamped(to: -8...8)

            let x = start.x + drift
            points.append(CGPoint(x: x, y: y))
        }

        var path = Path()
        path.move(to: points.first!)

        // Smooth interpolation — no sharp bends
        for i in 1..<points.count {
            let prev = points[i - 1]
            let curr = points[i]

            let control = CGPoint(
                x: (prev.x + curr.x) / 2,
                y: (prev.y + curr.y) / 2
            )

            path.addQuadCurve(to: curr, control: control)
        }

        return FusePath(path: path, points: points)
    }
}

extension Comparable {
    func clamped(to limits: ClosedRange<Self>) -> Self {
        min(max(self, limits.lowerBound), limits.upperBound)
    }
}
