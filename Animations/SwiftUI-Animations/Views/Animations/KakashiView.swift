//
//  KakashiView.swift
//  SwiftUI-Animations
//
//  Created by CS Prasad on 15/07/23.
//

import SwiftUI

struct KakashiView: View {
    // MARK:- variables
    @State var resetStrokes: Bool = true
    @State var strokeStart: CGFloat = 0
    @State var strokeEnd: CGFloat = 0
    
    let gradient = Gradient(colors: [.black, .pink])

    
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            KakashiShape()
                .stroke(style: StrokeStyle(lineWidth: 2.5, lineCap: .round, lineJoin: .round, miterLimit: 5))
                .foregroundColor(Color.white)
                .opacity(0.35)
            KakashiShape()
                .trim(from: strokeStart, to: strokeEnd)
                .stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round, miterLimit: 10))
                .foregroundColor(.white)
//                .background(LinearGradient(gradient: gradient, startPoint: .leading, endPoint: .topTrailing))
                .onAppear() {
                    Timer.scheduledTimer(withTimeInterval: 0.35, repeats: true) { timer in
                        if (self.strokeEnd >= 1) {
                            if (self.resetStrokes) {
                                Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
                                    self.strokeEnd = 0
                                    self.strokeStart = 0
                                    self.resetStrokes.toggle()
                                }
                                self.resetStrokes = false
                            }
                        }
                        withAnimation(Animation.easeOut(duration: 0.5)) {
                            self.strokeEnd += 0.1
                            self.strokeStart = self.strokeEnd - 0.3
                        }
                    }
                }
        }
    }
}

struct KakashiView_Previews: PreviewProvider {
    static var previews: some View {
        KakashiView()
    }
}

