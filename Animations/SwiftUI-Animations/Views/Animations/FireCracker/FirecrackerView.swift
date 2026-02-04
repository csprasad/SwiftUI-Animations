//
//  FirecrackerView.swift
//  SwiftUI-Animations
//
//  Created by codeAlligator on 30/01/26.
//

import SwiftUI

struct FirecrackerView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 6)
            .fill(
                LinearGradient(
                    colors: [.red, .orange],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .frame(width: 140, height: 40)
            .overlay(
                Text("⚡️")
                    .font(.title2),
                alignment: .center
            )
    }
}

