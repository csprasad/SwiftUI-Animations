//
//  ElectronShell.swift
//  SwiftUI-Animations
//
//  Created by codeAlligator on 25/11/25.
//


import SwiftUI

struct CarbonAtom: View {
    @State private var rotationAngle: Double = 0
    let electronCount = 8
    let orbitRadius: CGFloat = 100
    let nucleusSize: CGFloat = 50
    
    var body: some View {
        ZStack {
            // Central nucleus
            Nucleus()
                .frame(width: nucleusSize, height: nucleusSize)
                .rotationEffect(.degrees(-rotationAngle))

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

            // K Shell electrons
            ForEach(0..<electronCount, id: \.self) { index in
                Electron(rotationAngle: rotationAngle)
                    .offset(
                        x: orbitRadius * cos(angleForElectron(index)),
                        y: orbitRadius * sin(angleForElectron(index))
                    )
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
                .frame(width: 400, height: 400)   // 2 * 200 radius

            // L Shell electrons
            ForEach(0..<electronCount, id: \.self) { index in
                Electron(rotationAngle: rotationAngle)
                    .offset(
                        x: 200 * cos(angleForElectron(index)),
                        y: 200 * sin(angleForElectron(index))
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

//MARK: - Necleus view

struct Nucleus: View {
    var body: some View {
        ZStack {
            ForEach(0..<10, id: \.self) { _ in
                Circle()
                    .fill(LinearGradient(
                        gradient: Gradient(colors: [.white, .red]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ))
                    .frame(width: 20, height: 20)
                    .offset(x: CGFloat.random(in: -25...25),
                            y: CGFloat.random(in: -25...25))
                    .padding()
            }
            
            
            ForEach(0..<10, id: \.self) { _ in
                ZStack {
                    Circle()
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [.white, .green]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 20, height: 20)

                    Text("+")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.black)
                }
                .offset(x: CGFloat.random(in: -20...20),
                        y: CGFloat.random(in: -20...20))
                .padding()
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
                .frame(width: 20, height: 20)
                .shadow(color: .cyan, radius: 15, x: 10, y: 10)
                
            Text("-")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.black)
                .rotationEffect(.degrees(-rotationAngle))
        }
    }
}

