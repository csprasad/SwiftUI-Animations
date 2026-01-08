//
//  AnimationCredit.swift
//  SwiftUI-Animations
//
//  Created by codeAlligator on 07/01/26.
//

import SwiftUI

// Original animation created by Tw93
/// GitHub: https://github.com/tw93
/// Website / demo page: https://miaoyan.app/cats.html
///
/// This view simply displays a small footer credit with the author's name and links.
/// It is meant to be placed above or on top of your CrowdView animation.
///
/// All rights to the original artwork and animation belong to the original creator.
///

struct AnimationCreditView: View {
    var body: some View {
        VStack(spacing: 4) {
            Text("Animation inspired by Tw93(miaoyan.app)")
                .font(.footnote)
                .foregroundColor(.secondary)

            HStack(spacing: 12) {
                Link("GitHub",
                     destination: URL(string: "https://github.com/tw93")!)

                Text("•")
                    .foregroundColor(.secondary)

                Link("Webpage (footer animation)",
                     destination: URL(string: "https://miaoyan.app/cats.html")!)
            }
            .font(.footnote)
        }
        .padding(.vertical, 8)
    }
}

