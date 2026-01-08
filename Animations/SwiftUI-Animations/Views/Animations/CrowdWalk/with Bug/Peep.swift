//
//  Peep.swift
//  SwiftUI-Animations
//
//  Created by codeAlligator on 07/01/26.
//

import SwiftUI

struct Peep: Identifiable {
    let id = UUID()
    let spriteRect: CGRect

    let startX: CGFloat
    let endX: CGFloat
    let y: CGFloat
    let startTime: TimeInterval
    let duration: TimeInterval
    let scaleX: CGFloat
}
