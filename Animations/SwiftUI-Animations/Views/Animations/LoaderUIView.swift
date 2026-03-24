//
//  LoaderUIView.swift
//  SwiftUI-Animations
//
/// Created by `C S Prasad` on `30/06/23`
///
/// ### Social
/// `Instagram` : ``@csprasad.ios`` • `X` : ``@csprasad_ios`` • `Github` : ``@csprasad``
///

import SwiftUI

struct LoaderUIView: View {
    var body: some View {
        FinalLoaderView()
    }
}

struct FinalLoaderView: View {
    @State private var isAnimating = false
    var body: some View {
        ZStack {
            VStack {
                ForEach(0..<4) { index in
                    Circle()
                        .frame(width: 10, height: 10)
                        .foregroundColor(.primary)
                        .offset(y: isAnimating ? -30 : 0)
                        .rotationEffect(isAnimating ? .degrees(Double(index) * 90) : .degrees(0))
                        .animation(.easeInOut(duration: 1.0).repeatForever().delay(Double(index) * 0.3), value: isAnimating)
                }
            }
        }
        .onAppear {
            isAnimating = true
        }
    }
}
