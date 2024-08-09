//
//  GlassyButtonView.swift
//  SwiftUI-Animations
//
//  Created by CS Prasad on 18/07/23.
//

import SwiftUI

struct GlassyButtonView: View {
    
    @State private var isEnabled = false
    
    @State var gradientOnOne = Gradient.Stop(color: Color(red: 0.94, green: 0.94, blue: 0.96), location: 0.00)
    @State var gradientOnTwo = Gradient.Stop(color: Color(red: 0.87, green: 0.88, blue: 0.91), location: 1.00)
    @State var startPTOnOne = UnitPoint(x: 0, y: 0)
    @State var startPTOnTwo = UnitPoint(x: 1, y: 1)
    
    @State var gradientOffOne = Gradient.Stop(color: .white.opacity(0.5), location: 0.00)
    @State var gradientOffTwo = Gradient.Stop(color: Color(red: 0.74, green: 0.83, blue: 0.76).opacity(0.5), location: 1.00)
    @State var startPTOffOne = UnitPoint(x: 0.97, y: 1)
    @State var startPTOffTwo = UnitPoint(x: 0.05, y: -0.05)
    
    var body: some View {
        ZStack {
            LinearGradient(gradient:isEnabled ? Gradient(colors: [Color(hex: "#C3CBDC"), Color(hex: "#9FA4C4")]) : Gradient(colors: [Color(hex: "#000").opacity(0.6), Color(hex: "#000").opacity(0.8)]), startPoint: .top, endPoint: .bottom).ignoresSafeArea()
            VStack(spacing: 60) {
                
                Toggle(isOn: $isEnabled) {
                    Text("Light / Dark mode")
                        .foregroundColor(isEnabled ? .white : .black)
                        .font(.system(size: 24, weight: .bold, design: .monospaced))
                        .padding(.bottom)
                }
                .toggleStyle(FinalGlassyButton())
                
                HStack(alignment: .bottom, spacing: 10) {
                    Circle()
                        .foregroundColor(.clear)
                        .frame(width: 148, height: 148)
                        .background(
                            LinearGradient(
                                stops: [
                                    gradientOffOne,
                                    gradientOffTwo,
                                ],
                                startPoint: startPTOffOne,
                                endPoint: startPTOffTwo
                            )
                        )
                    .cornerRadius(20)
                    Circle()
                        .foregroundColor(.clear)
                        .frame(width: 148, height: 148)
                        .background(
                            LinearGradient(
                                stops: [
                                    gradientOnOne,
                                    gradientOnTwo,
                                ],
                                startPoint: startPTOnOne,
                                endPoint: startPTOnTwo
                            )
                        )
                    .cornerRadius(20)
                    Circle()
                        .foregroundColor(.clear)
                        .frame(width: 148, height: 148)
                        .background(
                            LinearGradient(
                                stops: [
                                    gradientOffOne,
                                    gradientOffTwo,
                                ],
                                startPoint: startPTOffOne,
                                endPoint: startPTOffTwo
                            )
                            .blendMode(isEnabled ? .plusLighter : .plusDarker)
                        )
                    .cornerRadius(20)
                    
                }
        }
            }
    }
}

struct GlassyButtonView_Previews: PreviewProvider {
    static var previews: some View {
        GlassyButtonView()
    }
}


struct FinalGlassyButton: ToggleStyle {
    
    var onImage = "Bat"
    var offImage = "Bats"
 
    func makeBody(configuration: Configuration) -> some View {
 
        VStack(spacing: 40){
            configuration.label
            Rectangle()
                .fill(configuration.isOn ? Color(hex: "#9FA4C4") : Color(hex: "#000").opacity(0.2))
                .border(configuration.isOn ? Color(hex: "#9FA4C4").opacity(0.5) : Color(hex: "#000").opacity(0), width: 5)
                .cornerRadius(20)
                .overlay {
                    
                    Rectangle()
                        .fill(configuration.isOn ? Color(hex: "#B3CDD1") : Color(hex: "#B3CDD1").opacity(0.4))
                        .cornerRadius(30)
                        .frame(width: 30)
                        .padding(5)
                        .offset(x: configuration.isOn ? 10 : -10)
                        .shadow(color: Color(hue: 0.667, saturation: 0.0, brightness: 0.993).opacity(0.5), radius: 2, x: 0, y: 0)
                        
                        
                }
                .shadow(color: Color(hue: 0.667, saturation: 0.0, brightness: 0.0).opacity(0.5), radius: 3, x: 0, y: 0)
                .frame(width: 60, height: 200)
                .onTapGesture {
                    withAnimation(.spring()) {
                        configuration.isOn.toggle()
                    }
                }
        }
    }
    
}
