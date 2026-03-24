//
//  GlassyButtonView.swift
//  SwiftUI-Animations
//
/// Created by `C S Prasad` on `18/07/23`
///
/// ### Social
/// `Instagram` : ``@csprasad.ios`` • `X` : ``@csprasad_ios`` • `Github` : ``@csprasad``
///

import SwiftUI

struct GlassyButtonView: View {
    @State private var isEnabled = false
    
    @State var gradientOnOne = Gradient.Stop(color: Color(red: 0.94, green: 0.94, blue: 0.96), location: 0.00)
    @State var gradientOnTwo = Gradient.Stop(color: Color(red: 0.87, green: 0.88, blue: 0.91), location: 1.00)
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background
                LinearGradient(
                    gradient: isEnabled ?
                        Gradient(colors: [Color(hex: "#C3CBDC"), Color(hex: "#9FA4C4")]) :
                        Gradient(colors: [Color.black.opacity(0.6), Color.black.opacity(0.8)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                VStack(spacing: 60) {
                    Toggle(isOn: $isEnabled) {
                        Text("Light / Dark mode")
                            .foregroundColor(isEnabled ? .black : .white)
                            .font(.system(size: 24, weight: .bold, design: .monospaced))
                    }
                    .toggleStyle(FinalGlassyButton())
                }
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
            }
        }
        .navigationBarHidden(true)
    }
    
    let gradientOffOne = Gradient.Stop(color: .white.opacity(0.5), location: 0)
}
struct FinalGlassyButton: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(spacing: 40){
            configuration.label
            
            Rectangle()
                // Track Color Updated
                .fill(configuration.isOn ? Color(hex: "#9FA4C4") : Color(hex: "#2D3436").opacity(0.4))
                .border(configuration.isOn ? Color.white.opacity(0.3) : Color.clear, width: 2)
                .cornerRadius(20)
                .overlay {
                    Rectangle()
                        // Thumb Color Updated: Frosted Mint/Blue
                        .fill(Color(hex: "#B3CDD1"))
                        .cornerRadius(30)
                        .frame(width: 30)
                        .padding(5)
                        .offset(x: configuration.isOn ? 10 : -10)
                        .shadow(color: Color.white.opacity(0.5), radius: 2, x: 0, y: 0)
                }
                .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 2)
                .frame(width: 60, height: 200)
                .onTapGesture {
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                        configuration.isOn.toggle()
                    }
                }
        }
    }
}
