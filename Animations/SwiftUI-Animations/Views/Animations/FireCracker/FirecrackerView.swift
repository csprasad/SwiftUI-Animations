//
//  FirecrackerView.swift
//  SwiftUI-Animations
//
/// Created by `C S Prasad` on `30/01/26`
///
/// ### Social
/// `Instagram` : ``@csprasad.ios`` • `X` : ``@csprasad_ios`` • `Github` : ``@csprasad``
///

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

