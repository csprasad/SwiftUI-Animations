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
                        
                        headerSection
                        
                        // MARK: - Filter Bar
                        filterBar
                        
                        // Use filteredAnimations instead of the raw list
                        let enumeratedItems = Array(viewModel.filteredAnimations.enumerated())
                        
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(enumeratedItems, id: \.element.id) { index, item in
                                NavigationLink(destination: item.destination) {
                                    ModernCardView(item: item)
                                }
                                .buttonStyle(ScaleButtonStyle())
                            }
                        }
                        .padding(.horizontal)
                        .animation(.spring(response: 0.4, dampingFraction: 0.8), value: viewModel.selectedCategory)
                    }
                    .padding(.top, 40)
                }
            }
            .navigationBarHidden(true)
        }
    }

    var headerSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Animate")
                .font(.system(size: 48, weight: .black, design: .rounded))
                .tracking(-1)
            
            Capsule()
                .fill(Color.primary.opacity(0.1))
                .frame(width: 60, height: 4)
        }
        .padding(.horizontal, 30)
    }
    
    // MARK: - Filter Bar Component
    var filterBar: some View {
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
}

// MARK: - Filter Chip Component
struct FilterChip: View {
    let text: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .font(.system(size: 14, weight: .bold, design: .rounded))
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(isSelected ? Color.primary : Color.primary.opacity(0.05))
                .foregroundColor(isSelected ? Color(.systemBackground) : .primary)
                .clipShape(Capsule())
        }
        .buttonStyle(PlainButtonStyle())
    }
}
#Preview {
    HomeView()
}


// MARK: - The Modern Card
struct ModernCardView: View {
    let item: AnimationItem
    
    var body: some View {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Image(systemName: item.icon)
                        .font(.system(size: 24, weight: .bold))
                        .foregroundStyle(item.color)
                    Spacer()
                    
                    TagBadge(text: item.category.rawValue, color: item.color)
                }
                
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(item.title)
                        .font(.system(.headline, design: .rounded))
                        .bold()
                        .foregroundColor(.primary)
                    
                    if let note = item.note {
                        Text(note)
                            .font(.system(size: 11))
                            .foregroundColor(.secondary)
                            .lineLimit(2)
                    }
                }
            }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 140)
        .background(.ultraThinMaterial)
        .cornerRadius(32)
        .overlay(
            RoundedRectangle(cornerRadius: 32)
                .stroke(Color.primary.opacity(0.05), lineWidth: 1))
    }
}

// MARK: - Category Badge
struct TagBadge: View {
    let text: String
    let color: Color

    var body: some View {
        Text(text)
            .font(.system(size: 11, weight: .semibold))
            .foregroundStyle(color)
            .padding(.horizontal, 10)
            .padding(.vertical, 4)
            .background(color.opacity(0.12))
            .clipShape(Capsule())
    }
}

// MARK: - Interactive Mesh Background
struct MeshGradientBackground: View {
    @State private var appear = false
    
    var body: some View {
        ZStack {
            Color(.systemBackground)
            
            Circle()
                .fill(Color.purple.opacity(0.2))
                .blur(radius: 100)
                .offset(x: appear ? -100 : 100, y: appear ? -200 : 200)
            
            Circle()
                .fill(Color.blue.opacity(0.15))
                .blur(radius: 100)
                .offset(x: appear ? 150 : -150, y: appear ? 100 : -100)
        }
        .onAppear {
            withAnimation(.linear(duration: 10).repeatForever(autoreverses: true)) {
                appear.toggle()
            }
        }
    }
}

// MARK: - Custom Button Style for "Premium" feel
struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.94 : 1)
            .animation(.spring(response: 0.3, dampingFraction: 0.7), value: configuration.isPressed)
    }
}
