//
//  CrowdView.swift
//  SwiftUI-Animations
//
//  Created by codeAlligator on 07/01/26.
//

import SwiftUI

struct CrowdView: View {
    let image: CGImage
    let sprites: [CGRect]

    @State private var peeps: [Peep] = []

    var body: some View {
        TimelineView(.animation) { timeline in
            Canvas { ctx, size in
                let time = timeline.date.timeIntervalSinceReferenceDate

                // TODO: Very expensive task, its Per frame loop chanage this or move it to somewhere else.
                // TimelineView + Canvas = per-frame loop
                ///Runs 60–120 times per second, everything inside (here) must fit in 16 ms, any small inefficiency multiplies brutally
                ///
                ///The issue is sorting inside the frame loop peeps.sorted(by: { $0.y < $1.y }) & on top of that drawing very rapidly
                ///why this hurts? Yes sorting is O(n log n) order never changes doing it every frame is pure wasted of CPU.
                ///
                for peep in peeps.sorted(by: { $0.y < $1.y }) {
                    // WARNING: creating anything inside per frame is expensive hits hard on CPU
                    draw(peep, time: time, ctx: &ctx)
                }
            }
            .onAppear {
                spawn(stage: UIScreen.main.bounds.size)
            }
        }
    }
    
    


      
    
    func draw(_ peep: Peep, time: TimeInterval, ctx: inout GraphicsContext) {
        let progress = ((time - peep.startTime) / peep.duration)
            .truncatingRemainder(dividingBy: 1)

        let x = peep.startX + (peep.endX - peep.startX) * progress

        let yoyoProgress = yoyo(progress * 20)
        let yOffset: CGFloat = -6 * yoyoProgress

        // TODO: Warning!!!!!!
        // DrawLayer per peep
        /// This is not wrong but each layer = extra offscreen work
        /// This combine with image creation `cropped` is expensive more load on CPU.
        ctx.drawLayer { layer in
            layer.translateBy(
                x: x,
                y: peep.y + yOffset
            )

            layer.scaleBy(
                x: peep.scaleX,
                y: 1
            )

            // TODO: This also killing CPU cropping per frame
            //Image cropping inside draw
            /// This is a killer each frame, for each peep
            /// Allocates memory, Copies pixel data, Creates CGImage, Triggers CoreGraphics work on top adds pressure to autorelease pools
            /// Now multiply (peeps count) × (fps) × (seconds)
            if let cropped = image.cropping(to: peep.spriteRect) {
                layer.draw(
                    Image(decorative: cropped, scale: 1),
                    in: CGRect(origin: .zero, size: peep.spriteRect.size)
                )
            }
        }
    }




    func spawn(stage: CGSize) {
        peeps = sprites.map { rect in
            let direction: CGFloat = Bool.random() ? 1 : -1
            let offsetY = 100 - 250 * (CGFloat.random(in: 0...1) * CGFloat.random(in: 0...1))
            let y = stage.height - rect.height + offsetY

            let startX = direction == 1 ? -rect.width : stage.width + rect.width
            let endX = direction == 1 ? stage.width : -rect.width

            return Peep(
                spriteRect: rect,
                startX: startX,
                endX: endX,
                y: y,
                startTime: Date().timeIntervalSinceReferenceDate
                    - Double.random(in: 0...10),
                duration: Double.random(in: 8...14),
                scaleX: direction
            )
        }
    }
}


extension CrowdView {
    func yoyo(_ t: CGFloat) -> CGFloat {
        let p = t.truncatingRemainder(dividingBy: 1)
        return p < 0.5 ? p * 2 : (1 - p) * 2
      }
}


extension CrowdView {
    
}

extension CrowdView {
    
}

extension CrowdView {
    
}
