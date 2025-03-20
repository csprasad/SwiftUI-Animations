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
            Grouping(title: "TestingView", content: { TestingView() })
            Grouping(title: "Layer Masking", content: { LayerMaskUIView() })
            Grouping(title: "Loader", content: { LoaderUIView() })
            Grouping(title: "Random Animation", content: { RandomAnimationView() })
            Group{
                Grouping(title: "Sunrise", content: { SunRiseUIView() })
                Grouping(title: "Batman", content: { BatmanView() })
            }
            Grouping(title: "Grid", content: { GridView() })
            Grouping(title: "kakashi", content: { KakashiView() })
            Grouping(title: "Splash", content: { SplashView() })
            Grouping(title: "Glassy Button", content: { GlassyButtonView() })
            Grouping(title: "Rocket Launch", content: { RocketLaunchView() })
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
