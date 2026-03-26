//
//  ContentView.swift
//  SwiftUI-Animations
//
/// Created by `C S Prasad` on `14/07/23`
///
///`iOS • SwiftUI • Creative Coding`
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
                            ForEach(enumeratedItems, id: \.element.id) { index, item in
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
    
    // MARK: - DetailView
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
