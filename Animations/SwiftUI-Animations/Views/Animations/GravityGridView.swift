//
//  GeneralRelativity.swift
//  SwiftUI-Animations
//
//  Created by codeAlligator on 19/01/26.
//

import SwiftUI

struct GravityGridView: View {

    // MARK: - Grid
    private let spacing: CGFloat = 24
    private let pointSize: CGFloat = 3
    private let overscan: CGFloat = 200

    // MARK: - Gravity
    private let gravityStrength: CGFloat = 190
    private let gravityRadius: CGFloat = 120

    // MARK: - Black Hole
    private let eventHorizonRadius: CGFloat = 22
    private let accretionDiskRadius: CGFloat = 90
    private let swirlStrength: CGFloat = 28

    // MARK: - Gravitational Waves
    private let waveAmplitude: CGFloat = 12
    private let waveLength: CGFloat = 40
    private let waveDecay: CGFloat = 300
    private let waveSpeed: CGFloat = 3

    // MARK: - Interaction State
    @State private var touchLocation: CGPoint? = nil
    @State private var waveOrigin: CGPoint? = nil
    @State private var waveTime: CGFloat = 0
    @State private var isWaveActive = false
    
    // MARK: - Animation
    @State private var spin: CGFloat = 0

    // MARK: - Timer
    private let timer = Timer.publish(every: 1.0 / 60.0, on: .main, in: .common).autoconnect()

    var body: some View {
        Canvas { context, size in
            let cols = Int((size.width + overscan * 2) / spacing)
            let rows = Int((size.height + overscan * 2) / spacing)

            // ---- Spacetime grid points ----
            for row in 0..<rows {
                for col in 0..<cols {
                    
                    let original = CGPoint(
                        x: CGFloat(col) * spacing - overscan,
                        y: CGFloat(row) * spacing - overscan
                    )

                    let point = deform(point: original)

                    let rect = CGRect(
                        x: point.x - pointSize / 2,
                        y: point.y - pointSize / 2,
                        width: pointSize,
                        height: pointSize
                    )

                    context.fill(Path(ellipseIn: rect), with: .color(.white.opacity(0.9)))
                }
            }
            
            // ---- Touch Earth Image & Grvaity ----
            if let center = touchLocation {

                let imageSize = eventHorizonRadius * 1.8
                let imageRect = CGRect(
                    x: center.x - imageSize / 2,
                    y: center.y - imageSize / 2,
                    width: imageSize,
                    height: imageSize
                )

                // ---- Glow ----
                let glowPath = Path(ellipseIn: imageRect.insetBy(dx: -20, dy: -20))

                context.fill(glowPath, with: .radialGradient(
                        Gradient(colors: [
                            .cyan.opacity(0.7),
                            .clear
                        ]),
                        center: center,
                        startRadius: 0,
                        endRadius: imageSize
                    )
                )
                
                // ---- Event Horizon Ring ----
                let horizon = Path(ellipseIn: CGRect(
                    x: center.x - eventHorizonRadius,
                    y: center.y - eventHorizonRadius,
                    width: eventHorizonRadius * 2,
                    height: eventHorizonRadius * 2
                ))

                context.stroke(horizon, with: .color(.white.opacity(0.25)), lineWidth: 1.5)

                // ---- Earth Image ----
                let image = context.resolve(Image("earth"))
                context.drawLayer { layer in
                    layer.translateBy(x: center.x, y: center.y)
                    layer.rotate(by: .radians(spin))
                    layer.translateBy(x: -center.x, y: -center.y)
                    layer.opacity = 1
                    layer.blendMode = .overlay

                    layer.draw(image, in: imageRect)
                }
            }
        }
        .background(Color.black)
        .gesture(gravityGesture)
        .onReceive(timer) { _ in
            spin += 0.02 

            guard isWaveActive else { return }
            waveTime += 1 / 60
            if waveTime > 4 {
                isWaveActive = false
            }
        }
        .animation(.spring(response: 0.45, dampingFraction: 0.75), value: touchLocation)
        .ignoresSafeArea()
    }

    // MARK: - Deformation Pipeline
    private func deform(point: CGPoint) -> CGPoint {
        var result = point

        if let center = touchLocation {
            result = applyEventHorizon(from: center, to: result)
            result = applyGravity(from: center, to: result)
            result = applyAccretionDisk(from: center, to: result)
        }

        if isWaveActive, let origin = waveOrigin {
            result = applyWave(from: origin, to: result)
        }

        return result
    }

    // MARK: - Gravity Well
    private func applyGravity(from center: CGPoint, to point: CGPoint) -> CGPoint {
        let dx = point.x - center.x
        let dy = point.y - center.y
        let distance = max(eventHorizonRadius, sqrt(dx * dx + dy * dy))
        let force = gravityStrength * exp(-distance / gravityRadius)

        return CGPoint(
            x: point.x - dx / distance * force,
            y: point.y - dy / distance * force
        )
    }

    // MARK: - Event Horizon
    private func applyEventHorizon(from center: CGPoint, to point: CGPoint) -> CGPoint {
        let dx = point.x - center.x
        let dy = point.y - center.y
        let distance = sqrt(dx * dx + dy * dy)

        guard distance < eventHorizonRadius else { return point }

        return CGPoint(
            x: center.x + dx / max(distance, 1) * eventHorizonRadius,
            y: center.y + dy / max(distance, 1) * eventHorizonRadius
        )
    }

    // MARK: - Accretion Disk Swirl
    private func applyAccretionDisk(from center: CGPoint, to point: CGPoint) -> CGPoint {
        let dx = point.x - center.x
        let dy = point.y - center.y
        let distance = sqrt(dx * dx + dy * dy)

        guard distance < accretionDiskRadius,
              distance > eventHorizonRadius else { return point }

        let angle = atan2(dy, dx)
        let swirlFactor = (accretionDiskRadius - distance) / accretionDiskRadius
        let rotation = swirlFactor * swirlStrength * 0.01

        let newAngle = angle + rotation

        return CGPoint(
            x: center.x + cos(newAngle) * distance,
            y: center.y + sin(newAngle) * distance
        )
    }

    // MARK: - Gravitational Waves
    private func applyWave(from origin: CGPoint, to point: CGPoint) -> CGPoint {
        let dx = point.x - origin.x
        let dy = point.y - origin.y
        let distance = sqrt(dx * dx + dy * dy)

        let decay = exp(-distance / waveDecay)
        let wave = sin(distance / waveLength - waveTime * waveSpeed)
        let offset = wave * waveAmplitude * decay

        return CGPoint(
            x: point.x + dx / max(distance, 1) * offset,
            y: point.y + dy / max(distance, 1) * offset
        )
    }

    // MARK: - Gesture
    private var gravityGesture: some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged { value in
                touchLocation = value.location
                isWaveActive = false
            }
            .onEnded { value in
                waveOrigin = value.location
                waveTime = 0
                isWaveActive = true
                touchLocation = nil
            }
    }
}
