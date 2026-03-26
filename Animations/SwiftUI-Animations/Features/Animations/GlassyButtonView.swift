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
    
    var body: some View {
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
                        .foregroundColor(isEnabled ? Color(hex: "#2D3436") : Color(hex: "#9FA4C4"))
                        .font(.system(size: 35, weight: .black, design: .rounded))
                        .kerning(3)
                }
                .toggleStyle(GlassyButton())
            }
        }
    }
}


struct GlassyButton: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(spacing: 40){
            configuration.label
            
            Rectangle()
                .fill(configuration.isOn ? Color(hex: "#9FA4C4") : Color(hex: "#2D3436").opacity(0.4))
                .border(configuration.isOn ? Color.white.opacity(0.3) : Color.clear, width: 2)
                .cornerRadius(20)
                .overlay {
                    Rectangle()
                        // Thumb Color: Frosted Mint/Blue
                        .fill(Color(hex: "#B3CDD1"))
                        .cornerRadius(30)
                        .frame(width: 30)
                        .padding(5)
                        .offset(x: configuration.isOn ? 10 : -10)
                }
                .shadow(color: Color.primary.opacity(0.5), radius: 2)
                .frame(width: 60, height: 200)
                .onTapGesture {
                    withAnimation(.spring(response: 0.4, dampingFraction: 0.6)) {
                        configuration.isOn.toggle()
                    }
                }
        }
    }
}
