//
//  PlanetaryAtom.swift
//  SwiftUI-Animations
//
/// Created by `C S Prasad` on `21/03/25`
///
/// ### Social
/// `Instagram` : ``@csprasad.ios`` • `X` : ``@csprasad_ios`` • `Github` : ``@csprasad``
///

import SwiftUI

struct PlanetaryAtom: View {
    @State private var electronAngle: Double = 0
    let electronCount = 8
    let nucleusSize: CGFloat = 50
    let electronSize: CGFloat = 15
    let orbitRadius: CGFloat = 100
    
    var body: some View {
        
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            // Nucleus (protons and neutrons)
            
            Circle()
                .stroke(
                    style: StrokeStyle(
                        lineWidth: 1,
                        lineCap: .round,
                        dash: [2, 5]
                    )
                )
                .foregroundColor(.cyan)
                .frame(width: nucleusSize, height: nucleusSize)
            
            NucleusView()
                .frame(width: nucleusSize, height: nucleusSize)
            
            // Electron orbits
            ForEach(0..<electronCount, id: \.self) { i in
                ElectronOrbitView(index: i)
            }
            
            // Electrons
            ForEach(0..<electronCount, id: \.self) { i in
                ElectronView(angle: electronAngle + Double(i) * (360 / Double(electronCount)))
                    .offset(x: orbitRadius * cos(angleToRadian(electronAngle + Double(i) * (360 / Double(electronCount)))),
                            y: orbitRadius * sin(angleToRadian(electronAngle + Double(i) * (360 / Double(electronCount)))))
            }
        }
        .onAppear {
            withAnimation(.linear(duration: 8).repeatForever(autoreverses: false)) {
                electronAngle = 360
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Rutherford's Atom")
                    .foregroundColor(.white) // Set title color
            }
        }
    }
    
    private func angleToRadian(_ angle: Double) -> CGFloat {
        CGFloat(angle * .pi / 180)
    }
}

struct NucleusView: View {
    @State private var isPulsing = false
    
    var body: some View {
        ZStack {
            // Protons
            Circle()
                .fill(LinearGradient(gradient: Gradient(colors: [.red, .orange]),
                                     startPoint: .top, endPoint: .bottom))
                .scaleEffect(isPulsing ? 1.1 : 1)
            
            // Neutrons
            ForEach(0..<4, id: \.self) { i in
                Circle()
                    .fill(LinearGradient(gradient: Gradient(colors: [.blue, .purple]),
                                         startPoint: .top, endPoint: .bottom))
                    .frame(width: 15, height: 15)
                    .offset(x: CGFloat.random(in: -10...10),
                            y: CGFloat.random(in: -10...10))
            }
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 1).repeatForever()) {
                isPulsing.toggle()
            }
        }
    }
}

struct ElectronView: View {
    let angle: Double
    
    var body: some View {
        Circle()
            .fill(LinearGradient(gradient: Gradient(colors: [.red, .orange]),
                                 startPoint: .topLeading, endPoint: .bottomTrailing))
            .frame(width: 15, height: 15)
            .shadow(color: .red, radius: 5, x: 0, y: 0)
            .rotation3DEffect(.degrees(angle), axis: (x: 1, y: 0, z: 0))
    }
}

struct ElectronOrbitView: View {
    let index: Int
    @State private var rotation = 0.0
    
    var body: some View {
        Circle()
            .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
            .foregroundColor(.white.opacity(0.9))
            .frame(width: 100 + CGFloat(index) * 50, height: 100 + CGFloat(index) * 50)
            .rotation3DEffect(.degrees(rotation), axis: (x: 1, y: 0.5, z: 0))
            .onAppear {
                withAnimation(.linear(duration: Double.random(in: 10...20)).repeatForever(autoreverses: false)) {
                    rotation = 360
                }
            }
    }
}

