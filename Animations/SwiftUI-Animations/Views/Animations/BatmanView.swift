//
//  BatmanView.swift
//  SwiftUI-Animations
//
//  Created by CS Prasad on 14/07/23.
//

import SwiftUI

struct BatmanView: View {
    var body: some View {
        BatmanFinalView()
    }
}

struct BatmanView_Previews: PreviewProvider {
    static var previews: some View {
        BatmanView()
    }
}


























struct BatmanFinalView: View {
    @State var CloudOffset: CGFloat = 300
    @State var CloudOffset1: CGFloat = 300
    @State var CityOffset: CGFloat = 980
    @State var CircleScale: CGFloat = 0
    @State var isAnimating = false
    @State var isFlashing = false
    @State var isFlashing1 = false
    @State var bgColor = Color.black
    @State var textOffset: CGFloat = 0
    
    
    @State var endPath: CGFloat = 0
    @State var isFilled = false
    
    var body: some View {
        ZStack {
            bgColor
            thunderOne()
            thunderTwo()
            ZStack {
                Bat()
                    .trim(from: 0, to: endPath)
                    .stroke(.white, lineWidth: 2)

                Bat()
                    .fill(.white)
                    .opacity(isFilled ? 1 : 0)
            }
            .frame(width: 300, height: 200)
            .onAppear {
                withAnimation(Animation.easeInOut(duration: 5)) {
                    self.endPath = 1
                }

                withAnimation(.easeInOut(duration: 2).delay(4)) {
                    self.isFilled = true
                }
            }
            
            VStack {
                HStack {
                    Image("Bats")
                        .resizable()
                        .frame(width: 200, height: 120)
                    Image("Bats")
                        .resizable()
                        .frame(width: 200, height: 120)
                }
                Image("rain-in-the-city")
                    .resizable()
                    .frame(height: 980)
                    .ignoresSafeArea()
            }
            .offset(y: CityOffset)
            .onAppear {
                withAnimation(.easeIn(duration: 5).delay(8)) {
                    self.CityOffset = -120
                }
            }
            
                            Image("Batman")
                .resizable()
                .frame(width: 400, height: 250)
                .offset(x: 0, y: -100)
                .scaleEffect(CircleScale)
                .onAppear {
                    withAnimation(.easeOut(duration: 7).delay(13)) {
                        CircleScale = 1.0
                    }
                }.ignoresSafeArea()
            
            
            Text("\"I'm not going to kill you. I want you to do me a favor. I want you to tell all your friends about me.\"")
                .padding(EdgeInsets(top: 10, leading: 50, bottom: 10, trailing: 40))
                .background(Color.white.opacity(0.6))
                .offset(x: 0, y: 120)
                .scaleEffect(textOffset)
                .foregroundColor(.black)
                .font(.system(size: 25, weight: .bold, design: .monospaced))
                .multilineTextAlignment(.center)
                .opacity(0.8)
                .onAppear {
                    withAnimation(.linear(duration: 0.1).delay(20)) {
                        textOffset = 1.0
                    }
                }
        }.ignoresSafeArea()
    }
    
    func thunderOne() -> some View {
        HStack(alignment: .top){
            Image("thunder")
                Image("thunder")
                    .padding(.top, 50)
                Image("thunder")
                Image("thunder")
                    .padding(.top, 50)
            
        }
        .frame(width: .infinity, height: 100)
        .offset(x: 0, y: -300)
        .offset(x: 0, y: 0)
        .opacity(isFlashing ? 0 : 1)
        .onAppear {
            withAnimation(.easeOut(duration: 0.5).delay(0.1).repeatForever()) {
                bgColor = .black.opacity(0.8)
                isFlashing = true
            }
        }
    }
    
    func thunderTwo() -> some View {
        HStack(alignment: .top){
            Image("thunder-bw")
                .resizable()
            Image("thunder-bw")
                .resizable()
                .padding(.top, 50)
            Image("thunder-bw")
                .resizable()
            Image("thunder-bw")
                .resizable()
                .padding(.top, 30)
        }
        .frame(width: .infinity, height: 160)
        .offset(x: 0, y: -300)
        .offset(x: 0, y: 0)
        .opacity(isFlashing1 ? 0 : 1)
        .onAppear {
            withAnimation(.easeOut(duration: 0.1).delay(1).repeatForever()) {
                bgColor = .white
                isFlashing1 = true
            }
        }
    }
}

