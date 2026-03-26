//
//  Lightening.swift
//  SwiftUI-Animations
//
/// Created by `C S Prasad` on `14/07/23`
///
/// ### Social
/// `Instagram` : ``@csprasad.ios`` • `X` : ``@csprasad_ios`` • `Github` : ``@csprasad``
///

import SwiftUI

struct Bat: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.77385*width, y: 0.02119*height))
        path.addCurve(to: CGPoint(x: 0.58216*width, y: 0.44408*height), control1: CGPoint(x: 0.75439*width, y: 0.20793*height), control2: CGPoint(x: 0.68734*width, y: 0.38286*height))
        path.addCurve(to: CGPoint(x: 0.55637*width, y: 0.25146*height), control1: CGPoint(x: 0.57351*width, y: 0.37992*height), control2: CGPoint(x: 0.56504*width, y: 0.31563*height))
        path.addCurve(to: CGPoint(x: 0.52836*width, y: 0.31679*height), control1: CGPoint(x: 0.54706*width, y: 0.2733*height), control2: CGPoint(x: 0.53767*width, y: 0.29497*height))
        path.addCurve(to: CGPoint(x: 0.47164*width, y: 0.31679*height), control1: CGPoint(x: 0.51941*width, y: 0.29896*height), control2: CGPoint(x: 0.48059*width, y: 0.29896*height))
        path.addCurve(to: CGPoint(x: 0.44363*width, y: 0.25146*height), control1: CGPoint(x: 0.46233*width, y: 0.29497*height), control2: CGPoint(x: 0.45294*width, y: 0.2733*height))
        path.addCurve(to: CGPoint(x: 0.41784*width, y: 0.44408*height), control1: CGPoint(x: 0.43496*width, y: 0.31563*height), control2: CGPoint(x: 0.42649*width, y: 0.37992*height))
        path.addCurve(to: CGPoint(x: 0.22615*width, y: 0.02119*height), control1: CGPoint(x: 0.31292*width, y: 0.38301*height), control2: CGPoint(x: 0.24551*width, y: 0.20696*height))
        path.addCurve(to: CGPoint(x: 0.01332*width, y: 0.23632*height), control1: CGPoint(x: 0.17779*width, y: 0.15651*height), control2: CGPoint(x: 0.10706*width, y: 0.23809*height))
        path.addCurve(to: CGPoint(x: 0.12972*width, y: 0.46289*height), control1: CGPoint(x: 0.07245*width, y: 0.25023*height), control2: CGPoint(x: 0.12987*width, y: 0.33463*height))
        path.addCurve(to: CGPoint(x: 0.23397*width, y: 0.47402*height), control1: CGPoint(x: 0.16425*width, y: 0.44101*height), control2: CGPoint(x: 0.20333*width, y: 0.43255*height))
        path.addCurve(to: CGPoint(x: 0.28243*width, y: 0.69396*height), control1: CGPoint(x: 0.26666*width, y: 0.51761*height), control2: CGPoint(x: 0.28129*width, y: 0.60973*height))
        path.addCurve(to: CGPoint(x: 0.47641*width, y: 0.97881*height), control1: CGPoint(x: 0.36623*width, y: 0.56292*height), control2: CGPoint(x: 0.43962*width, y: 0.77142*height))
        path.addCurve(to: CGPoint(x: 0.5*width, y: 0.86078*height), control1: CGPoint(x: 0.47807*width, y: 0.9642*height), control2: CGPoint(x: 0.48247*width, y: 0.91417*height))
        path.addCurve(to: CGPoint(x: 0.52359*width, y: 0.97881*height), control1: CGPoint(x: 0.51435*width, y: 0.90447*height), control2: CGPoint(x: 0.51939*width, y: 0.94186*height))
        path.addCurve(to: CGPoint(x: 0.71757*width, y: 0.69396*height), control1: CGPoint(x: 0.56086*width, y: 0.76871*height), control2: CGPoint(x: 0.63414*width, y: 0.56349*height))
        path.addCurve(to: CGPoint(x: 0.87028*width, y: 0.46289*height), control1: CGPoint(x: 0.71999*width, y: 0.5148*height), control2: CGPoint(x: 0.77034*width, y: 0.39957*height))
        path.addCurve(to: CGPoint(x: 0.98668*width, y: 0.23632*height), control1: CGPoint(x: 0.87012*width, y: 0.33284*height), control2: CGPoint(x: 0.92858*width, y: 0.24999*height))
        path.addCurve(to: CGPoint(x: 0.77385*width, y: 0.02119*height), control1: CGPoint(x: 0.89297*width, y: 0.23809*height), control2: CGPoint(x: 0.82194*width, y: 0.15576*height))
        path.closeSubpath()
        return path
    }
}

struct Lightening_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Bat()
        }
        .frame(width: 200,height: 100)
        .ignoresSafeArea()
    }
}
