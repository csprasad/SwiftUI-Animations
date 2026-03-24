//
//  distressedFont.swift
//  SwiftUI-Animations
//
/// Created by `C S Prasad` on `26/03/25`
///
/// ### Social
/// `Instagram` : ``@csprasad.ios`` • `X` : ``@csprasad_ios`` • `Github` : ``@csprasad``
///

import SwiftUI

struct DistressedFontView: View {
    // MARK: - State
    @State private var userInput: String = "TIGER"
    @State private var fontSize: CGFloat = 80
    @State private var maxReached: Bool = false
    @State private var refreshID = UUID()
    
    // MARK: - Constants
    let minFontSize: CGFloat = 40
    let maxFontSize: CGFloat = 80
    let maxHeightFactor: CGFloat = 0.35 // Keeping it tight for modern look

    var body: some View {
        ZStack {

            //Main Content (Scrolls/Moves with Keyboard)
            VStack {
                Spacer()
                
                // The Floating Text Canvas
                VStack {
                    Text(userInput)
                        .font(.system(size: fontSize, weight: .black, design: .rounded))
                        .kerning(4)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.primary)
                        .overlay(
                            GrungeEffect()
                                .blendMode(.destinationOut)
                                .opacity(0.8)
                                .id(refreshID)
                        )
                        .mask(
                            Text(userInput)
                                .font(.system(size: fontSize, weight: .black, design: .rounded))
                                .kerning(4)
                                .multilineTextAlignment(.center)
                        )
                        .shadow(color: .black.opacity(0.1), radius: 20, x: 0, y: 10)
                        .padding(40)
                        .frame(maxWidth: .infinity)
                        .frame(height: UIScreen.main.bounds.height * maxHeightFactor)
                        .background(.ultraThinMaterial)
                        .cornerRadius(32)
                        .overlay(
                            RoundedRectangle(cornerRadius: 32)
                                .stroke(Color.primary.opacity(0.1), lineWidth: 1)
                        )
                }
                .padding(.horizontal, 20)
                
                Spacer()
                
                // The Control Panel
                VStack(spacing: 16) {
                    HStack {
                        Image(systemName: "pencil.and.outline")
                            .foregroundColor(maxReached ? .red : .primary.opacity(0.4))
                        Text(maxReached ? "Limit Reached" : "Interactive Typography")
                            .font(.system(size: 13, weight: .bold, design: .rounded))
                            .foregroundColor(maxReached ? .red : .primary.opacity(0.6))
                        Spacer()
                    }
                    .padding(.horizontal, 8)

                    HStack {
                        TextField("TYPE HERE", text: $userInput)
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.characters)
                            .keyboardType(.alphabet)
                            .onChange(of: userInput) { newValue in
                                // LOCK: Stop Nav/Panel jitter by silencing layout animation
                                var transaction = Transaction()
                                transaction.disablesAnimations = true
                                withTransaction(transaction) {
                                    handleTextChange(newValue)
                                }
                            }

                        if !userInput.isEmpty {
                            Button(action: { userInput = "" }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.primary.opacity(0.2))
                            }
                        }
                    }
                    .padding()
                    .background(.thickMaterial)
                    .cornerRadius(20)
                }
                .padding(24)
                .background(.ultraThinMaterial)
                .cornerRadius(32)
                .overlay(
                    RoundedRectangle(cornerRadius: 32)
                        .stroke(Color.primary.opacity(0.1), lineWidth: 1)
                )
                .padding(.horizontal, 20)
                .padding(.bottom, 10)
            }
        }
    }

    // MARK: - Logic
    private func handleTextChange(_ newValue: String) {
        let estimatedHeight = estimatedTextHeight(for: newValue, fontSize: fontSize)
        if estimatedHeight > UIScreen.main.bounds.height * maxHeightFactor, fontSize <= minFontSize {
            maxReached = true
            userInput = trimTextToFit(newValue)
        } else {
            maxReached = false
            userInput = newValue
            adjustFontSize()
        }
    }

    private func adjustFontSize() {
        var currentSize = maxFontSize
        while estimatedTextHeight(for: userInput, fontSize: currentSize) > UIScreen.main.bounds.height * maxHeightFactor,
              currentSize > minFontSize {
            currentSize -= 1
        }
        fontSize = currentSize
    }

    private func estimatedTextHeight(for text: String, fontSize: CGFloat) -> CGFloat {
        let uiFont = UIFont.systemFont(ofSize: fontSize, weight: .heavy)
        let attributedString = NSAttributedString(string: text, attributes: [.font: uiFont])
        let textWidth = UIScreen.main.bounds.width - 100 // Padding adjusted for the glass capsule
        let boundingRect = attributedString.boundingRect(
            with: CGSize(width: textWidth, height: .greatestFiniteMagnitude),
            options: .usesLineFragmentOrigin,
            context: nil
        )
        return boundingRect.height
    }

    private func trimTextToFit(_ text: String) -> String {
        var words = text.split(separator: " ").map { String($0) }
        while !words.isEmpty {
            let trimmedText = words.joined(separator: " ")
            if estimatedTextHeight(for: trimmedText, fontSize: fontSize) <= UIScreen.main.bounds.height * maxHeightFactor {
                return trimmedText
            }
            words.removeLast()
        }
        return ""
    }
}

#Preview {
    DistressedFontView()
}

//Grunge Effect - with random shapes with triangle, rectangle, Irregular blob (Bezier Curve)
struct GrungeEffect: View {
    var body: some View {
        Canvas { context, size in
            for _ in 0..<500 {
                let x = CGFloat.random(in: 0..<size.width)
                let y = CGFloat.random(in: 0..<size.height)
                let opacity = Double.random(in: 0.3...0.6)

                let randomShape = Int.random(in: 0...2) // Randomly choose shape type

                let path: Path
                switch randomShape {
                case 0:
                    path = Path { p in // Random Rectangles
                        let width = CGFloat.random(in: 2...8)
                        let height = CGFloat.random(in: 2...8)
                        p.addRect(CGRect(x: x, y: y, width: width, height: height))
                    }
                case 1:
                    path = Path { p in // Random Triangles
                        let w = CGFloat.random(in: 3...10)
                        p.move(to: CGPoint(x: x, y: y))
                        p.addLine(to: CGPoint(x: x + w, y: y))
                        p.addLine(to: CGPoint(x: x + w / 2, y: y + w))
                        p.closeSubpath()
                    }
                default:
                    path = Path { p in // Random Irregular Blob (Bezier Curve)
                        let offset = CGFloat.random(in: 3...15)
                        p.move(to: CGPoint(x: x, y: y))
                        p.addCurve(to: CGPoint(x: x + offset, y: y + offset),
                                   control1: CGPoint(x: x - offset, y: y + offset / 2),
                                   control2: CGPoint(x: x + offset / 2, y: y - offset))
                        p.addLine(to: CGPoint(x: x, y: y + offset))
                        p.closeSubpath()
                    }
                }

                context.fill(path, with: .color(.black.opacity(opacity)))
            }
        }
    }
}
