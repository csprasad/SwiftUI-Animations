//
//  GroupView.swift
//  SwiftUI-Animations
//
/// Created by `C S Prasad` on `15/07/23`
///
/// ### Social
/// `Instagram` : ``@csprasad.ios`` • `X` : ``@csprasad_ios`` • `Github` : ``@csprasad``
///

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
