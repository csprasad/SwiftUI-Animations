//
//  PeepModel.swift
//  SwiftUI-Animations
//
//  Created by codeAlligator on 07/01/26.
//

import SwiftUI

struct PeepModel: Identifiable {
    let id = UUID()
    let image: CGImage   // already cropped

    let startX: CGFloat
    let endX: CGFloat
    let y: CGFloat
    let startTime: TimeInterval
    let duration: TimeInterval
    let scaleX: CGFloat
}






