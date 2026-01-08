//
//  CrowdContainerView.swift
//  SwiftUI-Animations
//
//  Created by codeAlligator on 07/01/26.
//

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

                CrowdView(
                    image: cgImage,
                    sprites: sliceSprites(
                        image: cgImage,
                        rows: 15,
                        cols: 4
                    )
                )
                .ignoresSafeArea()
            } else {
                Text("Image not found")
            }
            
        }
    }
    
    // MARK: Helper function to slice peeps image rect
    func sliceSprites(image: CGImage, rows: Int, cols: Int) -> [CGRect] {
        let w = CGFloat(image.width) / CGFloat(rows)
        let h = CGFloat(image.height) / CGFloat(cols)

        return (0..<(rows * cols)).map {
            CGRect(
                x: CGFloat($0 % rows) * w,
                y: CGFloat($0 / rows) * h,
                width: w,
                height: h
            )
        }
    }
}
