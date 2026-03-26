//
//  SunRiseUIView.swift
//  SwiftUI-Animations
//
/// Created by `C S Prasad` on `30/06/23`
///
/// ### Social
/// `Instagram` : ``@csprasad.ios`` • `X` : ``@csprasad_ios`` • `Github` : ``@csprasad``
///

import SwiftUI

// MARK: - Main Scene
struct SunRiseView: View {
    @State private var sunOffset: CGFloat = 200
    @State private var backgroundColor = Color.black

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Sun
                SunView()
                    .foregroundColor(.yellow)
                    .offset(y: sunOffset)

                // Landscape
                SceneView()
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

struct SceneView: View {
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
            
            Rectangle()
                .frame(height: 300)
                .foregroundStyle(Color(hex: "#41980a").opacity(0.9))
                .offset(y: 250)

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
            
            Text("🌲")
                .font(.system(size: 80))
                .offset(x: -120, y: 0)
                .padding()
            
            Text("🌲")
                .font(.system(size: 80))
                .offset(x: -100, y: 0)
                .padding()
            
            Text("🌲")
                .font(.system(size: 80))
                .offset(x: -90, y: 0)
                .padding()
            
            Text("🌲")
                .font(.system(size: 90))
                .offset(x: -50, y: 0)
                .padding()
            
            Text("🌲")
                .font(.system(size: 80))
                .offset(x: 120, y: 0)
                .padding()
            
            Text("🌲")
                .font(.system(size: 80))
                .offset(x: 100, y: 0)
                .padding()
            
            Text("🌲")
                .font(.system(size: 80))
                .offset(x: 90, y: 0)
                .padding()
            
            Text("🌲")
                .font(.system(size: 130))
                .offset(x: 50, y: 0)
                .padding()

            // Volcano
            Text("🌋")
                .font(.system(size: 150))
                .offset(x:-10,y: 10)

            // Mountains
            HStack(spacing: 20) {
                Text("🏔").font(.system(size: 280))
                Text("🏔").font(.system(size: 300))
            }
            .padding(-120)
            
            Text("🌲")
                .font(.system(size: 180))
                .offset(x: -120, y: 130)
                .padding()

            Text("🌲")
                .font(.system(size: 180))
                .offset(x: 190, y: 150)
                .padding()
            
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

