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
    @State private var isRotating = false
    private let orbitKRadius: CGFloat = 100
    private let orbitLRadius: CGFloat = 180

    var body: some View {
        ZStack {
            Nucleus()
                .frame(width: 100, height: 100)

            // K Shell
            ZStack {
                Circle()
                    .stroke(style: StrokeStyle(lineWidth: 1, lineCap: .round, dash: [2, 5]))
                    .foregroundColor(.cyan)
                    .frame(width: orbitKRadius * 2, height: orbitKRadius * 2)

                ForEach(0..<2, id: \.self) { index in
                    Electron()
                        .offset(
                            x: orbitKRadius * cos(angleForElectron(index)),
                            y: orbitKRadius * sin(angleForElectron(index))
                        )
                }
            }
            .padding(30)
            .drawingGroup()
            .rotationEffect(.degrees(isRotating ? 360 : 0))
            .animation(.linear(duration: 8).repeatForever(autoreverses: false), value: isRotating)

            // L Shell
            ZStack {
                Circle()
                    .stroke(style: StrokeStyle(lineWidth: 2, lineCap: .round, dash: [4, 10]))
                    .foregroundColor(.cyan)
                    .frame(width: orbitLRadius * 2, height: orbitLRadius * 2)

                ForEach(0..<4, id: \.self) { index in
                    Electron()
                        .offset(
                            x: orbitLRadius * cos(angleForElectron(index, 4)),
                            y: orbitLRadius * sin(angleForElectron(index, 4))
                        )
                }
            }
            .padding(30)
            .drawingGroup()
            .rotationEffect(.degrees(isRotating ? -360 : 0))
            .animation(.linear(duration: 20).repeatForever(autoreverses: false), value: isRotating)
        }
        .onAppear { isRotating = true }
    }

    private func angleForElectron(_ index: Int, _ total: Int = 2) -> CGFloat {
        2 * .pi / CGFloat(total) * CGFloat(index)
    }
}

// MARK: - Nucleus
struct Nucleus: View {
    private let nucleonCount = 12
    private let baseOffsets: [CGPoint] = [
        CGPoint(x: 0,   y: -20), CGPoint(x: 0,   y: 0),
        CGPoint(x: 17,  y: -10), CGPoint(x: 20,  y: 0),
        CGPoint(x: 17,  y: 10),  CGPoint(x: 10,  y: 17),
        CGPoint(x: 0,   y: 20),  CGPoint(x: -10, y: 17),
        CGPoint(x: -17, y: 10),  CGPoint(x: -20, y: 0),
        CGPoint(x: -17, y: -10), CGPoint(x: -10, y: -17),
    ]
    @State private var startDate = Date()

    var body: some View {
        // Drives jitter at 0.6s intervals
        TimelineView(.periodic(from: startDate, by: 0.6)) { _ in
            Canvas { ctx, size in
                let center = CGPoint(x: size.width / 2, y: size.height / 2)

                for i in 0..<nucleonCount {
                    let isProton = i % 2 == 0
                    let base = baseOffsets[i]
                    let jitter = CGPoint(
                        x: CGFloat.random(in: -3...3),
                        y: CGFloat.random(in: -3...3)
                    )
                    let origin = CGPoint(
                        x: center.x + base.x + jitter.x - 12.5,
                        y: center.y + base.y + jitter.y - 12.5
                    )
                    let rect = CGRect(origin: origin, size: CGSize(width: 25, height: 25))

                    ctx.fill(
                        Path(ellipseIn: rect),
                        with: .linearGradient(
                            Gradient(colors: isProton ? [.white, .green] : [.white, .red]),
                            startPoint: origin,
                            endPoint: CGPoint(x: origin.x + 25, y: origin.y + 25)
                        )
                    )

                    // Proton "+" label
                    if isProton {
                        var text = AttributedString("+")
                        text.font = .systemFont(ofSize: 14, weight: .bold)
                        ctx.draw(
                            Text("+").font(.system(size: 14, weight: .bold)).foregroundColor(.black),
                            at: CGPoint(x: origin.x + 12.5, y: origin.y + 12.5)
                        )
                    }
                }
            }
        }
    }
}

// MARK: - Electron
struct Electron: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(LinearGradient(
                    colors: [.white, .cyan],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ))
                .frame(width: 25, height: 25)
                .overlay(Circle().stroke(.gray.opacity(0.5), lineWidth: 0.5))

            Rectangle()
                .fill(Color.black)
                .frame(width: 10, height: 2)
        }
    }
}
