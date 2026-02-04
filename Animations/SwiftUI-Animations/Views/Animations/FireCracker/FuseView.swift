//
//  FuseView.swift
//  SwiftUI-Animations
//
//  Created by codeAlligator on 30/01/26.
//

import SwiftUI

struct FuseView: View {
    let path: Path
    let burnProgress: CGFloat

    var body: some View {
        ZStack {
            // Remaining fuse
            path
                .trim(from: burnProgress, to: 1)
                .stroke(
                    Color.gray.opacity(0.7),
                    style: StrokeStyle(
                        lineWidth: 3,
                        lineCap: .round,
                        lineJoin: .round
                    )
                )


            // Burning fuse
            path
                .trim(from: 0, to: burnProgress)
                .stroke(
                    LinearGradient(
                        colors: [.yellow, .orange],
                        startPoint: .leading,
                        endPoint: .trailing
                    ),
                    style: StrokeStyle(lineWidth: 4, lineCap: .round)
                )
                .shadow(color: .orange, radius: 6)
        }
    }
}

