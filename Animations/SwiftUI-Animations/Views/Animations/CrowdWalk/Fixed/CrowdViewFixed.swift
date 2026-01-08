//
//  PeepView.swift
//  SwiftUI-Animations
//
//  Created by codeAlligator on 07/01/26.
//

import SwiftUI

// MARK: - Performance Fix (CPU)
//
// IMPORTANT:
/// This animation runs once per display frame (~60fps).
/// Any expensive work inside `draw` will be multiplied per frame.
//
// Fixes applied:
/// - Sorting moved to `spawn()` so it runs once instead of every frame
/// - Peeps images are cropped once during spawn and stored in `Peep`
///   to avoid allocating CGImages during per-frame drawing
//
// Do NOT move sorting or image creation back into the draw loop.


struct CrowdViewFixed: View {
    let slicedImages: [CGImage]

    @State private var peepModel: [PeepModel] = []

    var body: some View {
        TimelineView(.periodic(from: .now, by: 1.0 / 60.0)) { timeline in
            Canvas { ctx, size in
                let time = timeline.date.timeIntervalSinceReferenceDate

                for peep in peepModel {
                    draw(peep, time: time, ctx: &ctx)
                }
            }
            .onAppear {
                spawn(stage: UIScreen.main.bounds.size)
            }
        }
    }

    // MARK: - Animation helpers
    func yoyo(_ t: CGFloat) -> CGFloat {
        let p = t.truncatingRemainder(dividingBy: 1)
        return p < 0.5 ? p * 2 : (1 - p) * 2
    }

    // MARK: - Draw (math + draw ONLY)
    func draw(_ peep: PeepModel, time: TimeInterval, ctx: inout GraphicsContext) {
        let progress = ((time - peep.startTime) / peep.duration)
            .truncatingRemainder(dividingBy: 1)

        let x = peep.startX + (peep.endX - peep.startX) * progress

        let yoyoProgress = yoyo(progress * 20)
        let yOffset: CGFloat = -6 * yoyoProgress

        ctx.drawLayer { layer in
            layer.translateBy(x: x, y: peep.y + yOffset)
            layer.scaleBy(x: peep.scaleX, y: 1)

            layer.draw(
                Image(decorative: peep.image, scale: 1),
                in: CGRect(
                    x: 0,
                    y: 0,
                    width: CGFloat(peep.image.width),
                    height: CGFloat(peep.image.height)
                )
            )
        }
    }

    // MARK: - Spawn (runs ONCE)
    func spawn(stage: CGSize) {
        let now = Date().timeIntervalSinceReferenceDate

        peepModel = slicedImages.map { image in
            let direction: CGFloat = Bool.random() ? 1 : -1
            let offsetY = 100 - 250 * (CGFloat.random(in: 0...1) * CGFloat.random(in: 0...1))
            let y = stage.height - CGFloat(image.height) + offsetY

            let startX = direction == 1 ? -CGFloat(image.width) : stage.width + CGFloat(image.width)
            let endX = direction == 1 ? stage.width : -CGFloat(image.width)

            return PeepModel(
                image: image,
                startX: startX,
                endX: endX,
                y: y,
                startTime: now - Double.random(in: 0...10),
                duration: Double.random(in: 8...14),
                scaleX: direction
            )
        }
        .sorted { $0.y < $1.y }   // sort ONCE
    }
}

