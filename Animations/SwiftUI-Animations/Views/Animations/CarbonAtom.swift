//
//  CarbonAtom.swift
//  SwiftUI-Animations
//
/// Created by `C S Prasad` on `25/11/25`
///
/// ### Social
/// `Instagram` : ``@csprasad.ios`` • `X` : ``@csprasad_ios`` • `Github` : ``@csprasad``
///


import SwiftUI

struct CarbonAtom: View {
    @State private var rotationAngle: Double = 0
    private let orbitKRadius: CGFloat = 100
    private let orbitLRadius: CGFloat = 180
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
                        lineWidth: 1,
                        lineCap: .round,
                        dash: [2, 5]
                    )
                )
                .foregroundColor(.cyan)
                .frame(width: orbitKRadius * 2, height: orbitKRadius * 2)
                .rotationEffect(.degrees(rotationAngle))

            // K Shell electrons
            ForEach(0..<2, id: \.self) { index in
                Electron(rotationAngle: rotationAngle)
                    .offset(
                        x: orbitKRadius * cos(angleForElectron(index)),
                        y: orbitKRadius * sin(angleForElectron(index))
                    )
                    .rotationEffect(.degrees(rotationAngle))
            }
            

            // L Shell dotted orbit ring
            Circle()
                .stroke(
                    style: StrokeStyle(
                        lineWidth: 2,
                        lineCap: .round,
                        dash: [4, 10]
                    )
                )
                .foregroundColor(.cyan)
                .frame(width: orbitLRadius * 2, height: orbitLRadius * 2)
                .rotationEffect(.degrees(-rotationAngle))


            // L Shell electrons
            ForEach(0..<4, id: \.self) { index in
                Electron(rotationAngle: -rotationAngle)
                    .offset(
                        x: orbitLRadius * cos(angleForElectron(index, 4)),
                        y: orbitLRadius * sin(angleForElectron(index, 4))
                    )
                    .rotationEffect(.degrees(-rotationAngle))
            }
        }
        .onAppear {
            withAnimation(.linear(duration: 40).repeatForever(autoreverses: false)) {
                rotationAngle = 360
            }
        }
    }
    
    private func angleForElectron(_ index: Int, _ total: Int = 2) -> CGFloat {
        2 * .pi / CGFloat(total) * CGFloat(index)
    }
}

//MARK: - Necleus view

struct Nucleus: View {
    private let nucleonCount = 12

    // Circle formation
    private let baseRingOffsets: [CGPoint] = [
        CGPoint(x: 0,   y: -20),
        CGPoint(x: 0,  y: 0),
        CGPoint(x: 17,  y: -10),
        CGPoint(x: 20,  y: 0),
        CGPoint(x: 17,  y: 10),
        CGPoint(x: 10,  y: 17),
        CGPoint(x: 0,   y: 20),
        CGPoint(x: -10, y: 17),
        CGPoint(x: -17, y: 10),
        CGPoint(x: -20, y: 0),
        CGPoint(x: -17, y: -10),
        CGPoint(x: -10, y: -17),
    ]

    @State private var targetOffsets: [CGPoint] = []
    @State private var timer: Timer?

    var body: some View {
        ZStack {
            ForEach(0..<nucleonCount, id: \.self) { index in
                let isProton = index % 2 == 0
                let target = targetOffsets.indices.contains(index)
                    ? targetOffsets[index]
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
                        .overlay(
                            Circle()
                                .stroke(.gray.opacity(0.5), lineWidth: 0.5)
                        )

                    if isProton {
                        Text("+")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.black)
                    }
                }
                .offset(x: target.x, y: target.y)
            }
        }
        .animation(
            .spring(response: 1, dampingFraction: 1),
            value: targetOffsets
        )
        .onAppear {
            // Initial circle layout
            if targetOffsets.isEmpty {
                targetOffsets = (0..<nucleonCount).map { i in
                    baseRingOffsets[i % baseRingOffsets.count]
                }
            }

            // Timer to keep giving new nearby targets
            timer = Timer.scheduledTimer(withTimeInterval: 0.25, repeats: true) { _ in
                
                // small random jitter around each base position
                targetOffsets = (0..<nucleonCount).map { i in
                    let base = baseRingOffsets[i % baseRingOffsets.count]
                    let jitterRange: ClosedRange<CGFloat> = -3...3

                    return CGPoint(
                        x: base.x + CGFloat.random(in: jitterRange),
                        y: base.y + CGFloat.random(in: jitterRange)
                    )
                }
            }
        }
        .onDisappear {
            // Clean up timer
            timer?.invalidate()
            timer = nil
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
                .overlay(
                    Circle()
                        .stroke(.gray.opacity(0.5), lineWidth: 0.5)
                )
            
                
            Text("-")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.black)
                .rotationEffect(.degrees(-rotationAngle))
        }
    }
}

