//
//  Stickman.swift
//  SwiftUI-Animations
//
//  Created by codeAlligator on 09/12/25.
//


import SwiftUI

struct StickmanView: View {
    // Animation States
    @State private var lineDrawProgress: CGFloat = 0.0
    @State private var inkFillProgress: CGFloat = 0.0
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            // LAYER 1: The Stick Lines (Body, Limbs, Head Outline)
            StickFigureLines()
                .trim(from: 0, to: lineDrawProgress)
                .stroke(Color.black, style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
                .frame(width: 300, height: 400)
            
            // LAYER 2: The "Ink" Details (Hair, Eyes, Feet, Fingers)
            StickFigureSolids()
                .fill(Color.black)
                .frame(width: 300, height: 400)
                .opacity(inkFillProgress)
            
        }
        .onAppear {
            // 1. Draw the stick lines
            withAnimation(.easeInOut(duration: 2.0)) {
                lineDrawProgress = 1.0
            }
            
            // 2. Pop in the heavy ink details (Hair/Feet) slightly after
            withAnimation(.easeIn(duration: 0.5).delay(1.5)) {
                inkFillProgress = 1.0
            }
        }
    }
}

// MARK: - THE STICK LINES (Animated Stroke)
struct StickFigureLines: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let midX = rect.width / 2
        
        // Coordinates
        let headCenter = CGPoint(x: midX, y: 100)
        let neckY: CGFloat = 160
        let hipY: CGFloat = 260
        
        // 1. Head Outline
        path.addEllipse(in: CGRect(x: headCenter.x - 60, y: headCenter.y - 60, width: 120, height: 120))
        
        // 2. Torso
        path.move(to: CGPoint(x: midX, y: neckY))
        path.addLine(to: CGPoint(x: midX, y: hipY))
        
        // 3. Legs
        path.move(to: CGPoint(x: midX, y: hipY))
        path.addLine(to: CGPoint(x: midX - 35, y: 360)) // Left Leg
        path.move(to: CGPoint(x: midX, y: hipY))
        path.addLine(to: CGPoint(x: midX + 35, y: 360)) // Right Leg
        
        // 4. Arms
        // Left Arm
        path.move(to: CGPoint(x: midX, y: neckY + 5))
        path.addLine(to: CGPoint(x: midX - 55, y: neckY + 40)) // Elbow
        path.addLine(to: CGPoint(x: midX - 25, y: hipY - 20)) // Wrist
        
        // Right Arm
        path.move(to: CGPoint(x: midX, y: neckY + 5))
        path.addLine(to: CGPoint(x: midX + 55, y: neckY + 40)) // Elbow
        path.addLine(to: CGPoint(x: midX + 25, y: hipY - 20)) // Wrist
        
        // 5. Mouth (Frown)
        path.move(to: CGPoint(x: midX - 20, y: 135))
        path.addQuadCurve(to: CGPoint(x: midX + 20, y: 135), control: CGPoint(x: midX, y: 120))

        return path
    }
}

// MARK: - THE SOLID DETAILS (Filled Shapes)
struct StickFigureSolids: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let midX = rect.width / 2
        
        // --- 1. THE HAIR (Ramadan Moon Style) ---
        
        // Strand 1 (Left)
        path.move(to: CGPoint(x: midX + 25, y: 50)) // Root
        path.addQuadCurve(to: CGPoint(x: midX - 25, y: 15), control: CGPoint(x: midX - 50, y: 45)) // Outer curve
        path.addQuadCurve(to: CGPoint(x: midX - 25, y: 50), control: CGPoint(x: midX - 50, y: 35)) // Inner curve (creates taper)
        
        // Strand 2 (Middle)
        path.move(to: CGPoint(x: midX - 5, y: 45))
        path.addQuadCurve(to: CGPoint(x: midX - 50, y: 5), control: CGPoint(x: midX + 15, y: 25))
        path.addQuadCurve(to: CGPoint(x: midX - 5, y: 45), control: CGPoint(x: midX + 15, y: 35))
        
        // Strand 3 (Right)
        path.move(to: CGPoint(x: midX + 15, y: 50))
        path.addQuadCurve(to: CGPoint(x: midX - 25, y: 20), control: CGPoint(x: midX + 35, y: 25))
        path.addQuadCurve(to: CGPoint(x: midX + 15, y: 50), control: CGPoint(x: midX + 35, y: 35))
        
        
        // 2. EYEBROWS (Thick V Shape)
        // Left Brow
        path.move(to: CGPoint(x: midX - 8, y: 95))
        path.addLine(to: CGPoint(x: midX - 45, y: 75))
        path.addLine(to: CGPoint(x: midX - 45, y: 70)) // Thickness
        path.addLine(to: CGPoint(x: midX - 8, y: 88))
        path.closeSubpath()
        
        // Right Brow
        path.move(to: CGPoint(x: midX + 8, y: 95))
        path.addLine(to: CGPoint(x: midX + 45, y: 75))
        path.addLine(to: CGPoint(x: midX + 45, y: 70)) // Thickness
        path.addLine(to: CGPoint(x: midX + 8, y: 88))
        path.closeSubpath()
        
        // 3. EYES
        path.addEllipse(in: CGRect(x: midX - 35, y: 95, width: 16, height: 22))
        path.addEllipse(in: CGRect(x: midX + 19, y: 95, width: 16, height: 22))
        
        // 4. FEET (Shoe Shape with Bump)
        
        // Left Foot
        path.move(to: CGPoint(x: midX - 35, y: 360)) // Ankle connection
        path.addLine(to: CGPoint(x: midX - 65, y: 360)) // Heel
        path.addLine(to: CGPoint(x: midX - 65, y: 370)) // Heel Bottom
        path.addLine(to: CGPoint(x: midX - 25, y: 370)) // Toe Bottom
        path.addQuadCurve(to: CGPoint(x: midX - 55, y: 360), control: CGPoint(x: midX - 25, y: 345)) // The "Bump" on top
        
        // Right Foot
        path.move(to: CGPoint(x: midX + 35, y: 360)) // Ankle connection
        path.addLine(to: CGPoint(x: midX + 65, y: 360)) // Heel (flipped)
        path.addLine(to: CGPoint(x: midX + 65, y: 370))
        path.addLine(to: CGPoint(x: midX + 25, y: 370))
        path.addQuadCurve(to: CGPoint(x: midX + 55, y: 360), control: CGPoint(x: midX + 25, y: 345)) // The "Bump"
        
        // --- 5. FINGERS (Details on Hips) ---
        // Left Hand Fingers
        let lHip = CGPoint(x: midX - 25, y: 240)
        path.addEllipse(in: CGRect(x: lHip.x - 8, y: lHip.y, width: 8, height: 12)) // Finger 1
        path.addEllipse(in: CGRect(x: lHip.x - 2, y: lHip.y + 2, width: 8, height: 12)) // Finger 2
        path.addEllipse(in: CGRect(x: lHip.x + 4, y: lHip.y, width: 8, height: 12)) // Finger 3
        
        // Right Hand Fingers
        let rHip = CGPoint(x: midX + 25, y: 240)
        path.addEllipse(in: CGRect(x: rHip.x - 8, y: rHip.y, width: 8, height: 12))
        path.addEllipse(in: CGRect(x: rHip.x - 2, y: rHip.y + 2, width: 8, height: 12))
        path.addEllipse(in: CGRect(x: rHip.x + 4, y: rHip.y, width: 8, height: 12))

        return path
    }
}


struct StickmanView_Previews: PreviewProvider {
    static var previews: some View {
        StickmanView()
    }
}
