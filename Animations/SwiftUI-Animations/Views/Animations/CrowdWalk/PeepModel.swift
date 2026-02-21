//
//  PeepModel.swift
//  SwiftUI-Animations
//
/// Created by `C S Prasad` on `07/01/26`
///
/// ### Social
/// `Instagram` : ``@csprasad.ios`` • `X` : ``@csprasad_ios`` • `Github` : ``@csprasad``
///

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






