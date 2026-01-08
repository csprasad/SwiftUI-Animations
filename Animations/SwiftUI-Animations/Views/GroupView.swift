//
//  GroupView.swift
//  SwiftUI-Animations
//
//  Created by CS Prasad on 20/03/25.
//

import SwiftUI

struct GroupView<Content: View>: View {
    var title: String
    var note: String?
    let content: () -> Content
    
    var body: some View {
            content()
        .navigationBarTitle(title, displayMode: .inline)
    }
}

struct GroupView_Previews: PreviewProvider {
    static var previews: some View {
        GroupView(title: "Group", note: "", content: { Text("Content") })
            .previewLayout(.sizeThatFits)
    }
}
