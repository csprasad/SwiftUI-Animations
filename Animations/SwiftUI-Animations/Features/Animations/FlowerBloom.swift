//
//  FlowerBloom.swift
//  SwiftUI-Animations
//
/// Created by `C S Prasad` on `26/01/26`
///
/// ### Social
/// `Instagram` : ``@csprasad.ios`` • `X` : ``@csprasad_ios`` • `Github` : ``@csprasad``
///

import SwiftUI

struct FlowerBloom: View {
    @State private var startDate = Date()

    var body: some View {
        TimelineView(.animation) { timeline in
            FlowerCanvas(date: timeline.date, startDate: startDate)
        }
        .frame(width: 360, height: 360, alignment: .center)
        .onAppear {
            startDate = Date()
        }
    }
}

struct FlowerCanvas: View {
    let date: Date
    let startDate: Date

    static let petalCount = 5
    static let bloomDuration: Double = 6.0

    // HSB space for smooth interpolation
    static let darkHSB: (CGFloat, CGFloat, CGFloat) = (0.07, 0.95, 0.55)
    static let lightOrangeHSB: (CGFloat, CGFloat, CGFloat) = (0.10, 0.85, 0.90)
    static let yellowHSB: (CGFloat, CGFloat, CGFloat) = (0.13, 0.90, 0.97)

    var body: some View {
        Canvas { ctx, size in
            let elapsed = date.timeIntervalSince(startDate)
            let t = clamp(elapsed / Self.bloomDuration, 0, 1)
            let growth = easeOutCubic(t)

            let center = CGPoint(x: size.width / 2, y: size.height / 2)
            let radius = min(size.width, size.height) * 0.45

            // Rotate slowly after bloom completes
            let rotation: Double = elapsed > Self.bloomDuration
                ? (elapsed - Self.bloomDuration) * 0.05
                : 0

            let effectivePetals = max(Self.petalCount, 3)
            let angleStep = (2 * .pi) / CGFloat(effectivePetals)
            let density = min(CGFloat(effectivePetals) / 8, 1)
            let arcLength = radius * angleStep

            let length = radius * (0.75 + 0.25 * growth)
            let width  = arcLength * lerp(0.35, 0.65, density)
            let curl   = 0.35 + 0.4 * growth
            let color  = bloomColor(growth: growth)

            for i in 0..<effectivePetals {
                let angle = angleStep * CGFloat(i)

                ctx.drawLayer { layer in
                    layer.translateBy(x: center.x, y: center.y)
                    layer.rotate(by: .radians(rotation))
                    layer.rotate(by: .radians(Double(angle)))

                    let petal = petalPath(length: length, width: width, curl: curl)

                    layer.fill(petal,
                        with: .linearGradient(
                            Gradient(colors: [Color.white.opacity(0.9), color]),
                            startPoint: .zero,
                            endPoint: CGPoint(x: 0, y: -length)
                        )
                    )

                    layer.stroke(petal, with: .color(Color.black.opacity(0.35)), lineWidth: max(1.2, width * 0.02))

                    let vein = petalVeinPath(length: length)
                    layer.stroke(vein, with: .color(Color.black.opacity(0.25)), lineWidth: 1)
                }
            }
        }
    }

    // Transitions dark -> orange -> yellow as bloom progresses
    func bloomColor(growth: CGFloat) -> Color {
        if growth < 0.5 {
            return interpolateHSB(from: Self.darkHSB, to: Self.lightOrangeHSB, t: growth * 2)
        } else {
            return interpolateHSB(from: Self.lightOrangeHSB, to: Self.yellowHSB, t: (growth - 0.5) * 2)
        }
    }
}

// Symmetrical curved petal using two quadratic curves
func petalPath(length: CGFloat, width: CGFloat, curl: CGFloat) -> Path {
    Path { path in
        path.move(to: .zero)
        let tip = CGPoint(x: 0, y: -length)
        path.addQuadCurve(to: tip, control: CGPoint(x: -width, y: -length * curl))
        path.addQuadCurve(to: .zero, control: CGPoint(x: width, y: -length * curl))
    }
}

func petalVeinPath(length: CGFloat) -> Path {
    Path { path in
        path.move(to: CGPoint(x: 0, y: -length * 0.15))
        path.addQuadCurve(to: CGPoint(x: 0, y: -length * 0.85),
            control: CGPoint(x: 3, y: -length * 0.45))
    }
}

func easeOutCubic(_ x: Double) -> CGFloat {
    CGFloat(1 - pow(1 - x, 3))
}

func lerp(_ a: CGFloat, _ b: CGFloat, _ t: CGFloat) -> CGFloat {
    a + (b - a) * t
}

func clamp(_ x: Double, _ minVal: Double, _ maxVal: Double) -> Double {
    min(max(x, minVal), maxVal)
}

func interpolateHSB(from: (CGFloat, CGFloat, CGFloat), to: (CGFloat, CGFloat, CGFloat), t: CGFloat) -> Color {
    Color(hue: lerp(from.0, to.0, t), saturation: lerp(from.1, to.1, t), brightness: lerp(from.2, to.2, t))
}
