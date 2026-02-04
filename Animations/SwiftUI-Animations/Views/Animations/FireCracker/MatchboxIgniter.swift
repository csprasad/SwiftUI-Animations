//
//  MatchboxIgniter.swift
//  SwiftUI-Animations
//
//  Created by codeAlligator on 30/01/26.
//

import SwiftUI

struct MatchboxIgniter: View {
    var body: some View {
        if #available(iOS 16.0, *) {
            RoundedRectangle(cornerRadius: 8)
                .fill(.brown.gradient)
                .frame(width: 200, height: 60)
                .overlay(
                    Stripes()
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .opacity(0.4)
                )
        } else {
            // Fallback on earlier versions
        }
    }
}

struct Stripes: View {
    var body: some View {
        GeometryReader { geo in
            Path { path in
                for x in stride(from: 0, to: geo.size.width, by: 12) {
                    path.move(to: CGPoint(x: x, y: 0))
                    path.addLine(to: CGPoint(x: x + 12, y: geo.size.height))
                }
            }
            .stroke(.black.opacity(0.2), lineWidth: 2)
        }
    }
}
