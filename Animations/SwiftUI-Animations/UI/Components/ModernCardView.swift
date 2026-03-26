//
//
//  ModernCardView.swift
//  SwiftUI-Animations
//
/// Created by `C S Prasad` on `27/03/26`
///
/// ### Social
/// `Instagram` : ``@csprasad.ios`` • `X` : ``@csprasad_ios`` • `Github` : ``@csprasad``
///

import SwiftUI

// MARK: - The Modern Card
struct ModernCardView: View {
    let item: AnimationItem
    
    var body: some View {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Image(systemName: item.icon)
                        .font(.system(size: 24, weight: .bold))
                        .foregroundStyle(item.color)
                    Spacer()
                    
                    TagBadge(text: item.category.rawValue, color: item.color)
                }
                
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(item.title)
                        .font(.system(.headline, design: .rounded))
                        .bold()
                        .foregroundColor(.primary)
                    
                    if let note = item.note {
                        Text(note)
                            .font(.system(size: 11))
                            .foregroundColor(.secondary)
                            .lineLimit(2)
                    }
                }
            }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 140)
        .background(.ultraThinMaterial)
        .cornerRadius(32)
        .overlay(
            RoundedRectangle(cornerRadius: 32)
                .stroke(Color.primary.opacity(0.05), lineWidth: 1))
    }
}
