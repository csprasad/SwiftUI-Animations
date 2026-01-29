//
//  StarryNightView.swift
//  SwiftUI-Animations
//
//  Created by codeAlligator on 28/01/26.
//

import SwiftUI

// MARK: - Particle
struct Particle {
    var position: CGPoint
    var velocity: CGVector
    var life: Double
    var color: Color
}

// MARK: - View
struct StarryNightView: View {
    @State private var particles: [Particle] = []
    
    private let particleCount = 1200
    
    private let palette: [Color] = [
        Color(red: 0.15, green: 0.25, blue: 0.6),
        Color(red: 0.25, green: 0.55, blue: 0.9),
        Color(red: 0.95, green: 0.85, blue: 0.4)
    ]
    
    private let vortexCenters: [CGPoint] = [
        CGPoint(x: 120, y: 260),
        CGPoint(x: 280, y: 180),
        CGPoint(x: 220, y: 420)
    ]
    
    var body: some View {
        GeometryReader { geo in
            TimelineView(.animation) { _ in
                Canvas { context, size in
                    // ✅ DRAW ONLY — NO STATE MUTATION
                    context.blendMode = .normal
                    
                    for p in particles {
                        context.fill(
                            Path(ellipseIn: CGRect(
                                x: p.position.x,
                                y: p.position.y,
                                width: 3,
                                height: 3
                            )),
                            with: .color(p.color.opacity(p.life))
                        )
                    }
                }
                .background(Color.black)
                .drawingGroup()
                .onChange(of: geo.size) { _ in
                    // re-init on rotation
                    particles = createParticles(size: geo.size)
                }
                .task {
                    // simulation loop
                    while true {
                        updateParticles(size: geo.size)
                        try? await Task.sleep(nanoseconds: 16_000_000) // ~60fps
                    }
                }
            }
            .onAppear {
                particles = createParticles(size: geo.size)
            }
        }
        .ignoresSafeArea()
    }
    
    // MARK: - Simulation
    func updateParticles(size: CGSize) {
        guard !size.equalTo(.zero) else { return }
        
        for i in particles.indices {
            var p = particles[i]
            
            // swirl forces
            for center in vortexCenters {
                let dir = swirlDirection(at: p.position, center: center)
                p.velocity.dx += dir.dx * 0.12
                p.velocity.dy += dir.dy * 0.12
            }
            
            // move
            p.position.x += p.velocity.dx
            p.position.y += p.velocity.dy
            
            // life
            p.life -= 0.002
            
            // respawn
            if p.life <= 0 ||
                p.position.x < 0 || p.position.y < 0 ||
                p.position.x > size.width || p.position.y > size.height {
                
                p.position = CGPoint(
                    x: .random(in: 0...size.width),
                    y: .random(in: 0...size.height)
                )
                p.velocity = .zero
                p.life = 1
                p.color = palette.randomElement()!
            }
            
            particles[i] = p
        }
    }

}


// MARK: - Helpers
func swirlDirection(at point: CGPoint, center: CGPoint) -> CGVector {
    let dx = point.x - center.x
    let dy = point.y - center.y
    let dist = max(30, sqrt(dx * dx + dy * dy))
    
    // perpendicular vector → swirl
    return CGVector(
        dx: -dy / dist,
        dy:  dx / dist
    )
}

func createParticles(size: CGSize) -> [Particle] {
    (0..<1200).map { _ in
        Particle(
            position: CGPoint(
                x: .random(in: 0...size.width),
                y: .random(in: 0...size.height)
            ),
            velocity: .zero,
            life: .random(in: 0.6...1),
            color: [.blue, .cyan, .yellow].randomElement()!
        )
    }
}

// MARK: - Preview
#Preview {
    StarryNightView()
}
