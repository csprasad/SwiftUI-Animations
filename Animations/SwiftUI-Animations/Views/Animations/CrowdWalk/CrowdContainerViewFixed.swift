//
//  PeepCanvasView.swift
//  SwiftUI-Animations
//
//  Created by codeAlligator on 07/01/26.
//

import SwiftUI

struct CrowdContainerViewFixed: View {
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

                CrowdViewFixed(slicedImages: images)
                    .ignoresSafeArea()
            } else {
                Text("Image not found")
            }
        }
    }
    
    // MARK: Helper Function to crop Peeps
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
