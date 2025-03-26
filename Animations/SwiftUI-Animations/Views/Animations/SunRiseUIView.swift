//
//  SunRiseUIView.swift
//  Gradient
//
//  Created by CS Prasad on 30/06/23.
//

import SwiftUI

struct SunRiseUIView: View {
    @State private var liquidLevel: CGFloat = 0.5
    @State private var sunOffset: CGFloat = 200
    @State private var isAnimated = false
    @State private var backgroundColor = Color.black

    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                SunView()
                    .foregroundColor(.yellow)
                    .offset(y: sunOffset)
                    .animation(Animation.easeInOut(duration: 5), value: isAnimated)
                    .onAppear {
                        sunOffset = -250
                        isAnimated = true
                        withAnimation(.easeInOut(duration: 6)) {
                            backgroundColor = Color.black.opacity(0)
                        }
                    }
                    .rotation3DEffect(Angle(degrees: 0), axis: (x: 45, y: 360, z: 0))
                TreeView()
                    .padding()
            }
            Rectangle()
                .foregroundColor(backgroundColor)
                .frame(width: geometry.size.width, height: geometry.size.height + 200)
                .ignoresSafeArea()
    }
    }
}

struct SunView: View {
    var body: some View {
        Image(systemName: "sun.max.fill")
            .resizable()
            .frame(width: 100, height: 100)
    }
}


struct TreeView: View {
    @State private var textPosition: CGPoint = .zero
    let texts = ["☁","☁","☁","☁","☁","☁","☁","☁",]
    var body: some View {
        ZStack{
            ZStack {
                Text("☁")
                    .font(.system(size: 100))
                    .offset(x: 100, y: -290)
                Text("☁")
                    .font(.system(size: 80))
                    .offset(x: -100, y: -170)
                Text("☁")
                    .font(.system(size: 30))
                    .offset(x: -80, y: -270)
                Text("☁")
                    .font(.system(size: 20))
                    .offset(x: 100, y: -130)
                GeometryReader { geometry in
                    ForEach(texts, id: \.self) { cloud in
                        Text(cloud)
                            .position(randomPosition(in: geometry))
                    }
                }
            }
            VStack {
                Image("sand")
                    .resizable()
                    .frame(width: 800, height: 800)
                    .offset(x:0,y:250)
            }.padding(-290)
            HStack {
                Image("river")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 380, height: 420)
                    .offset(x:-190,y:210)
                    .rotationEffect(Angle(degrees: -55))
            }
            
            HStack {
                Text("🌋")
                    .font(.system(size: 180))
                    .offset(x: 0, y: 10)
            }
            
            HStack(spacing: 20) {
                Text("🏔")
                    .font(.system(size: 280))
                Text("🏔")
                    .font(.system(size: 300))
            }.padding(-120)
            
            HStack(spacing: 0){
                Text("⛺").font(.system(size: 150))
                    .offset(x:-100, y: 250)
                Text("🏌️‍♀️").font(.system(size: 50))
                    .offset(x:-100, y: 300)
            }
        }
    }
    
    func randomPosition(in geometry: GeometryProxy) -> CGPoint {
            let screenWidth = geometry.size.width
            let randomX = CGFloat.random(in: 0...screenWidth)
        let randomY = CGFloat.random(in: 0...(geometry.safeAreaInsets.leading))
            return CGPoint(x: randomX, y: randomY)
        }
}
