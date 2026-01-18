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
                Grouping(title: "Crowd Walking",note: "", content: { CrowdContainerViewFixed() })
                Grouping(title: "Sunrise", content: { SunRiseUIView() })
                Grouping(title: "Batman", content: { BatmanView() })
            }
            Group {
                Grouping(title: "Morph Blob", content: { MorphBlob() })
                Grouping(title: "Planetary Atom", content: { PlanetaryAtom() })
            }
            Group {
                Grouping(title: "Carbon Atom", content: { CarbonAtom() })
                Grouping(title: "Layer Masking", content: { LayerMaskUIView() })
                Grouping(title: "Masking", content: { MaskingView() })
                Grouping(title: "kakashi", content: { KakashiView() })

            }
            Group {
                Grouping(title: "Like Button", content: { LikeButton() })
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
    var note: String?
    var content: () -> Content
    
    var body: some View {
        NavigationLink(destination: GroupView(title: title, note: note, content: content)) {
            VStack(alignment: .leading, spacing: 4) {
                Text(title).font(.headline)
                Text(note ?? "").font(.subheadline).foregroundColor(.secondary)
            }.padding(.vertical, 4)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
