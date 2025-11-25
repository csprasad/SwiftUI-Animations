//
//  CarbonAtom.swift
//  SwiftUI-Animations
//
//  Created by codeAlligator on 25/11/25.
//


import SwiftUI

struct CarbonAtom: View {
    @State private var rotationAngle: Double = 0
    private let electronCount = 8
    private let orbitRadius: CGFloat = 100
    private let nucleusSize: CGFloat = 50
    
    var body: some View {
        ZStack {
            // Central nucleus
            Nucleus()
                .frame(width: nucleusSize, height: nucleusSize)
                .shadow(color: .gray.opacity(0.5), radius: 27, x: 5, y: 5)

            
            //K Shell dotted orbit ring
            Circle()
                .stroke(
                    style: StrokeStyle(
                        lineWidth: 2,
                        lineCap: .round,
                        dash: [1, 5]
                    )
                )
                .foregroundColor(.cyan)
                .frame(width: orbitRadius * 2, height: orbitRadius * 2)
                .rotationEffect(.degrees(rotationAngle))

            // K Shell electrons
            ForEach(0..<electronCount, id: \.self) { index in
                Electron(rotationAngle: rotationAngle)
                    .offset(
                        x: orbitRadius * cos(angleForElectron(index)),
                        y: orbitRadius * sin(angleForElectron(index))
                    )
                    .rotationEffect(.degrees(rotationAngle))
            }
            

            // L Shell dotted orbit ring
            Circle()
                .stroke(
                    style: StrokeStyle(
                        lineWidth: 2,
                        lineCap: .round,
                        dash: [1, 10]
                    )
                )
                .foregroundColor(.cyan)
                .frame(width: orbitRadius * 4, height: orbitRadius * 4)
                .rotationEffect(.degrees(-rotationAngle))


            // L Shell electrons
            ForEach(0..<electronCount, id: \.self) { index in
                Electron(rotationAngle: -rotationAngle)
                    .offset(
                        x: 200 * cos(angleForElectron(index)),
                        y: 200 * sin(angleForElectron(index))
                    )
                    .rotationEffect(.degrees(-rotationAngle))
            }
        }
        .onAppear {
            withAnimation(.linear(duration: 10).repeatForever(autoreverses: false)) {
                rotationAngle = 360
            }
        }
    }
    
    private func angleForElectron(_ index: Int) -> CGFloat {
        2 * .pi / CGFloat(electronCount) * CGFloat(index)
    }
}



//MARK: - Necleus view
struct Nucleus: View {
    private let nucleonCount = 12
    @State private var baseOffsets: [CGPoint] = []

    var body: some View {
        ZStack {
            ForEach(0..<nucleonCount, id: \.self) { index in
                let isProton = index % 2 == 0
                let base = baseOffsets.indices.contains(index)
                    ? baseOffsets[index]
                    : .zero

                ZStack {
                    Circle()
                        .fill(
                            LinearGradient(
                                gradient: Gradient(
                                    colors: isProton
                                    ? [.white, .green] // proton
                                    : [.white, .red]   // neutron
                                ),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 25, height: 25)

                    if isProton {
                        Text("+")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.black)
                    }
                }
                .offset(
                    x: base.x + 0.1,
                    y: base.y + 0.1
                )
            }
        }
        .onAppear {
            // random base positions ONCE
            if baseOffsets.isEmpty {
                baseOffsets = (0..<nucleonCount).map { _ in
                    CGPoint(
                        x: CGFloat.random(in: -20...20),
                        y: CGFloat.random(in: -20...20)
                    )
                }
            }
        }
    }
}



//MARK: - Electron view

struct Electron: View {
    let rotationAngle: Double
    
    var body: some View {
        ZStack {
            Circle()
                .fill(LinearGradient(
                    gradient: Gradient(colors: [.white, .cyan]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ))
                .frame(width: 25, height: 25)
                .shadow(color: .cyan, radius: 27, x: 10, y: 10)
            
                
            Text("-")
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(.black)
                .rotationEffect(.degrees(-rotationAngle))
        }
    }
}

