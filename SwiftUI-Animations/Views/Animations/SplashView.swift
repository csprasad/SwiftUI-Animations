//
//  SplashView.swift
//  SwiftUI-Animations
//
//  Created by CS Prasad on 16/07/23.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        FinalSplashView()
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}






















struct FinalSplashView: View {
    @State var isActive = false
    @State var lightScale: CGFloat = 0.45
    @State var CircleBG: Color = .white
    var body: some View {
        
        ZStack {
            Spacer()
            if self.isActive {
 //                BatmanView()
             } else {
                 Circle()
                     .foregroundColor(.white)
                     .overlay {
                             Circle()
                             .frame(width: 350, height: 350)
                             .foregroundColor(.init(hex: "#D2CED2"))
                             .shadow(color: .white, radius: 8)
                             .scaleEffect(lightScale)
                             .overlay {
                                 Circle()
                                 .frame(width: 300, height: 300)
                                 .foregroundColor(.init(hex: "#A4A0A4"))
                                 .shadow(color: .white, radius: 8)
                                 .scaleEffect(lightScale)
                                 .overlay {
                                     Circle()
                                     .frame(width: 250, height: 250)
                                     .foregroundColor(.init(hex: "#797579"))
                                     .shadow(color: .white, radius: 8)
                                     .scaleEffect(lightScale)
                                     .overlay {
                                         Circle()
                                         .frame(width: 200, height: 200)
                                         .foregroundColor(.init(hex: "#504C50"))
                                         .shadow(color: .white, radius: 8)
                                         .scaleEffect(lightScale)
                                         .overlay {
                                             Circle()
                                             .frame(width: 150, height: 150)
                                             .shadow(color: .white, radius: 8)
                                             .foregroundColor(.black)
                                             .scaleEffect(lightScale)
                                         }
                                     }
                                 }
                             }
                             .onAppear {
                                 withAnimation(.spring(response: 0.9, dampingFraction: 1, blendDuration: 5).repeatForever()) {
                                     lightScale = 1
                                 }
                             }
                     }
                 
                 Circle()
                     .frame(width: 150, height: 150)
                     .foregroundColor(.black.opacity(0.4))
                     .shadow(color: .white, radius: 5)
                     .overlay {
                         Image("Profile")
                             .resizable()
                             .cornerRadius(150/2)
                     }
             }

                    Text("@CSPrasad_iOS")
                        .padding(EdgeInsets(top: 10, leading: 50, bottom: 10, trailing: 40))
                        .background(Color.black.opacity(0.2))
                        .offset(x: 0, y: 250)
                        .foregroundColor(.black)
                        .font(.system(size: 25, weight: .bold, design: .monospaced))
                        .multilineTextAlignment(.center)
                        .opacity(0.5)
            
        }
//        .onAppear {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
//                withAnimation {
//                    self.isActive = true
//                }
//            }
//        }
    }
}
