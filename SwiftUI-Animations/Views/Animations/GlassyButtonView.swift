//
//  GlassyButtonView.swift
//  SwiftUI-Animations
//
//  Created by CS Prasad on 18/07/23.
//

import SwiftUI

struct GlassyButtonView: View {
    
    @State private var isLightOn = false
    @State private var isFanOn = false
    @State private var isRotating = 0.0

    
    @State var gradientOnOne = Gradient.Stop(color: Color(red: 0.94, green: 0.94, blue: 0.96), location: 0.00)
    @State var gradientOnTwo = Gradient.Stop(color: Color(red: 0.87, green: 0.88, blue: 0.91), location: 1.00)
    @State var startPTOnOne = UnitPoint(x: 0, y: 0)
    @State var startPTOnTwo = UnitPoint(x: 1, y: 1)
    
    @State var gradientOffOne = Gradient.Stop(color: .white.opacity(0.5), location: 0.00)
    @State var gradientOffTwo = Gradient.Stop(color: Color(red: 0.74, green: 0.83, blue: 0.76).opacity(0.5), location: 1.00)
    @State var startPTOffOne = UnitPoint(x: 0.97, y: 1)
    @State var startPTOffTwo = UnitPoint(x: 0.05, y: -0.05)
    
    // Light
    @State private var gestureOffset: CGFloat = 0
    
    
    var body: some View {
        ZStack {
            LinearGradient(gradient:isLightOn ? Gradient(colors: [Color(hex: "#C3CBDC"), Color(hex: "#9FA4C4")]) : Gradient(colors: [Color(hex: "#000").opacity(0.6), Color(hex: "#000").opacity(0.8)]), startPoint: .top, endPoint: .bottom).ignoresSafeArea()
            
            
            VStack(alignment: .leading, spacing: 60) {
                //MARK: - Toggle View
                HStack(alignment: .center, spacing: 80) {
                    //Light Switch
                    Toggle(isOn: $isLightOn) {
                        Text("Light Switch")
                            .foregroundColor(isLightOn ? .white : .black)
                    }
                    .toggleStyle(customToggle())
                    
                    //Fan Switch
                    VStack(alignment: .center, spacing: 0) {
                        Image("fan")
                            .font(.system(size: 28))
                            .rotationEffect(.degrees(isRotating))
                            .onAppear {
                                withAnimation(.linear(duration: 1)
                                        .speed(0.1).repeatForever(autoreverses: false)) {
                                    isRotating = 360.0
                                }
                            }
                        
                        Toggle(isOn: $isFanOn) {
                            Text("")
                                .foregroundColor(isLightOn ? .white : .black)
                        }
                        .toggleStyle(customToggle.init(height: 40))
                    }
                }
                .frame(width: 400, height: 400)


                //MARK: - Card View - Building
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


struct customToggle: ToggleStyle {
    //Toggle switch background attributes
    var height: CGFloat = 200
    var width: CGFloat = 60
    var bgViewCornerRadius: CGFloat = 20
    
    //Toggle switch roller Attribute
    var rollerFrame: CGFloat = 30
    var rollerCornerRadius: CGFloat = 30
    
    //Toggle color attributes
    var bgViewcolorString: String = "#9FA4C4"
    var rollerColorString: String = "#B3CDD1"
    
    //Toggle builder function
    func makeBody(configuration: Configuration) -> some View {
 
        VStack(spacing: 40){
            configuration.label
            Rectangle()
                .fill(configuration.isOn ? Color(hex: bgViewcolorString) : Color(hex: "#000").opacity(0.2))
                .border(configuration.isOn ? Color(hex: bgViewcolorString).opacity(0.5) : Color(hex: "#000").opacity(0), width: 5)
                .cornerRadius(bgViewCornerRadius)
                .overlay {
                    
                    Rectangle()
                        .fill(configuration.isOn ? Color(hex: rollerColorString) : Color(hex: rollerColorString).opacity(0.4))
                        .cornerRadius(rollerCornerRadius)
                        .frame(width: rollerFrame)
                        .padding(5)
                        .offset(x: configuration.isOn ? 10 : -10)
                        .shadow(color: Color(hue: 0.667, saturation: 0.0, brightness: 0.993).opacity(0.5), radius: 2, x: 0, y: 0)
                        
                        
                }
                .shadow(color: Color(hue: 0.667, saturation: 0.0, brightness: 0.0).opacity(0.5), radius: 3, x: 0, y: 0)
                .frame(width: width, height: height)
                .onTapGesture {
                    withAnimation(.spring()) {
                        configuration.isOn.toggle()
                    }
                }
        }
    }
    
}


