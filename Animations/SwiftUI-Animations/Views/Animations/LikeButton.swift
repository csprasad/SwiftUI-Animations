//
//  LikeButton.swift
//  SwiftUI-Animations
//
//  Created by codeAlligator on 18/01/26.
//

import SwiftUI

struct LikeButton: View {
    @State private var SimpleLiked = false
    @State private var BounceLike = false
    @State private var BurstLike = false
    @State private var scale: CGFloat = 1
    @State private var showBurst = false
    
    var body: some View {
        HStack(alignment: .center, spacing: 30) {
            // MARK: - Simple
            Image(systemName: SimpleLiked ? "heart.fill" : "heart")
                .font(.system(size: 50))
                .foregroundColor(SimpleLiked ? .pink : .gray)
                .scaleEffect(SimpleLiked ? 1.25 : 1.0)
                .animation(.spring(response: 0.25, dampingFraction: 0.5), value: SimpleLiked)
                .onTapGesture {
                    SimpleLiked.toggle()
                }
            
            // MARK: - Bounce
            Image(systemName: BounceLike ? "heart.fill" : "heart")
                .font(.system(size: 50))
                .foregroundColor(BounceLike ? .pink : .gray)
                .scaleEffect(scale)
                .onTapGesture {
                    BounceLike.toggle()

                    scale = 1.4
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.45)) {
                        scale = 1
                    }
                }
            
            // MARK: - Burst
            ZStack {
                if showBurst {
                    LikeBurst(color: .pink)
                }

                Image(systemName: BurstLike ? "heart.fill" : "heart")
                    .font(.system(size: 50))
                    .foregroundColor(BurstLike ? .pink : .gray)
            }
            .onTapGesture {
                BurstLike.toggle()
                showBurst = true

                DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                    showBurst = false
                }
            }
        }
    }
}

struct LikeBurst: View {
    let color: Color
    @State private var animate = false

    var body: some View {
        ZStack {
            ForEach(0..<8) { i in
                Rectangle()
                    .fill(color)
                    .frame(width: 2, height: 10)
                    .offset(y: -34)
                    .rotationEffect(.degrees(Double(i) * 45))
                    .opacity(animate ? 0 : 1)
            }
        }
        .scaleEffect(animate ? 1.6 : 0.8)
        .animation(.easeOut(duration: 0.3), value: animate)
        .onAppear {
            animate = true
        }
    }
}
