//
//  MatrixRain.swift
//  SwiftUI-Animations
//
/// Created by `C S Prasad` on `07/02/26`
///
/// ### Social
/// `Instagram` : ``@csprasad.ios`` • `X` : ``@csprasad_ios`` • `Github` : ``@csprasad``
///

import SwiftUI
import Combine
    
// MARK: - Matrix Rain
struct MatrixRain: View {
    let characters = Array("0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyzｱｲｳｴｵｶｷｸｹｺｻｼｽｾｿﾀﾁﾂﾃﾄﾅﾆﾇﾈﾉﾊﾋﾌﾍﾎﾏﾐﾑﾒﾓﾔﾕﾖﾗﾘﾙﾚﾛﾜｦﾝअआइईउऊएऐओऔकखगघचछजझटठडढणतथदधनपफबभमयरलवशषसहㄱㄴㄷㄹㅁㅂㅅㅇㅈㅊㅋㅌㅍㅎ가나다라마바사아자차카타파하")
    
    @State private var drops: [Drop] = []
    @State private var timer: Timer?
    
    struct Drop {
        var x: CGFloat
        var y: CGFloat
        var speed: CGFloat
        var length: Int
        var chars: [Character]
    }
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color.black.ignoresSafeArea()
                
                // Background "MATRIX" text
                VStack(alignment: .center,spacing: 0) {
                    Text("M A T R I X")
                        .font(.system(size: 55, weight: .black, design: .monospaced))
                        
                    Text("D I G I T A L   R A I N")
                        .font(.system(size: 20, weight: .black, design: .monospaced))
                        .lineSpacing(40)
                }
                .foregroundColor(.green.opacity(0.4))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                // Matrix rain effect
                TimelineView(.animation(minimumInterval: 1/30)) { timeline in
                    Canvas { context, size in
                        let charSize: CGFloat = 18
                        
                        for drop in drops {
                            // Draw each character in the drop
                            for i in 0..<drop.length {
                                let y = drop.y - CGFloat(i) * charSize
                                
                                // Skip if offscreen
                                guard y > -charSize && y < size.height + charSize else { continue }
                                
                                let char = drop.chars[i % drop.chars.count]
                                
                                // Brightness: 1.0 at tip (i=0), fades to 0.1
                                let brightness = max(0.1, 1.0 - (Double(i) / Double(drop.length)))
                                
                                // Color: white at tip, green for rest
                                let color: Color = i == 0 ? .white : .green.opacity(brightness)
                                
                                let text = Text(String(char))
                                    .font(.system(size: 16, weight: .bold, design: .monospaced))
                                    .foregroundColor(color)
                                
                                context.draw(text, at: CGPoint(x: drop.x, y: y))
                                
                                // Extra glow on tip
                                if i == 0 {
                                    let glowText = Text(String(char))
                                        .font(.system(size: 16, weight: .bold, design: .monospaced))
                                        .foregroundColor(.white.opacity(0.5))
                                    context.draw(glowText, at: CGPoint(x: drop.x, y: y))
                                }
                            }
                        }
                    }
                    .ignoresSafeArea()
                    .onChange(of: timeline.date) { _ in
                        updateDrops(screenHeight: geo.size.height)
                    }
                }
            }
            .onAppear {
                initializeDrops(screenWidth: geo.size.width, screenHeight: geo.size.height)
            }
        }
        .background(Color.black)
    }
    
    private func initializeDrops(screenWidth: CGFloat, screenHeight: CGFloat) {
        // More drops to fill gaps, one every 15 pixels
        let columnSpacing: CGFloat = 15
        let dropCount = Int(screenWidth / columnSpacing)
        
        drops = (0..<dropCount).map { i in
            Drop(
                x: CGFloat(i) * columnSpacing + 8,
                y: -CGFloat.random(in: 0...screenHeight), // Spread throughout height
                speed: CGFloat.random(in: 50...120), // Speeds
                length: Int.random(in: 20...35), // Longer trails
                chars: (0..<50).map { _ in characters.randomElement()! }
            )
        }
    }
    
    private func updateDrops(screenHeight: CGFloat) {
        for i in 0..<drops.count {
            // Moving down speed
            drops[i].y += drops[i].speed * (1.0/30.0)
            
            // Cycle characters for animation effect
            if Int.random(in: 0...2) == 0 {
                drops[i].chars.rotate()
            }
            
            // Random character mutations
            if Double.random(in: 0...1) < 0.15 {
                let idx = Int.random(in: 0..<drops[i].chars.count)
                drops[i].chars[idx] = characters.randomElement()!
            }
            
            // Reset when offscreen
            if drops[i].y > screenHeight + CGFloat(drops[i].length) * 18 {
                drops[i].y = -CGFloat(drops[i].length) * 18
                drops[i].speed = CGFloat.random(in: 50...120)
                drops[i].length = Int.random(in: 20...35)
            }
        }
    }
}

// Helper to rotate array
extension Array {
    mutating func rotate() {
        guard !isEmpty else { return }
        let first = removeFirst()
        append(first)
    }
}


// MARK: - Preview
#Preview {
    MatrixRain()
}

