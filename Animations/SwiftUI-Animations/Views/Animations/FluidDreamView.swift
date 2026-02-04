//
//  StarryNightView.swift
//  SwiftUI-Animations
//
//  Created by codeAlligator on 28/01/26.
//

import SwiftUI

// MARK: - Blob
struct Blob {
    var x: CGFloat
    var y: CGFloat
    var vx: CGFloat
    var vy: CGFloat
    var radius: CGFloat
    var hue: Double
}

// MARK: - View
struct FluidDreamView: View {
    @State private var blobs: [Blob] = []
    @State private var time: Double = 0
    @State private var isActive: Bool = true
    
    var body: some View {
        GeometryReader { geo in
            TimelineView(.animation(minimumInterval: 1/30)) { _ in
                Canvas { context, size in
                    // Gradient background
                    let bg = Gradient(colors: [
                        Color(hue: 0.6, saturation: 0.3, brightness: 0.1),
                        Color(hue: 0.8, saturation: 0.4, brightness: 0.05)
                    ])
                    context.fill(Path(CGRect(origin: .zero, size: size)), with: .linearGradient(bg, startPoint: .zero, endPoint: CGPoint(x: size.width, y: size.height)))
                    
                    // Draw blobs with soft glow
                    context.blendMode = .plusLighter
                    
                    for blob in blobs {
                        // Color shifts over time
                        let dynamicHue = (blob.hue + time * 0.05).truncatingRemainder(dividingBy: 1.0)
                        let color = Color(hue: dynamicHue, saturation: 0.8, brightness: 0.9)
                        
                        // Outer glow layers
                        for scale in stride(from: 2.5, to: 1.0, by: -0.3) {
                            let r = blob.radius * scale
                            context.fill(
                                Path(ellipseIn: CGRect(x: blob.x - r, y: blob.y - r, width: r * 2, height: r * 2)),
                                with: .color(color.opacity(0.05 / scale))
                            )
                        }
                        
                        // Core blob
                        context.fill(
                            Path(ellipseIn: CGRect(x: blob.x - blob.radius, y: blob.y - blob.radius, width: blob.radius * 2, height: blob.radius * 2)),
                            with: .color(color.opacity(0.6))
                        )
                    }
                }
                .drawingGroup()
                .task {
                    while isActive {
                        time += 1/30.0
                        updateBlobs(size: geo.size)
                        try? await Task.sleep(nanoseconds: 33_333_333) // 30fps for CPU efficiency
                    }
                }
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { value in
                            // Spawn new blob on touch
                            let newBlob = Blob(
                                x: value.location.x,
                                y: value.location.y,
                                vx: .random(in: -3...3),
                                vy: .random(in: -3...3),
                                radius: .random(in: 40...80),
                                hue: .random(in: 0...1)
                            )
                            blobs.append(newBlob)
                            // Keep blob count manageable
                            if blobs.count > 12 {
                                blobs.removeFirst()
                            }
                        }
                )
            }
            .onAppear {
                isActive = true
                blobs = createBlobs(size: geo.size)
            }
            .onDisappear {
                isActive = false
            }
        }
        .ignoresSafeArea()
    }
    
    func updateBlobs(size: CGSize) {
        guard !size.equalTo(.zero) else { return }
        
        for i in blobs.indices {
            var blob = blobs[i]
            
            // Gentle floating motion
            blob.vx += sin(time * 0.5 + Double(i)) * 0.1
            blob.vy += cos(time * 0.3 + Double(i)) * 0.1
            
            // Blob attraction/repulsion (simplified for performance)
            if i < blobs.count - 1 {
                let other = blobs[i + 1]
                let dx = other.x - blob.x
                let dy = other.y - blob.y
                let dist = max(1, sqrt(dx * dx + dy * dy))
                
                if dist < 200 {
                    // Attract
                    blob.vx += dx / dist * 0.05
                    blob.vy += dy / dist * 0.05
                } else {
                    // Repel slightly
                    blob.vx -= dx / dist * 0.02
                    blob.vy -= dy / dist * 0.02
                }
            }
            
            // Damping
            blob.vx *= 0.95
            blob.vy *= 0.95
            
            // Move
            blob.x += blob.vx
            blob.y += blob.vy
            
            // Bounce off edges with dampening
            if blob.x < 0 || blob.x > size.width {
                blob.vx *= -0.7
                blob.x = max(0, min(size.width, blob.x))
            }
            if blob.y < 0 || blob.y > size.height {
                blob.vy *= -0.7
                blob.y = max(0, min(size.height, blob.y))
            }
            
            // Slowly shrink/grow
            blob.radius += sin(time * 0.8 + Double(i) * 1.3) * 0.3
            blob.radius = max(30, min(100, blob.radius))
            
            blobs[i] = blob
        }
    }
}

func createBlobs(size: CGSize) -> [Blob] {
    (0..<8).map { i in
        Blob(
            x: .random(in: size.width * 0.2...size.width * 0.8),
            y: .random(in: size.height * 0.2...size.height * 0.8),
            vx: .random(in: -2...2),
            vy: .random(in: -2...2),
            radius: .random(in: 50...80),
            hue: Double(i) / 8.0
        )
    }
}

#Preview {
    FluidDreamView()
}
