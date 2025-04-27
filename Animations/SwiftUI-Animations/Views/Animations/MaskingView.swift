//
//  MaskingView.swift
//  SwiftUI-Animations
//
//  Created by CS Prasad on 27/04/25.
//

import SwiftUI

struct MaskingView: View {
    
    @State private var isInverted = false
    
    var body: some View {
        ZStack {
            isInverted ? AnyView(InvertedMask()) : AnyView(NormalMask())

            //Button to toggle normal masking & inverted masking
            VStack {
                Spacer()
                Button(action: {
                    isInverted.toggle()
                }) {
                    Text(isInverted ? "Switch to normal mask" : "Switch to inverted Mask")
                        .padding()
                        .font(.headline)
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.orange]), startPoint: .leading, endPoint: .trailing))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.bottom, 20)
            }
        }
        .compositingGroup()
                .shadow(color: .gray, radius: 15, x: -10, y: 10)
    }
}



//MARK: - Normal Mask
struct NormalMask: View {
    var body: some View {
        Image("sequoia")
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
            .mask {
                Image(systemName: "apple.logo")
                    .font(.system(size: 300))
            }
            .shadow(radius: 10)
    }
}

//MARK: - Inverted Mask
struct InvertedMask: View {
    var body: some View {
        Image("sequoia")
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()

        VStack {
            Spacer()
            Image(systemName: "apple.logo")
                .font(.system(size: 300))
                .blendMode(.destinationOut)
            Spacer()
        }
    }
}
