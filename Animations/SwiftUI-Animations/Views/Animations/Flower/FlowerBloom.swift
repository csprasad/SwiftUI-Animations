//
//  FlowerBloom.swift
//  SwiftUI-Animations
//
//  Created by codeAlligator on 26/01/26.
//

import SwiftUI

struct FlowerBloom: View {
    @State private var startDate = Date()

    var body: some View {
        TimelineView(.animation) { timeline in
            AnyView(
                FlowerCanvas(
                    date: timeline.date,
                    startDate: startDate
                )
            )
        }
        .frame(width: 360, height: 360)
        .background(Color.black)
        .onAppear {
            startDate = Date()
        }
    }
}


// MARK: - Canvas View
struct FlowerCanvas: View {
    let date: Date
    let startDate: Date

    let petalCount: Int = 10

    let bloomDuration: Double = 5.0

    // colors (HSB)
    let darkHSB: (CGFloat, CGFloat, CGFloat) = (0.07, 0.95, 0.55)
    let lightOrangeHSB: (CGFloat, CGFloat, CGFloat) = (0.10, 0.85, 0.90)
    let yellowHSB: (CGFloat, CGFloat, CGFloat) = (0.13, 0.90, 0.97)

    var body: some View {
        Canvas { ctx, size in
            let elapsed = date.timeIntervalSince(startDate)
            let t = min(max(elapsed / bloomDuration, 0), 1)
            let growth = easeOutCubic(t)

            let center = CGPoint(x: size.width / 2, y: size.height / 2)
            let radius = min(size.width, size.height) * 0.45

            // rotation after bloom
            let rotation = t >= 1
                ? (elapsed - bloomDuration) * 0.05
                : 0

            // symmetry rules
            let effectivePetals = max(petalCount, 3)
            let angleStep = (2 * .pi) / CGFloat(effectivePetals)

            // density based sizing
            let densityFactor = min(CGFloat(effectivePetals) / 8, 1)
            let arcLength = radius * angleStep

            let length = radius * (0.75 + 0.25 * growth)
            let width  = arcLength * lerp(0.35, 0.65, densityFactor)
            let curl   = 0.35 + 0.4 * growth

            // color interpolation
            let color: Color = {
                if growth < 0.5 {
                    return interpolateHSB(
                        from: darkHSB,
                        to: lightOrangeHSB,
                        t: growth * 2
                    )
                } else {
                    return interpolateHSB(
                        from: lightOrangeHSB,
                        to: yellowHSB,
                        t: (growth - 0.5) * 2
                    )
                }
            }()

            for i in 0..<effectivePetals {
                let angle = angleStep * CGFloat(i)

                ctx.drawLayer { layer in
                    layer.translateBy(x: center.x, y: center.y)
                    layer.rotate(by: .radians(Double(rotation)))
                    layer.rotate(by: .radians(Double(angle)))

                    let path = petalPath(
                        length: length,
                        width: width,
                        curl: curl
                    )

                    layer.fill(
                        path,
                        with: .linearGradient(
                            Gradient(colors: [
                                Color.white.opacity(0.9),
                                color
                            ]),
                            startPoint: .zero,
                            endPoint: CGPoint(x: 0, y: -length)
                        )
                    )
                }
            }
        }
    }
}

// MARK: - Math Helpers
func easeOutCubic(_ x: Double) -> CGFloat {
    CGFloat(1 - pow(1 - x, 3))
}

func lerp(_ a: CGFloat, _ b: CGFloat, _ t: CGFloat) -> CGFloat {
    a + (b - a) * t
}

func interpolateHSB(from: (CGFloat, CGFloat, CGFloat), to: (CGFloat, CGFloat, CGFloat), t: CGFloat) -> Color {
    Color(hue: lerp(from.0, to.0, t),
          saturation: lerp(from.1, to.1, t),
          brightness: lerp(from.2, to.2, t))
}

// MARK: - Petal Shape
func petalPath(length: CGFloat, width: CGFloat, curl: CGFloat) -> Path {
    Path { p in
        p.move(to: .zero)

        let tip = CGPoint(x: 0, y: -length)

        p.addQuadCurve(
            to: tip,
            control: CGPoint(
                x: -width,
                y: -length * curl
            )
        )

        p.addQuadCurve(
            to: .zero,
            control: CGPoint(
                x: width,
                y: -length * curl
            )
        )
    }
}
