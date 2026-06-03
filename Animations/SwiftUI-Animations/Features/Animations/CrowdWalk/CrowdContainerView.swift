//
//  CrowdContainerView.swift
//  SwiftUI-Animations
//
/// Created by `C S Prasad` on `07/01/26`
///
/// ### Social
/// `Instagram` : ``@csprasad.ios`` • `X` : ``@csprasad_ios`` • `Github` : ``@csprasad``
///

import SwiftUI

struct CrowdContainerView: View {
    var body: some View {
        ZStack {
            VStack {
                AnimationCreditView()
                    .padding(.bottom, 260)
            }
            .frame(maxWidth: .infinity)

            if let uiImage = UIImage(named: "peeps"),
               let cgImage = uiImage.cgImage {

                let images = slicePeeps(
                    image: cgImage,
                    rows: 15,
                    cols: 4
                )

                CrowdView(slicedImages: images)
                    .ignoresSafeArea()
            } else {
                Text("Image not found")
            }
        }
    }

    /// Slice a sprite-sheet `CGImage` into a grid of tiles.
    /// - Parameters:
    ///   - image: The source image to be divided into tiles.
    ///   - rows: The number of slices across the image width (tiles per row).
    ///   - cols: The number of slices along the image height (tiles per column).
    /// - Returns: An array of cropped `CGImage` tiles ordered left-to-right, top-to-bottom.
    private func slicePeeps(image: CGImage, rows: Int, cols: Int) -> [CGImage] {
        let w = CGFloat(image.width) / CGFloat(rows)
        let h = CGFloat(image.height) / CGFloat(cols)

        return (0..<(rows * cols)).compactMap { index in
            let rect = CGRect(
                x: CGFloat(index % rows) * w,
                y: CGFloat(index / rows) * h,
                width: w,
                height: h
            )
            return image.cropping(to: rect)
        }
    }
}
