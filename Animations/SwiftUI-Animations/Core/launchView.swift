//
//
//  launchView.swift
//  SwiftUI-Animations
//
/// Created by `C S Prasad` on `27/03/26`
///
/// ### Social
/// `Instagram` : ``@csprasad.ios`` • `X` : ``@csprasad_ios`` • `Github` : ``@csprasad``
///

import SwiftUI

struct launchView: View {
    @State private var isAnimating = false
    @State private var textOpacity = 0.0
    @State private var textOffset: CGFloat = 20
    
    let verticalOffsets: [CGFloat] = [20, 0, -20]
    let wingColors: [Color] = [.cyan, .blue, .purple]
    
    var body: some View {
        ZStack {
            VStack(spacing: 30) {
                Spacer()
                ZStack {
                    // Glowing Trails
                    ForEach(0..<3) { i in
                        Capsule()
                            .fill(LinearGradient(
                                colors: [wingColors[i].opacity(0.8), .clear],
                                startPoint: .leading,
                                endPoint: .trailing
                            ))
                            .frame(width: isAnimating ? 450 : 0, height: 3)
                            .offset(
                                x: isAnimating ? -140 : -600,
                                y: CGFloat(i * 35)
                            )
                            .blur(radius: 2)
                            .rotationEffect(.degrees(-45))
                            .animation(
                                .spring(response: 1.2, dampingFraction: 0.8)
                                .delay(Double(i) * 0.15),
                                value: isAnimating
                            )
                    }
                    
                    HStack(alignment: .firstTextBaseline, spacing: -30) {
                        // Wings
                        ForEach(0..<3) { i in
                            ZStack {
                                // Glass Base
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(.ultraThinMaterial)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(LinearGradient(colors: [.white.opacity(0.5), wingColors[i].opacity(0.3)],
                                                                   startPoint: .topLeading,
                                                                   endPoint: .bottomTrailing),
                                                    lineWidth: 1.5)
                                    )
                                    .rotationEffect(.degrees(45))
                                
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 24, weight: .black))
                                    .foregroundStyle(
                                        LinearGradient(colors: [.primary.opacity(0.5), wingColors[i]],
                                                       startPoint: .topLeading,
                                                       endPoint: .bottomTrailing)
                                    )
                                    .shadow(color: wingColors[i].opacity(0.5), radius: 2, x: 0, y: 8)
                            }
                            .frame(width: 80, height: 80)
                            .offset(y: isAnimating ? verticalOffsets[i] : 0)
                            .offset(x: isAnimating ? CGFloat(i * 20) : -400)
                            .scaleEffect(isAnimating ? 1.0 : 0.5)
                            .opacity(isAnimating ? 1.0 : 0)
                            .animation(
                                .spring(response: 0.7, dampingFraction: 0.7)
                                .delay(Double(i) * 0.12),
                                value: isAnimating
                            )
                        }
                    }
                }
                .padding(.bottom, 20)
                
                // Title
                VStack(spacing: 12) {
                    Text("ANIMATE")
                        .font(.system(size: 48, weight: .black, design: .rounded))
                        .kerning(10)
                        .foregroundStyle(
                            LinearGradient(colors: [.secondary, .primary],
                                           startPoint: .top, endPoint: .bottom)
                        )
                    
                    Text("with SWIFTUI")
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .kerning(5)
                        .foregroundStyle(
                            LinearGradient(colors: wingColors,
                                           startPoint: .leading, endPoint: .trailing)
                        )
                }
                .opacity(textOpacity)
                .offset(y: textOffset)
                
                Spacer()
                
                // Credit's
                HStack(spacing: 10) {
                    Text("@")
                        .font(.system(size: 15, weight: .black, design: .rounded))
                        .foregroundStyle(.gray)
                    
                    Text("csprasad")
                        .font(.system(size: 18, weight: .black, design: .monospaced))
                        .kerning(5)
                        .foregroundStyle(.gray)
                }
                .opacity(textOpacity)
                .offset(y: textOffset)
            }
        }
        .onAppear {
            isAnimating = true
            
            withAnimation(.easeOut(duration: 1.0).delay(0.6)) {
                textOpacity = 1.0
                textOffset = 0
            }
        }
    }
}

#Preview {
    launchView()
}
