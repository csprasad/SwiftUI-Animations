//
//  Color+Extension.swift
//  SwiftUI-Animations
//
/// Created by `C S Prasad` on `16/07/23`
///
/// ### Social
/// `Instagram` : ``@csprasad.ios`` • `X` : ``@csprasad_ios`` • `Github` : ``@csprasad``
///

import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: "#", with: "")
        var rgb: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&rgb)

        let length = hex.count
        let r = CGFloat((rgb & (length == 8 ? 0xFF000000 : 0xFF0000)) >> (length == 8 ? 24 : 16)) / 255
        let g = CGFloat((rgb & (length == 8 ? 0x00FF0000 : 0x00FF00)) >> (length == 8 ? 16 : 8)) / 255
        let b = CGFloat((rgb & (length == 8 ? 0x0000FF00 : 0x0000FF)) >> (length == 8 ? 8 : 0)) / 255
        let a = length == 8 ? CGFloat(rgb & 0x000000FF) / 255 : 1.0

        self.init(red: r, green: g, blue: b, opacity: a)
    }
}

