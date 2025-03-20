//
//  RandomAnimationView.swift
//  Gradient
//
//  Created by CSPrasad on 25/06/23.
//

import SwiftUI

struct RandomView: View {
    var body: some View {
        RandomAnimationView()
    }
}

struct RandomView_Previews: PreviewProvider {
    static var previews: some View {
        RandomView()
    }
}



























struct RandomAnimationView: View {

//    var body: some View {
//            ZStack {
//                Color.black.edgesIgnoringSafeArea(.all)
//
//                VStack {
//                    ForEach(0..<4) { index in
//                        Circle()
//                            .frame(width: 10, height: 10)
//                            .foregroundColor(.white)
//                            .offset(y: isAnimating ? -30 : 0)
//                            .rotationEffect(isAnimating ? .degrees(Double(index) * 90) : .degrees(0))
//                            .animation(Animation.easeInOut(duration: 1.0).repeatForever().delay(Double(index) * 0.3))
//                    }
//                }
//            }
//            .onAppear {
//                isAnimating = true
//            }
//        }
    @State private var bubblefloating = false
    @State private var stoveMoving = false
    @State private var leftVaporizes = false
    @State private var middleVaporizes = false
    @State private var rightVaporizes = false
    let bg = Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
    let sausage = Gradient(colors: [.black, .white])

        var body: some View {
            ZStack {
                Rectangle().fill(Gradient(colors:[Color.white,Color.gray.opacity(0.2),Color.gray.opacity(0.5)]))
                    .ignoresSafeArea()
                
                    Image("vapor_middle") // Vapor Middle
                        .clipShape(Rectangle().offset(y: middleVaporizes ? 0 : 80))
                        .animation(Animation.timingCurve(0.68, -0.6, 0.32, 1.6).delay(0.2).speed(0.8).repeatForever(autoreverses: false))
                        .blur(radius: 20).blendMode(.plusDarker).offset(x: 60, y: -65)
                        .onAppear {
                            middleVaporizes.toggle()
                        }
                    
                    Image("vapor_right") // Vapor Right
                        .clipShape(Rectangle().offset(y: leftVaporizes ? 0 : 45))
                        .animation(Animation.timingCurve(0.68, -0.6, 0.32, 1.6).speed(0.9).repeatForever(autoreverses: false))
                        .blur(radius: 20).blendMode(.plusDarker).offset(x: 60, y: -65)
                        .onAppear {
                            rightVaporizes.toggle()
                        }
                
                
                VStack {
                    Image("pot")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .rotationEffect(.degrees(stoveMoving ? 0 : -30))
//                        .animation(Animation.timingCurve(0.68, -0.6, 0.32, 1.6).speed(0.9).repeatForever(autoreverses: false))
                        .animation(.interpolatingSpring(stiffness: 100, damping: 3).repeatForever(autoreverses: false))
                        .onAppear() {
                            self.stoveMoving.toggle()
                        }
                    
                    Image("stove")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        }.position(x: 200, y: 450)
                
                if bubblefloating {
                    ForEach(0..<6) { _ in
                        Leaf()
                            .animation(Animation.linear(duration: Double.random(in: 2.0...4.0)))
                    }
                }
            }
            .onAppear {
                bubblefloating = true
            }
    }
}


struct Leaf: View {
    @State private var position = CGPoint(x: 0, y: 0)

    var body: some View {
        Image("bubble")
            .resizable()
            .scaledToFit()
            .frame(width: 30, height: 30)
            .rotationEffect(.degrees(Double.random(in: -30...30)))
            .offset(x: position.x + 30, y: position.y + 10)
            .onAppear {
                let randomX = CGFloat.random(in: -50...100)
                let randomY = CGFloat.random(in: -200...0)
                position = CGPoint(x: randomX, y: randomY)
            }
            .animation(Animation.linear(duration: Double.random(in: 5.0...10.0)).repeatForever(autoreverses: false))
    }
}


