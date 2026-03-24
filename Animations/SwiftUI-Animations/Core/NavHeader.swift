//
//
//  NavHeader.swift
//  SwiftUI-Animations
//
/// Created by `C S Prasad` on `24/03/26`
///
/// ### Social
/// `Instagram` : ``@csprasad.ios`` • `X` : ``@csprasad_ios`` • `Github` : ``@csprasad``
///

import SwiftUI

struct NavHeader: View {
    let title: String
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        HStack(spacing: 15) {
            // Glass Back Button
            Button(action: { dismiss() }) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.primary)
                    .frame(width: 44, height: 44)
                    .background(.ultraThinMaterial)
                    .clipShape(Circle())
                    .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
            }
            
            // Title Glass Capsule
            Text(title)
                .font(.system(size: 17, weight: .bold, design: .rounded))
                .padding(.horizontal, 20)
                .frame(height: 44)
                .background(.ultraThinMaterial)
                .clipShape(Capsule())
                .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.top, 10) // Extra padding for safe area
    }
}
