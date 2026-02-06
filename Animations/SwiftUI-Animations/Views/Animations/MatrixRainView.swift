//
//  MatrixRainView.swift
//  SwiftUI-Animations
//
//  Created by codeAlligator on 07/02/26.
//

import SwiftUI
import Combine

// MARK: - DisplayLink Updater
class FrameUpdater: ObservableObject {
    @Published var tick: Double = 0
    var displayLink: CADisplayLink?

    init() {
        displayLink = CADisplayLink(target: self, selector: #selector(update))
        displayLink?.add(to: .main, forMode: .common)
    }

    @objc func update() {
        tick += displayLink?.duration ?? 0
    }

    deinit {
        displayLink?.invalidate()
    }
}

// MARK: - Matrix Rain View
struct MatrixRainView: View {
    let columns = 25
    let maxRows = 40
    let characters = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789ｱｲｳｴｵﾊﾐﾋｰ")

    @State private var drops: [[Character]] = []
    @State private var offsets: [CGFloat] = []
    @State private var speeds: [CGFloat] = []

    @StateObject private var updater = FrameUpdater()

    init() {
        var tempDrops: [[Character]] = []
        var tempOffsets: [CGFloat] = []
        var tempSpeeds: [CGFloat] = []

        for _ in 0..<columns {
            tempDrops.append((0..<maxRows).map { _ in
                characters.randomElement()!
            })
            tempOffsets.append(CGFloat.random(in: -600...0))
            tempSpeeds.append(CGFloat.random(in: 50...200)) // pixels per second
        }

        _drops = State(initialValue: tempDrops)
        _offsets = State(initialValue: tempOffsets)
        _speeds = State(initialValue: tempSpeeds)
    }

    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color.black.ignoresSafeArea()

                HStack(spacing: 6) {
                    ForEach(0..<columns, id: \.self) { col in
                        VStack(spacing: 0) {
                            ForEach(0..<maxRows, id: \.self) { row in
                                let char = drops[col][row]
                                // Leading tip is bright white
                                let isTip = row == maxRows - 1
                                Text(String(char))
                                    .font(.system(size: 16, weight: .bold, design: .monospaced))
                                    .foregroundColor(
                                        isTip ? Color.white :
                                        Color.green.opacity(Double(row)/Double(maxRows))
                                    )
                                    .shadow(color: .green.opacity(isTip ? 1.0 : 0.5), radius: isTip ? 4 : 2)
                                    // Flip animation
                                    .rotation3DEffect(
                                        Angle(degrees: drops[col][row].isNumber ? 180 : 0),
                                        axis: (x: 1, y: 0, z: 0)
                                    )
                                    .animation(.linear(duration: 0.1), value: drops[col][row])
                            }
                        }
                        .offset(y: offsets[col])
                        .frame(height: geo.size.height, alignment: .top)
                    }
                }
            }
            // Update positions continuously
            .onReceive(updater.$tick) { _ in
                for col in 0..<columns {
                    let delta = CGFloat(0.016) // ~60FPS
                    offsets[col] += speeds[col] * delta

                    // If drop passed bottom, reset
                    if offsets[col] > geo.size.height + CGFloat(maxRows*16) {
                        offsets[col] = -CGFloat.random(in: 100...300)
                        drops[col] = (0..<maxRows).map { _ in characters.randomElement()! }
                        speeds[col] = CGFloat.random(in: 50...200)
                    } else {
                        // Randomly flip some characters mid-drop
                        for row in 0..<maxRows {
                            if Bool.random() && Double.random(in: 0...1) < 0.05 {
                                drops[col][row] = characters.randomElement()!
                            }
                        }
                    }
                }
            }
        }
    }
}

// MARK: - Preview
struct MatrixRainView_Previews: PreviewProvider {
    static var previews: some View {
        MatrixRainView()
            .previewInterfaceOrientation(.landscapeLeft)
    }
}

