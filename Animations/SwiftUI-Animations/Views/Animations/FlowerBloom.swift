//
//  FlowerBloom.swift
//  SwiftUI-Animations
//
//  Created by codeAlligator on 26/01/26.
//

import SwiftUI

struct FlowerBloom: View {

    // The moment the bloom begins
    @State private var startDate = Date()

    var body: some View {
        // TimelineView drives the animation by providing the current time
        TimelineView(.animation) { timeline in
            FlowerCanvas(date: timeline.date, startDate: startDate)
        }
        .frame(width: 360, height: 360)
        // Reset animation timing when view appears
        .onAppear {
            startDate = Date()
        }
    }
}

// MARK: - Canvas View
// Responsible for all drawing and animation math
struct FlowerCanvas: View {

    // Current animation time (from TimelineView)
    let date: Date

    // Time when bloom started
    let startDate: Date

    // MARK: Static Configuration
    // These never change, so they are shared across instances
    static let petalCount = 5
    static let bloomDuration: Double = 6.0

    // Colors defined in HSB space for smooth interpolation
    static let darkHSB: (CGFloat, CGFloat, CGFloat) = (0.07, 0.95, 0.55)
    static let lightOrangeHSB: (CGFloat, CGFloat, CGFloat) = (0.10, 0.85, 0.90)
    static let yellowHSB: (CGFloat, CGFloat, CGFloat) = (0.13, 0.90, 0.97)

    var body: some View {
        Canvas { ctx, size in

            // Time since animation started
            let elapsed = date.timeIntervalSince(startDate)

            // Normalize time into 0 -> 1 range for bloom progress
            let t = clamp(elapsed / Self.bloomDuration, 0, 1)

            // Ease the growth so it starts fast and slows naturally
            let growth = easeOutCubic(t)

            // Canvas center point
            let center = CGPoint(x: size.width / 2, y: size.height / 2)

            // Flower radius based on available space
            let radius = min(size.width, size.height) * 0.45

            // After blooming finishes, rotate slowly
            let rotation: Double = elapsed > Self.bloomDuration
                ? (elapsed - Self.bloomDuration) * 0.05
                : 0

            // Ensure minimum number of petals
            let effectivePetals = max(Self.petalCount, 3)

            // Angle between each petal
            let angleStep = (2 * .pi) / CGFloat(effectivePetals)

            // Density factor used to scale petal width
            let density = min(CGFloat(effectivePetals) / 8, 1)

            // Arc length each petal occupies
            let arcLength = radius * angleStep

            // MARK: Petal Geometry
            let length = radius * (0.75 + 0.25 * growth)
            let width  = arcLength * lerp(0.35, 0.65, density)
            let curl   = 0.35 + 0.4 * growth

            // Color transitions as the flower grows
            let color = bloomColor(growth: growth)

            // Draw each petal
            for i in 0..<effectivePetals {
                let angle = angleStep * CGFloat(i)

                ctx.drawLayer { layer in
                    // Move origin to center
                    layer.translateBy(x: center.x, y: center.y)

                    // Apply global rotation
                    layer.rotate(by: .radians(rotation))

                    // Rotate for individual petal placement
                    layer.rotate(by: .radians(Double(angle)))

                    // Create petal shape
                    let petal = petalPath(length: length, width: width, curl: curl)

                    // Fill petal with gradient (highlight -> base color)
                    layer.fill(petal,
                        with: .linearGradient(
                            Gradient(colors: [
                                Color.white.opacity(0.9),
                                color
                            ]),
                            startPoint: .zero,
                            endPoint: CGPoint(x: 0, y: -length)
                        )
                    )

                    // Outline for hand drawn feel
                    layer.stroke(petal, with: .color(Color.black.opacity(0.35)), lineWidth: max(1.2, width * 0.02))

                    // Inner vein line
                    let vein = petalVeinPath(length: length)
                    layer.stroke(vein, with: .color(Color.black.opacity(0.25)), lineWidth: 1)
                }
            }
        }
    }

    // MARK: - Bloom Color Logic
    // Transitions from dark -> orange -> yellow as bloom progresses
    func bloomColor(growth: CGFloat) -> Color {
        if growth < 0.5 {
            return interpolateHSB(from: Self.darkHSB, to: Self.lightOrangeHSB, t: growth * 2)
        } else {
            return interpolateHSB(from: Self.lightOrangeHSB, to: Self.yellowHSB, t: (growth - 0.5) * 2)
        }
    }
}

// MARK: - Petal Shape
// Creates a symmetrical curved petal using two quadratic curves
func petalPath(length: CGFloat, width: CGFloat, curl: CGFloat) -> Path {
    Path { path in
        path.move(to: .zero)

        let tip = CGPoint(x: 0, y: -length)

        path.addQuadCurve(to: tip,
            control: CGPoint(x: -width, y: -length * curl))

        path.addQuadCurve(to: .zero,
            control: CGPoint(x: width, y: -length * curl))
    }
}

// MARK: - Vein Path
// A slightly curved center line to mimic organic structure
func petalVeinPath(length: CGFloat) -> Path {
    Path { path in
        path.move(to: CGPoint(x: 0, y: -length * 0.15))
        path.addQuadCurve(to: CGPoint(x: 0, y: -length * 0.85),
            control: CGPoint(x: 3, y: -length * 0.45))
    }
}

// MARK: - Math Helpers
// Smooth easing function for natural growth
func easeOutCubic(_ x: Double) -> CGFloat {
    CGFloat(1 - pow(1 - x, 3))
}

// Linear interpolation
func lerp(_ a: CGFloat, _ b: CGFloat, _ t: CGFloat) -> CGFloat {
    a + (b - a) * t
}

// Clamp a value between two bounds
func clamp(_ x: Double, _ minVal: Double, _ maxVal: Double) -> Double {
    min(max(x, minVal), maxVal)
}

// Interpolate between two HSB colors
func interpolateHSB(from: (CGFloat, CGFloat, CGFloat), to: (CGFloat, CGFloat, CGFloat), t: CGFloat) -> Color {
    Color(hue: lerp(from.0, to.0, t), saturation: lerp(from.1, to.1, t), brightness: lerp(from.2, to.2, t))
}
