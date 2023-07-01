//
//  LoaderUIView.swift
//  Gradient
//
//  Created by CS Prasad on 30/06/23.
//

import SwiftUI

struct LoaderUIView: View {
    var body: some View {
        FinalLoaderView()
    }
}

struct LoaderUIView_Previews: PreviewProvider {
    static var previews: some View {
        LoaderUIView()
    }
}























struct FinalLoaderView: View {
    @State private var isAnimating = false
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                ForEach(0..<4) { index in
                    Circle()
                        .frame(width: 10, height: 10)
                        .foregroundColor(.white)
                        .offset(y: isAnimating ? -30 : 0)
                        .rotationEffect(isAnimating ? .degrees(Double(index) * 90) : .degrees(0))
                        .animation(Animation.easeInOut(duration: 1.0).repeatForever().delay(Double(index) * 0.3))
                }
            }
        }
        .onAppear {
            isAnimating = true
        }
    }
}
