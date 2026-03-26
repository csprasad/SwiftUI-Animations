//
//
//  AnimationModels.swift
//  SwiftUI-Animations
//
/// Created by `C S Prasad` on `27/03/26`
///
/// ### Social
/// `Instagram` : ``@csprasad.ios`` • `X` : ``@csprasad_ios`` • `Github` : ``@csprasad``
///

import SwiftUI

// MARK: - Animation Type Identifier
enum AnimationType {
    case spacetimeGrid, matrixRain, crowdWalking, fluidDream
    case sunrise, batman, morphBlob, flowerBloom
    case carbonAtom, layerMasking, kakashi
    case likeButton, splash, loader, glassyButton
    case distressedFont, randomAnimation
}

// MARK: - Animation Models
struct AnimationItem: Identifiable {
    let id = UUID()
    let title: String
    let note: String?
    let icon: String
    let color: Color
    let category: AnimationCategory
    let type: AnimationType

    // Move the "Switch" logic here!
    @ViewBuilder
    var destination: some View {
        switch type {
        case .spacetimeGrid: GravityGridView()
        case .matrixRain: MatrixRain()
        case .crowdWalking: CrowdContainerView()
        case .fluidDream: FluidDreamView()
        case .sunrise: SunRiseView()
        case .batman: BatmanView()
        case .morphBlob: MorphBlob()
        case .flowerBloom: FlowerBloom()
        case .carbonAtom: CarbonAtom()
        case .layerMasking: LayerMaskUIView()
        case .kakashi: KakashiView()
        case .likeButton: LikeButton()
        case .splash: SplashView()
        case .loader: LoaderUIView()
        case .glassyButton: GlassyButtonView()
        case .distressedFont: DistressedFontView()
        case .randomAnimation: RandomAnimationView()
        }
    }
}
