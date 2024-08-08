//
//  causticLightEffect.swift
//  SwiftUI-Animations
//
//  Created by CS Prasad on 03/08/24.
//

import SwiftUI

struct octopusMoveEffect: View {
    @State private var animate = false
    let circleCount = 10
    let layerCount = 10
    let maxRadius: CGFloat = 150

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            ForEach(0..<layerCount, id: \.self) { layer in
                ForEach(0..<circleCount, id: \.self) { index in
                    Circle()
                        .fill(Color.white)
                        .frame(width: 10, height: 10)
                        .offset(x: animate ? offset(for: index, in: layer).x : 0,
                                y: animate ? offset(for: index, in: layer).y : 0)
                        .animation(
                            Animation.linear(duration: 2)
                                .repeatForever(autoreverses: true)
                                .delay(Double(index + layer * circleCount) * 0.02),
                            value: animate
                        )
                }
            }
        }
        .onAppear {
            animate = true
        }
    }
    
    func offset(for index: Int, in layer: Int) -> CGPoint {
        let angle = 2 * .pi / Double(circleCount) * Double(index)
        let radius = maxRadius / CGFloat(layerCount) * CGFloat(layer + 1)
        let x = cos(angle) * radius
        let y = sin(angle) * radius
        return CGPoint(x: x, y: y)
    }
}




struct octopusMoveEffect_Previews: PreviewProvider {
    static var previews: some View {
        octopusMoveEffect()
    }
}
