//
//  SunRiseUIView.swift
//  Gradient
//
//  Created by CS Prasad on 30/06/23.
//

import SwiftUI

// MARK: - Main Scene
struct SunRiseUIView: View {
    @State private var sunOffset: CGFloat = 200
    @State private var backgroundColor = Color.black

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Sky + Sun
                SunView()
                    .foregroundColor(.yellow)
                    .offset(y: sunOffset)

                // Landscape
                TreeView()
            }

            // Fade-out overlay
            Rectangle()
                .foregroundColor(backgroundColor)
                .frame(
                    width: geometry.size.width,
                    height: geometry.size.height + 200
                )
                .ignoresSafeArea()
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 5)) {
                sunOffset = -250
            }

            withAnimation(.easeInOut(duration: 6)) {
                backgroundColor = .black.opacity(0.01)
            }
        }
        .background(.skyblue)
    }
}

// MARK: - Sun
struct SunView: View {
    var body: some View {
        Image(systemName: "sun.max.fill")
            .resizable()
            .frame(width: 100, height: 100)
    }
}

// MARK: - Landscape
struct TreeView: View {
    private let clouds = Array(repeating: "☁", count: 8)
    @State private var cloudPositions: [CGPoint] = []

    var body: some View {
        ZStack {
            // Clouds
            GeometryReader { geometry in
                ZStack {
                    if cloudPositions.count == clouds.count {
                        ForEach(clouds.indices, id: \.self) { index in
                            Text(clouds[index])
                                .font(.system(size: 60))
                                .position(cloudPositions[index])
                        }
                    }
                }
                .onAppear {
                    guard cloudPositions.isEmpty else { return }

                    cloudPositions = clouds.map { _ in
                        CGPoint(
                            x: .random(in: 0...geometry.size.width),
                            y: .random(in: 0...geometry.size.height * 0.35)
                        )
                    }
                }
            }



            // Static clouds (foreground depth)
            Group {
                Text("☁").font(.system(size: 100)).offset(x: 100, y: -290)
                Text("☁").font(.system(size: 80)).offset(x: -100, y: -170)
                Text("☁").font(.system(size: 30)).offset(x: -80, y: -270)
                Text("☁").font(.system(size: 20)).offset(x: 100, y: -130)
            }

            // Sand
            Image("sand")
                .resizable()
                .frame(width: 800, height: 800)
                .offset(y: 250)
                .padding(-290)

            // River
            Image("river")
                .resizable()
                .scaledToFit()
                .frame(width: 380, height: 420)
                .offset(x: -190, y: 210)
                .rotationEffect(.degrees(-55))

            // Volcano
            Text("🌋")
                .font(.system(size: 180))
                .offset(y: 10)

            // Mountains
            HStack(spacing: 20) {
                Text("🏔").font(.system(size: 280))
                Text("🏔").font(.system(size: 300))
            }
            .padding(-120)

            // Camp
            HStack(spacing: 0) {
                Text("⛺")
                    .font(.system(size: 150))
                    .offset(x: -100, y: 250)

                Text("🏌️‍♀️")
                    .font(.system(size: 50))
                    .offset(x: -100, y: 300)
            }
        }
    }
}

