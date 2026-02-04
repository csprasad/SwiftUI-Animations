//
//  TestOne.swift
//  SwiftUI-Animations
//
//  Created by CS Prasad on 26/03/25.
//

import SwiftUI

struct distressedFont: View {
    @State private var userInput: String = "Tiger" // Default text
    @State private var fontSize: CGFloat = 100 // Dynamic font size
    @State private var maxReached: Bool = false // Track if max words are reached
    @State private var refreshID = UUID() // Used to refresh GrungeEffect

    let minFontSize: CGFloat = 60
    let maxFontSize: CGFloat = 100
    let maxHeightFactor: CGFloat = 0.6 // Allow 60% of screen height for text

    var body: some View {
        ZStack(alignment: .topTrailing) {
            LinearGradient(gradient: Gradient(colors:
                                [Color(hex: "#FFD700"), Color(hex: "#000000")]),
                           startPoint: .top,
                           endPoint: .bottom)
            .overlay(
                Image("tiger_02") // bg image
                    .resizable()
                    .scaledToFill()
                    .opacity(0.6)
                    .blendMode(.overlay)
            )
            .ignoresSafeArea()
           
            
            VStack {
                // Dynamic Text Display
                Text(userInput)
                    .font(.system(size: fontSize, weight: .heavy))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                
                    .overlay(GrungeEffect().blendMode(.destinationOut).opacity(0.8).id(refreshID))
                    .mask(Text(userInput).font(.system(size: fontSize, weight: .heavy))
                        .multilineTextAlignment(.center))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .shadow(color: .black.opacity(0.5), radius: 8, x: 2, y: 2) // Adds depth

                VStack(spacing: 8) {
                    // Status Message
                    Text(maxReached ? "Maximum words reached!" : "Type below - The text changes dynamically")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(maxReached ? .red : .white)
                        .multilineTextAlignment(.center)

                    //Text Input Field
                    TextField("Tiger", text: $userInput)
                        .font(.system(size: 20, weight: .medium))
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.black)
                        .keyboardType(.default)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                        .disabled(maxReached)
                        .onChange(of: userInput) { newValue in
                            handleTextChange(newValue)
                        }
                        .onSubmit {
                            hideKeyboard()
                        }
                        .frame(width: UIScreen.main.bounds.width - 40)
                    
                }
                .padding(.bottom, 30)
            }
            
            
            // Floating Refresh Button
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        refreshID = UUID() //Generate new ID to refresh GrungeEffect
                    }) {
                        Image(systemName: "arrow.clockwise.circle.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.white)
                            .shadow(radius: 5)
                    }.padding(.trailing, 20)
                }
                Spacer()
            }
        }
        .compositingGroup()
        .onAppear {
            adjustFontSize()
        }
    }

    // Handle Text Change with Smart Trimming
    private func handleTextChange(_ newValue: String) {
        let estimatedHeight = estimatedTextHeight(for: newValue, fontSize: fontSize)

        if estimatedHeight > UIScreen.main.bounds.height * maxHeightFactor, fontSize <= minFontSize {
            maxReached = true
            userInput = trimTextToFit(newValue) // Trim last visible word
        } else {
            maxReached = false
            userInput = newValue
            adjustFontSize()
        }
    }

    // Adjust Font Size Dynamically
    private func adjustFontSize() {
        var currentSize = maxFontSize

        while estimatedTextHeight(for: userInput, fontSize: currentSize) > UIScreen.main.bounds.height * maxHeightFactor,
              currentSize > minFontSize {
            currentSize -= 1
        }

        fontSize = currentSize
    }

    // Estimate Text Height
    private func estimatedTextHeight(for text: String, fontSize: CGFloat) -> CGFloat {
        let uiFont = UIFont.systemFont(ofSize: fontSize, weight: .heavy)
        let attributedString = NSAttributedString(string: text, attributes: [.font: uiFont])
        let textWidth = UIScreen.main.bounds.width - 40

        let boundingRect = attributedString.boundingRect(
            with: CGSize(width: textWidth, height: .greatestFiniteMagnitude),
            options: .usesLineFragmentOrigin,
            context: nil
        )

        return boundingRect.height
    }

    // Trim Text to Last Visible Word
    private func trimTextToFit(_ text: String) -> String {
        var words = text.split(separator: " ").map { String($0) }
        while !words.isEmpty {
            let trimmedText = words.joined(separator: " ")
            if estimatedTextHeight(for: trimmedText, fontSize: fontSize) <= UIScreen.main.bounds.height * maxHeightFactor {
                return trimmedText
            }
            words.removeLast()
        }
        return "" // If no words fit, return empty string
    }
}

 //Grunge Effect - with single shape ex., circle, rectangle
//struct GrungeEffect: View {
//    var body: some View {
//        Canvas { context, size in
//            for _ in 0..<500 {
//                let x = CGFloat.random(in: 0..<size.width)
//                let y = CGFloat.random(in: 0..<size.height)
//                let radius = CGFloat.random(in: 1...8)
//                let opacity = Double.random(in: 0.4...1.0)
//
//                context.fill(
//                    Circle().path(in: CGRect(x: x, y: y, width: radius, height: radius)),
//                    with: .color(.black.opacity(opacity))
//                )
//            }
//        }
//    }
//}

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


// Hide Keyboard Helper
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
