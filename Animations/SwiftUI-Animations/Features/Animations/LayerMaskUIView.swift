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
    // MARK: - Constants
    let shapeHeight: CGFloat = 400
    let shapeWidth: CGFloat = 80
    let delays: [Double] = [0.0, 0.5, 1.0, 1.5]
    let finalOffsets: [CGFloat] = [80, 30, -20, -70]

    // MARK: - State
    @State private var shapeOffsets: [CGFloat] = [600, 600, 600, 600]
    @State private var imageName: String = "gigi"

    var body: some View {
        ZStack {
            // The Masked Image
            GeometryReader { geo in
                Image(imageName)
                    .frame(width: geo.size.width, height: geo.size.height)
                    .clipped()
                    .mask(
                        maskingShapes(in: geo.size)
                    )
                    .shadow(color: .black.opacity(0.4), radius: 20)
            }
            .ignoresSafeArea()
        }
    }

    /// Builds the mask view containing four animated rounded rectangles centered within the provided size.
    /// - Parameters:
    ///   - size: The available container size used to frame and center the mask shapes.
    /// - Returns: A view with an HStack of four rounded rectangles (width `shapeWidth`, height `shapeHeight`) that are clipped on the top-right and bottom-left corners, positioned vertically using `shapeOffsets`, animated when those offsets change, and trigger their individual entrance animations on appear.
    private func maskingShapes(in size: CGSize) -> some View {
        HStack(spacing: 12) {
            ForEach(0..<4, id: \.self) { index in
                Rectangle()
                    .frame(width: shapeWidth, height: shapeHeight)
                    .clipShape(CustomCorner(radius: 50, corners: [.topRight, .bottomLeft]))
                    .offset(y: shapeOffsets[index])
                    .animation(.spring(response: 0.7, dampingFraction: 0.8), value: shapeOffsets[index])
                    .onAppear {
                        animateShape(index)
                    }
            }
        }
        .frame(width: size.width, height: size.height) // center
    }

    /// Animates the mask rectangle for the given index into its target vertical offset and, after the final rectangle, updates the displayed image.
    /// - Parameters:
    ///   - index: The index of the mask rectangle (0...3). The function schedules the rectangle's vertical offset to move to its configured final value after the staggered delay for that index. If `index` is 3, it additionally schedules the view's `imageName` to change to `"tiger_02"` after 3.5 seconds.
    private func animateShape(_ index: Int) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delays[index]) {
            shapeOffsets[index] = finalOffsets[index]
        }

        if index == 3 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                imageName = "tiger_02"
            }
        }
    }
}

struct CustomCorner: Shape {
    var radius: CGFloat
    var corners: UIRectCorner

    /// Creates a drawing path for the given rectangle with the specified corners rounded by `radius`.
    /// - Parameter rect: The rectangle in which the path is constructed.
    /// - Returns: A `Path` representing `rect` with the corners listed in `corners` rounded using `radius`.
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
