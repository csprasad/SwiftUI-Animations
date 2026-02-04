//
//  FirecrackerScene.swift
//  SwiftUI-Animations
//
//  Created by codeAlligator on 30/01/26.
//

import SwiftUI

struct FirecrackerScene: View {
    @State private var firePosition: CGPoint?
    @State private var isDragging = false
    
    @State private var fuseIgnited = false
    @State private var burnProgress: CGFloat = 0   // 0 → 1


    let fuse = FusePath.make()

    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color.black.ignoresSafeArea()

                // Firecracker
                FirecrackerView()
                    .position(x: geo.size.width / 2, y: 60)

                // Fuse
                FuseView(path: fuse.path,
                    burnProgress: burnProgress)


                // Matchbox igniter
                MatchboxIgniter()
                    .position(x: geo.size.width / 2, y: geo.size.height - 80)
                    .gesture(dragGesture)

                // Fire
                if let firePosition, isDragging {
                    FireView()
                        .position(firePosition)
                }
            }
        }
    }

    var dragGesture: some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged { value in
                guard !fuseIgnited else { return }

                isDragging = true
                firePosition = value.location

                for (index, point) in fuse.points.enumerated() {
                    let distance = hypot(
                        point.x - value.location.x,
                        point.y - value.location.y
                    )

                    if distance < 14 {
                        igniteFuse(from: CGFloat(index) / CGFloat(fuse.points.count))
                        break
                    }
                }
            }

            .onEnded { _ in
                isDragging = false
                firePosition = nil
            }
    }
    
    func igniteFuse(from start: CGFloat) {
        fuseIgnited = true
        burnProgress = start
        isDragging = false
        firePosition = nil

        withAnimation(.linear(duration: 2.5)) {
            burnProgress = 1
        }
    }

}

