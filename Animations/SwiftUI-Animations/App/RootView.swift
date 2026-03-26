//
//
//  RootView.swift
//  SwiftUI-Animations
//
/// Created by `C S Prasad` on `27/03/26`
///
/// ### Social
/// `Instagram` : ``@csprasad.ios`` • `X` : ``@csprasad_ios`` • `Github` : ``@csprasad``
///

import SwiftUI

struct RootView: View {
    @State private var appState: AppLaunchState = .splashing
    
    enum AppLaunchState {
        case splashing, transitioning, ready
    }

    var body: some View {
        ZStack {
            MeshGradientBackground().ignoresSafeArea()
            
            if appState == .splashing || appState == .transitioning {
                // Splash Screen
                launchView()
                    .opacity(appState == .splashing ? 1 : 0)
                    .scaleEffect(appState == .transitioning ? 0.8 : 1.0)
                    .blur(radius: appState == .transitioning ? 20 : 0)
            }

            if appState == .ready || appState == .transitioning {
                // Home View
                HomeView()
                    .opacity(appState == .ready ? 1 : 0)
                    .offset(y: appState == .ready ? 0 : 50) // Subtle slide up
                    .scaleEffect(appState == .ready ? 1.0 : 0.95)
            }
        }
        .onAppear {
            runLaunchSequence()
        }
    }

    private func runLaunchSequence() {
        Task {
            try? await Task.sleep(nanoseconds: 1_500_000_000) // 1.5 seconds wait for Logo
            
            await MainActor.run { // Trigger Transition
                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                withAnimation(.spring(response: 0.8, dampingFraction: 0.85)) {
                    appState = .transitioning
                }
            }
            
            try? await Task.sleep(nanoseconds: 500_000_000) // 0.5 seconds wait for Morph
            
            await MainActor.run { //Home Arrival
                withAnimation(.easeInOut(duration: 0.5)) {
                    appState = .ready
                }
            }
        }
    }
}
