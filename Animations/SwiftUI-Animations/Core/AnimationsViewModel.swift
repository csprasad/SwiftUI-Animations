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

// MARK: - Models
enum AnimationCategory: String, CaseIterable, Identifiable {
    case physics = "Motion"
    case nature = "Abstract"
    case science = "Science"
    case effects = "Effects"
    case components = "UI"

    var id: String { self.rawValue }
}

struct AnimationItem: Identifiable {
    let id = UUID()
    let title: String
    let note: String?
    let icon: String
    let color: Color
    let category: AnimationCategory
    let destination: AnyView
}

// MARK: - ViewModel
class AnimationsViewModel: ObservableObject {
    @Published var selectedCategory: AnimationCategory? = nil
    
    @Published var animations: [AnimationItem] = [
            // Group 1
            .init(title: "Spacetime Grid", note: "Gravity, rotation, and waves", icon: "aqi.medium", color: .purple, category: .physics, destination: AnyView(GravityGridView())),
            .init(title: "Matrix Digital Rain", note: "Code rain effect", icon: "checkerboard.rectangle", color: .green, category: .physics, destination: AnyView(MatrixRain())),
            .init(title: "Crowd Walking", note: "Physics-based movement", icon: "person.3.sequence.fill", color: .indigo, category: .physics, destination: AnyView(CrowdContainerView())),
            .init(title: "Fluid Dream", note: "Organic liquid flow", icon: "drop.fill", color: .blue, category: .nature, destination: AnyView(FluidDreamView())),
            
            // Group 2
            .init(title: "Sunrise", note: "Atmospheric transition", icon: "sun.max.fill", color: .orange, category: .nature, destination: AnyView(SunRiseUIView())),
            .init(title: "Batman", note: "Shape morphing", icon: "theatermasks.fill", color: .black, category: .nature, destination: AnyView(BatmanView())),
            .init(title: "Morph Blob", note: "Liquid geometry", icon: "triangle.fill", color: .pink, category: .effects, destination: AnyView(MorphBlob())),
            .init(title: "Flower Petals", note: "Generative bloom", icon: "leaf.fill", color: .green, category: .nature, destination: AnyView(FlowerBloom())),
            
            // Group 3
            .init(title: "Planetary Atom", note: "Orbital systems", icon: "atom", color: .blue, category: .science, destination: AnyView(PlanetaryAtom())),
            .init(title: "Carbon Atom", note: "Molecular structure", icon: "circle.hexagongrid.fill", color: .cyan, category: .science, destination: AnyView(CarbonAtom())),
            .init(title: "Layer Masking", note: "Depth and masks", icon: "square.2.stack.3d", color: .teal, category: .effects, destination: AnyView(LayerMaskUIView())),
            .init(title: "Kakashi", note: "Eye animation", icon: "eye.fill", color: .red, category: .effects, destination: AnyView(KakashiView())),
            
            // Group 4
            .init(title: "Like Button", note: "Micro-interaction", icon: "heart.fill", color: .red, category: .components, destination: AnyView(LikeButton())),
            .init(title: "Splash", note: "Liquid entry", icon: "drop.triangle.fill", color: .blue, category: .components, destination: AnyView(SplashView())),
            .init(title: "Loader", note: "Custom progress", icon: "arrow.triangle.2.circlepath", color: .orange, category: .components, destination: AnyView(LoaderUIView())),
            .init(title: "Glassy Button", note: "Modern glass UI", icon: "square.stack.3d.up.fill", color: .mint, category: .components, destination: AnyView(GlassyButtonView())),
            
            // Group 5
            .init(title: "Distressed Font", note: "Typography effects", icon: "textformat", color: .yellow, category: .effects, destination: AnyView(DistressedFontView())),
            .init(title: "Random Animation", note: "Generative chaos", icon: "shuffle", color: .purple, category: .physics, destination: AnyView(RandomAnimationView()))
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
