//
//  causticLightEffect.swift
//  SwiftUI-Animations
//
//  Created by CS Prasad on 03/08/24.
//

import SwiftUI

struct causticLightEffect: View {
    @State private var move = false

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            // Layer 1
            LinearGradient(
                gradient: Gradient(colors: [.white.opacity(0.2), .clear]),
                startPoint: .top,
                endPoint: .bottom
            )
            .mask(
                CausticPattern()
                    .scaleEffect(x: 1.5, y: 1.5)
            )
            .rotationEffect(.degrees(move ? 360 : 0))
            .animation(
                Animation.linear(duration: 10)
                    .repeatForever(autoreverses: false),
                value: move
            )
            
            // Layer 2
            LinearGradient(
                gradient: Gradient(colors: [.clear, .white.opacity(0.2)]),
                startPoint: .leading,
                endPoint: .trailing
            )
            .mask(
                CausticPattern()
                    .scaleEffect(x: 1.5, y: 1.5)
            )
            .rotationEffect(.degrees(move ? -360 : 0))
            .animation(
                Animation.linear(duration: 12)
                    .repeatForever(autoreverses: false),
                value: move
            )
        }
        .onAppear {
            move = true
        }
    }
}

struct CausticPattern: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Draw a custom pattern resembling caustics
        for i in stride(from: 0, to: rect.width, by: rect.width / 10) {
            let xOffset = CGFloat.random(in: -20...20)
            let yOffset = CGFloat.random(in: -20...20)
            path.addEllipse(in: CGRect(x: i + xOffset, y: i + yOffset, width: 100, height: 100))
        }
        
        return path
    }
}



struct causticLightEffect_Previews: PreviewProvider {
    static var previews: some View {
        causticLightEffect()
    }
}
