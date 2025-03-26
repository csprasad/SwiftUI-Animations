//
//  TestingView.swift
//  SwiftUI-Animations
//
//  Created by CS Prasad on 08/08/24.
//

import SwiftUI

struct TestingView: View {
    @State private var rotationAngle: Double = 0
        let electronCount = 8
        let orbitRadius: CGFloat = 100
        let nucleusSize: CGFloat = 50
        
        var body: some View {
            Color.black.ignoresSafeArea(edges: .all)
            ZStack {
                // Central nucleus
                Nucleus()
                    .frame(width: nucleusSize, height: nucleusSize)
                
                // Electrons in orbit
                ForEach(0..<electronCount, id: \.self) { index in
                    Electron()
                        .offset(
                            x: orbitRadius * cos(angleForElectron(index)),
                            y: orbitRadius * sin(angleForElectron(index))
                        )
                }
            }
            .rotationEffect(.degrees(rotationAngle))
            .onAppear {
                withAnimation(.linear(duration: 15).repeatForever(autoreverses: false)) {
                    rotationAngle = 360
                }
            }
        }
        
        private func angleForElectron(_ index: Int) -> CGFloat {
            let baseAngle = CGFloat(rotationAngle) * .pi / 180
            let spacing = 2 * .pi / CGFloat(electronCount)
            return baseAngle + (spacing * CGFloat(index))
        }
    }

    struct Nucleus: View {
        var body: some View {
            ZStack {
                Circle()
                    .fill(LinearGradient(
                        gradient: Gradient(colors: [.red, .orange]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ))
                
                ForEach(0..<4, id: \.self) { _ in
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 10, height: 10)
                        .offset(x: CGFloat.random(in: -15...15),
                                y: CGFloat.random(in: -15...15))
                }
            }
        }
    }

    struct Electron: View {
        @State private var spin: Double = 0
        
        var body: some View {
            Circle()
                .fill(LinearGradient(
                    gradient: Gradient(colors: [.teal, .cyan]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ))
                .frame(width: 15, height: 15)
                .shadow(color: .blue, radius: 15, x: 10, y: 10)
                .rotation3DEffect(.degrees(spin), axis: (x: 0, y: 1, z: 0))
                .onAppear {
                    withAnimation(.linear(duration: 2).repeatForever(autoreverses: false)) {
                        spin = 360
                    }
                }
        }
    }
