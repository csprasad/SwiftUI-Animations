//
//  ContentView.swift
//  SwiftUI-Animations
//
//  Created by CS Prasad on 14/07/23.
//

import SwiftUI

struct ContentView: View {
    
    var list: some View {
        List {
            Group{
                Grouping(title: "Sunrise", content: { SunRiseUIView() })
                Grouping(title: "Batman", content: { BatmanView() })
                Grouping(title: "Planetary Atom", content: { PlanetaryAtom() })
                Grouping(title: "Carbon Atom", content: { CarbonAtom() })
            }
            Group {
                Grouping(title: "Layer Masking", content: { LayerMaskUIView() })
                Grouping(title: "Masking", content: { MaskingView() })
                Grouping(title: "kakashi", content: { KakashiView() })

            }
            Group {
                Grouping(title: "Splash", content: { SplashView() })
                Grouping(title: "Loader", content: { LoaderUIView() })
                Grouping(title: "Glassy Button", content: { GlassyButtonView() })
            }
            
            Group {
                Grouping(title: "Distressed Font", content: { distressedFont() })
                Grouping(title: "Random Animation", content: { RandomAnimationView() })
            }
            
        }
    }
    
    var body: some View {
        NavigationView {
            list.navigationBarTitle("SwiftUI-Animations")
            Text("Select a group")
        }
        .accentColor(.accentColor)
    }
}

struct Grouping<Content: View>: View {
    var title: String
    var content: () -> Content
    
    var body: some View {
        NavigationLink(destination: GroupView(title: title, content: content)) {
            Text(title).font(.headline).padding(.vertical, 8)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
