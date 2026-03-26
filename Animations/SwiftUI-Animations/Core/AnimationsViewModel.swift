//
//
//  AnimationsViewModel.swift
//  SwiftUI-Animations
//
/// Created by `C S Prasad` on `24/03/26`
///
/// ### Social
/// `Instagram` : ``@csprasad.ios`` • `X` : ``@csprasad_ios`` • `Github` : ``@csprasad``
///

import SwiftUI

// MARK: - Category List
enum AnimationCategory: String, CaseIterable, Identifiable {
    case physics = "Motion"
    case nature = "Abstract"
    case science = "Science"
    case effects = "Effects"
    case components = "UI"

    var id: String { self.rawValue }
}

// MARK: - Animations ViewModel
class AnimationsViewModel: ObservableObject {
    @Published var selectedCategory: AnimationCategory? = nil
    
    @Published var animations: [AnimationItem] = [
            // Group 1
        .init(title: "Spacetime Grid", note: "Gravity, rotation, and waves", icon: "aqi.medium", color: .purple, category: .physics, type: .spacetimeGrid),
        .init(title: "Matrix Digital Rain", note: "Code rain effect", icon: "checkerboard.rectangle", color: .green, category: .physics, type: .matrixRain),
        .init(title: "Crowd Walking", note: "Physics based movement", icon: "person.3.sequence.fill", color: .indigo, category: .physics, type: .crowdWalking),
        .init(title: "Fluid Dream", note: "Organic liquid flow", icon: "drop.fill", color: .blue, category: .nature, type: .fluidDream),
            
            // Group 2
        .init(title: "Sunrise", note: "Atmospheric transition", icon: "sun.max.fill", color: .orange, category: .nature, type: .sunrise),
        .init(title: "Batman", note: "Shape morphing", icon: "theatermasks.fill", color: .gray, category: .effects, type: .batman),
        .init(title: "Morph Blob", note: "Liquid geometry", icon: "triangle.fill", color: .pink, category: .effects, type: .morphBlob),
        .init(title: "Flower Petals", note: "Generative bloom", icon: "leaf.fill", color: .green, category: .nature, type: .flowerBloom),
            
            // Group 3
        .init(title: "Carbon Atom", note: "Molecular structure", icon: "circle.hexagongrid.fill", color: .cyan, category: .science, type: .carbonAtom),
        .init(title: "Layer Masking", note: "Depth and masks", icon: "square.2.stack.3d", color: .teal, category: .effects, type: .layerMasking),
        .init(title: "Kakashi", note: "Eye animation", icon: "eye.fill", color: .red, category: .effects, type: .kakashi),
            
            // Group 4
        .init(title: "Like Button", note: "Micro-interaction", icon: "heart.fill", color: .red, category: .components, type: .likeButton),
        .init(title: "Splash", note: "Liquid entry", icon: "drop.triangle.fill", color: .blue, category: .components, type: .splash),
        .init(title: "Loader", note: "Custom progress", icon: "arrow.triangle.2.circlepath", color: .orange, category: .components, type: .loader),
        .init(title: "Glassy Button", note: "Modern glass UI", icon: "square.stack.3d.up.fill", color: .mint, category: .components, type: .glassyButton),
            
            // Group 5
        .init(title: "Distressed Font", note: "Typography effects", icon: "textformat", color: .yellow, category: .effects, type: .distressedFont),
        .init(title: "Random Animation", note: "Generative chaos", icon: "shuffle", color: .purple, category: .physics, type: .randomAnimation)
        ]
    
    func items(for category: AnimationCategory) -> [AnimationItem] {
        animations.filter { $0.category == category }
    }
    
    var filteredAnimations: [AnimationItem] {
        guard let selectedCategory = selectedCategory else {
            return animations
        }
        return animations.filter { $0.category == selectedCategory }
    }
}
