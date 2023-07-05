//
//  LayerMaskUIView.swift
//  Gradient
//
//  Created by CS Prasad on 01/07/23.
//

import SwiftUI

struct LayerMaskUIView: View {
    var body: some View {
        LayerMaskFinalView()
    }
}

struct LayerMaskUIView_Previews: PreviewProvider {
    static var previews: some View {
        LayerMaskUIView()
    }
}





















struct LayerMaskFinalView: View  {
    let shapeHeight: CGFloat = 400
    let shapeWidth: CGFloat = 80
    @State private var shapeOffset: CGFloat = 600
    @State private var isAnimated = false
    @State private var isZoomed = false
    @State private var imageName: String = "gigi"
    
    @State private var isAnimated1 = false
    @State private var isAnimated2 = false
    @State private var isAnimated3 = false
    
    @State private var shapeOffset1: CGFloat = 600
    @State private var shapeOffset2: CGFloat = 600
    @State private var shapeOffset3: CGFloat = 600
        
    var body: some View {
        ZStack {
            Color.gray.opacity(0.2)
                .blur(radius: 5)
            VStack(){
                Image(imageName)
                    .mask(
                        HStack(spacing: 10) {
                            Rectangle()
                                .frame(width: shapeWidth, height: shapeHeight)
                                .clipShape(CustomCorner(radius: 50, corners: [.topRight, .bottomLeft]))
                                .offset(x: 0, y: shapeOffset)
                                .animation(Animation.linear(duration: 1), value: isAnimated)
                                .onAppear {
                                    shapeOffset = 80
                                    isAnimated = true
                                }
                            Rectangle()
                                .frame(width: shapeWidth, height: shapeHeight)
                                .clipShape(CustomCorner(radius: 50, corners: [.topRight, .bottomLeft]))
                                .offset(x: 0, y: shapeOffset1)
                                .animation(Animation.linear(duration: 1), value: isAnimated1)
                                .onAppear {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                        shapeOffset1 = 30
                                        isAnimated1 = true
                                    }
                                }
                            Rectangle()
                                .frame(width: shapeWidth, height: shapeHeight)
                                .clipShape(CustomCorner(radius: 50, corners: [.topRight, .bottomLeft]))
                                .offset(x: 0, y: shapeOffset2)
                                .animation(Animation.linear(duration: 1), value: isAnimated2)
                                .onAppear {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                        shapeOffset2 = -20
                                        isAnimated2 = true
                                    }
                                }
                            Rectangle()
                                .frame(width: shapeWidth, height: shapeHeight)
                                .clipShape(CustomCorner(radius: 50, corners: [.topRight, .bottomLeft]))
                                .offset(x: 0, y: shapeOffset3)
                                .animation(Animation.linear(duration: 1), value: isAnimated3)
                                .onAppear {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                        shapeOffset3 = -70
                                        isAnimated3 = true
                                    }
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                        imageName = "tiger_02"
                                    }
                                    
                                }
                            }
                    )
            }
        }.ignoresSafeArea()
    }
}


struct CustomCorner: Shape {
    var radius: CGFloat
    var corners: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
