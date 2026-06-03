//
//  ContentView.swift
//  SwiftUI-Animations
//
/// Created by `C S Prasad` on `14/07/23`
///
/// `iOS • SwiftUI • Creative Coding`
///
/// ### Social
/// `Instagram` : ``@csprasad.ios``
/// `X`                   : ``@csprasad_ios``
/// `Github`        : ``@csprasad``
///

import SwiftUI

// MARK: - Main HomeView
struct HomeView: View {
    @StateObject private var viewModel = AnimationsViewModel()

    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var body: some View {
        NavigationView {
            ZStack {
                MeshGradientBackground().ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 20) {
                        // Header title
                        headerSection

                        // Filter Bar
                        filterBar

                        // Use filteredAnimations instead of the raw list
                        let enumeratedItems = Array(viewModel.filteredAnimations.enumerated())

                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(enumeratedItems, id: \.element.id) { _, item in
                                NavigationLink(destination:
                                    detailView(for: item)
                                ) {
                                    ModernCardView(item: item)
                                }
                                .buttonStyle(ScaleButtonStyle())
                            }
                        }
                        .padding(.horizontal)
                        .animation(.spring(response: 0.4, dampingFraction: 0.8), value: viewModel.selectedCategory)
                    }
                    .padding(.top, 20)
                }
            }
            .navigationBarHidden(true)
        }
    }

    // MARK: - Header section
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Animate")
                .font(.system(size: 48, weight: .black, design: .rounded))
                .tracking(-1)

            Capsule()
                .fill(Color.primary.opacity(0.2))
                .frame(width: 60, height: 4)
        }
        .padding(.horizontal, 30)
    }

    // MARK: - Filter Bar Component
    private var filterBar: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                // "All" Button
                FilterChip(text: "All", isSelected: viewModel.selectedCategory == nil) {
                    viewModel.selectedCategory = nil
                }

                ForEach(AnimationCategory.allCases) { category in
                    FilterChip(text: category.rawValue, isSelected: viewModel.selectedCategory == category) {
                        viewModel.selectedCategory = category
                    }
                }
            }
            .padding(.horizontal, 30)
            .padding(.vertical, 10)
        }
    }

    /// Builds the detail screen for the given animation item.
    /// 
    /// The view places the item's `destination` over a full-screen mesh gradient background and overlays a navigation header showing the item's title; navigation bars are hidden for the resulting view.
    /// - Parameters:
    ///   - item: The `AnimationItem` whose `destination` view and `title` are used to build the detail screen.
    /// - Returns: A view presenting the item's destination with a header and a mesh gradient background, with navigation bars hidden.
    @ViewBuilder
    private func detailView(for item: AnimationItem) -> some View {
        ZStack {
            MeshGradientBackground().ignoresSafeArea()

            item.destination
                .navigationBarHidden(true)

            VStack {
                NavHeader(title: item.title)
                Spacer()
            }
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    HomeView()
}
