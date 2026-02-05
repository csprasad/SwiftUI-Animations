//
//  KaleidoscopeView.swift
//  SwiftUI-Animations
//
//  Created by codeAlligator on 04/02/26.
//

import SwiftUI

struct Polygon {
    var points: [CGPoint]
    var color: Color
    var rotation: Double
    var scale: Double
    var alpha: Double
}

struct KaleidoscopeView: View {
    @State private var shapes: [Polygon] = []
    @State private var phase: Double = 0
    @State private var mode: Int = 0
    @State private var isActive: Bool = true
    
    let colors: [Color] = [
        Color(red: 1, green: 0.1, blue: 0.5),
        Color(red: 0, green: 0.9, blue: 0.9),
        Color(red: 1, green: 0.8, blue: 0),
        Color(red: 0.5, green: 0, blue: 1),
        Color(red: 0, green: 1, blue: 0.3)
    ]
    
    var body: some View {
        GeometryReader { geo in
            TimelineView(.animation(minimumInterval: 1/30)) { _ in
                Canvas { context, size in
                    context.fill(
                        Path(CGRect(origin: .zero, size: size)),
                        with: .color(.black)
                    )
                    
                    let cx = size.width / 2
                    let cy = size.height / 2
                    
                    context.translateBy(x: cx, y: cy)
                    
                    // Draw with symmetry
                    for mirror in 0..<6 {
                        var ctx = context
                        ctx.rotate(by: .degrees(Double(mirror) * 60))
                        
                        for shape in shapes {
                            var shapeCtx = ctx
                            shapeCtx.rotate(by: .degrees(shape.rotation))
                            shapeCtx.scaleBy(x: shape.scale, y: shape.scale)
                            
                            var path = Path()
                            if let first = shape.points.first {
                                path.move(to: first)
                                for point in shape.points.dropFirst() {
                                    path.addLine(to: point)
                                }
                                path.closeSubpath()
                            }
                            
                            // Filled shape
                            shapeCtx.fill(
                                path,
                                with: .color(shape.color.opacity(shape.alpha * 0.3))
                            )
                            
                            // Sharp outline
                            shapeCtx.stroke(
                                path,
                                with: .color(shape.color.opacity(shape.alpha)),
                                lineWidth: 2
                            )
                        }
                    }
                }
                .drawingGroup()
                .gesture(
                    TapGesture()
                        .onEnded { _ in
                            mode = (mode + 1) % 3
                            shapes.removeAll()
                            shapes = createShapes()
                        }
                )
                .task {
                    while isActive {
                        phase += 1/30.0
                        updateShapes(size: geo.size)
                        try? await Task.sleep(nanoseconds: 33_333_333)
                    }
                }
            }
            .onAppear {
                isActive = true
                shapes = createShapes()
            }
            .onDisappear {
                isActive = false
            }
        }
        .ignoresSafeArea()
    }
    
    func updateShapes(size: CGSize) {
        for i in shapes.indices {
            var s = shapes[i]
            
            switch mode {
            case 0: // Spinning triangles
                s.rotation += 2.0 + Double(i) * 0.5
                s.scale = 1.0 + sin(phase * 2 + Double(i)) * 0.3
                
            case 1: // Pulsing squares
                s.rotation += 1.0
                s.scale = 0.8 + sin(phase * 3 + Double(i) * 0.7) * 0.5
                s.alpha = 0.6 + sin(phase * 4 + Double(i)) * 0.4
                
            case 2: // Morphing stars
                s.rotation += 0.5 - Double(i) * 0.2
                s.scale = 1.2 + cos(phase * 2.5 + Double(i) * 1.2) * 0.4
                
                // Morph points
                for j in s.points.indices {
                    let angle = Double(j) * .pi * 2 / Double(s.points.count)
                    let radius = 60 + sin(phase * 3 + angle + Double(i)) * 20
                    s.points[j] = CGPoint(
                        x: cos(angle) * radius,
                        y: sin(angle) * radius
                    )
                }
                
            default:
                break
            }
            
            shapes[i] = s
        }
    }
    
    func createShapes() -> [Polygon] {
        switch mode {
        case 0: // Triangles
            return (0..<5).map { i in
                let size = CGFloat(40 + i * 15)
                return Polygon(
                    points: [
                        CGPoint(x: 0, y: -size),
                        CGPoint(x: size * 0.866, y: size * 0.5),
                        CGPoint(x: -size * 0.866, y: size * 0.5)
                    ],
                    color: colors[i % colors.count],
                    rotation: Double(i) * 30,
                    scale: 1.0,
                    alpha: 1.0
                )
            }
            
        case 1: // Squares
            return (0..<4).map { i in
                let size = CGFloat(35 + i * 20)
                return Polygon(
                    points: [
                        CGPoint(x: -size, y: -size),
                        CGPoint(x: size, y: -size),
                        CGPoint(x: size, y: size),
                        CGPoint(x: -size, y: size)
                    ],
                    color: colors[i % colors.count],
                    rotation: Double(i) * 45,
                    scale: 1.0,
                    alpha: 0.8
                )
            }
            
        case 2: // Stars
            return (0..<3).map { i in
                let points = 8
                var pts: [CGPoint] = []
                for j in 0..<points {
                    let angle = Double(j) * .pi * 2 / Double(points)
                    let radius = CGFloat(50 + i * 25)
                    pts.append(CGPoint(x: cos(angle) * radius, y: sin(angle) * radius))
                }
                return Polygon(
                    points: pts,
                    color: colors[i % colors.count],
                    rotation: Double(i) * 60,
                    scale: 1.0,
                    alpha: 0.9
                )
            }
            
        default:
            return []
        }
    }
}

#Preview {
    KaleidoscopeView()
}
