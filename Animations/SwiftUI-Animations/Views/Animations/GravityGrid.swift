//
//  GeneralRelativity.swift
//  SwiftUI-Animations
//
//  Created by codeAlligator on 19/01/26.
//
import SwiftUI

struct GravityGrid: View {

    // MARK: - Grid config
    private let spacing: CGFloat = 24
    private let pointSize: CGFloat = 3

    // MARK: - Gravity config
    private let gravityStrength: CGFloat = 90
    private let gravityRadius: CGFloat = 220

    // MARK: - Interaction state
    @State private var touchLocation: CGPoint? = nil

    var body: some View {
        GeometryReader { geo in
            Canvas { context, size in

                let cols = Int(size.width / spacing)
                let rows = Int(size.height / spacing)

                for row in 0...rows {
                    for col in 0...cols {

                        let original = CGPoint(
                            x: CGFloat(col) * spacing,
                            y: CGFloat(row) * spacing
                        )

                        let point = deform(point: original)

                        let rect = CGRect(
                            x: point.x - pointSize / 2,
                            y: point.y - pointSize / 2,
                            width: pointSize,
                            height: pointSize
                        )

                        context.fill(
                            Path(ellipseIn: rect),
                            with: .color(.white.opacity(0.9))
                        )
                    }
                }
            }
            .background(Color.black)
            .gesture(gravityGesture)
            .animation(
                .spring(response: 0.45, dampingFraction: 0.75),
                value: touchLocation
            )
        }
        .ignoresSafeArea()
    }

    // MARK: - Gravity deformation
    private func deform(point: CGPoint) -> CGPoint {
        guard let touch = touchLocation else {
            return point
        }

        let dx = point.x - touch.x
        let dy = point.y - touch.y
        let distance = max(1, sqrt(dx * dx + dy * dy))

        let force = gravityStrength * exp(-distance / gravityRadius)

        return CGPoint(
            x: point.x - dx / distance * force,
            y: point.y - dy / distance * force
        )
    }

    // MARK: - Gesture
    private var gravityGesture: some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged { value in
                touchLocation = value.location
            }
            .onEnded { _ in
                touchLocation = nil
            }
    }
}
