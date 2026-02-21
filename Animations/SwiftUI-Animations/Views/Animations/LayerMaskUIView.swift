//
//  LayerMaskUIView.swift
//  SwiftUI-Animations
//
/// Created by `C S Prasad` on `01/07/23`
///
/// ### Social
/// `Instagram` : ``@csprasad.ios`` • `X` : ``@csprasad_ios`` • `Github` : ``@csprasad``
///

import SwiftUI

struct LayerMaskUIView: View {
    let shapeHeight: CGFloat = 400
    let shapeWidth: CGFloat = 80
    
    @State private var shapeOffsets: [CGFloat] = [600, 600, 600, 600]
    @State private var imageName: String = "gigi"

    let delays: [Double] = [0.0, 0.5, 1.0, 1.5]
    let finalOffsets: [CGFloat] = [80, 30, -20, -70]

    var body: some View {
        ZStack {
            Image(imageName)
                .ignoresSafeArea()
                .mask(
                    HStack(spacing: 10) {
                        ForEach(0..<4, id: \.self) { index in
                            Rectangle()
                                .frame(width: shapeWidth, height: shapeHeight)
                                .clipShape(CustomCorner(radius: 50, corners: [.topRight, .bottomLeft]))
                                .offset(y: shapeOffsets[index])
                                .animation(.linear(duration: 1), value: shapeOffsets[index])
                                .onAppear {
                                    animateShape(index)
                                }
                        }
                    }
                )
        }
    }
    
    private func animateShape(_ index: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delays[index]) {
            shapeOffsets[index] = finalOffsets[index]
        }
        
        if index == 3 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                imageName = "tiger_02"
            }
        }
    }
}

struct CustomCorner: Shape {
    var radius: CGFloat
    var corners: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
