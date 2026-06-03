//
//  BatmanView.swift
//  SwiftUI-Animations
//
/// Created by `C S Prasad` on `14/07/23`
///
/// ### Social
/// `Instagram` : ``@csprasad.ios`` • `X` : ``@csprasad_ios`` • `Github` : ``@csprasad``
///

import SwiftUI

struct BatmanView: View {
    @State private var cloudOffset: CGFloat = 300
    @State private var cloudOffset1: CGFloat = 300
    @State private var cityOffset: CGFloat = 980
    @State private var circleScale: CGFloat = 0
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
            .offset(y: cityOffset)
            .onAppear {
                withAnimation(.easeIn(duration: 5).delay(8)) {
                    self.cityOffset = -120
                }
            }

                            Image("Batman")
                .resizable()
                .frame(width: 400, height: 250)
                .offset(x: 0, y: -100)
                .scaleEffect(circleScale)
                .onAppear {
                    withAnimation(.easeOut(duration: 7).delay(13)) {
                        circleScale = 1.0
                    }
                }.ignoresSafeArea()

            Text("\"I'm not going to kill you. I want you to do me a favor. Tell your friends about me. Every last one.\"")
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

    /// Renders a horizontal row of thunder images positioned near the top of the view and animated to flash.
    /// - Returns: A view containing four thunder images arranged horizontally; the view's opacity becomes `0` when `isFlashing` is `true`.
    /// - Note: When the view appears it starts a repeating animation that updates `bgColor` and `isFlashing` to produce the flashing effect.
    func thunderOne() -> some View {
        HStack(alignment: .top) {
            Image("thunder")
                Image("thunder")
                    .padding(.top, 50)
                Image("thunder")
                Image("thunder")
                    .padding(.top, 50)

        }
        .frame(maxWidth: .infinity, maxHeight: 100)
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

    /// Renders a horizontal group of black-and-white thunder images with a timed flash animation.
    /// 
    /// The view positions four resizable `thunder-bw` images in an `HStack` near the top of the screen and animates their visibility via `isFlashing1`.
    /// On appear, it starts a repeating ease-out animation (0.1s, 1s delay) that sets `bgColor = .white` and `isFlashing1 = true`, which drives the view's opacity.
    /// - Returns: A view containing four resizable `thunder-bw` images arranged horizontally, constrained to the top area and whose opacity is controlled by `isFlashing1`.
    func thunderTwo() -> some View {
        HStack(alignment: .top) {
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
        .frame(maxWidth: .infinity, maxHeight: 100)
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
