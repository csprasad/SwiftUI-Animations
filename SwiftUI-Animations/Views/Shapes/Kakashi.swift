//
//  Kakashi.swift
//  SwiftUI-Animations
//
//  Created by CS Prasad on 15/07/23.
//

import SwiftUI

struct KakashiShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.32495*width, y: 0.01929*height))
        path.addCurve(to: CGPoint(x: 0.20146*width, y: 0.20988*height), control1: CGPoint(x: 0.24036*width, y: 0.06076*height), control2: CGPoint(x: 0.20911*width, y: 0.13838*height))
        path.addCurve(to: CGPoint(x: 0.18856*width, y: 0.20569*height), control1: CGPoint(x: 0.19744*width, y: 0.20873*height), control2: CGPoint(x: 0.19215*width, y: 0.20689*height))
        path.addCurve(to: CGPoint(x: 0.15914*width, y: 0.18896*height), control1: CGPoint(x: 0.17367*width, y: 0.20073*height), control2: CGPoint(x: 0.16428*width, y: 0.19546*height))
        path.addCurve(to: CGPoint(x: 0.16659*width, y: 0.40828*height), control1: CGPoint(x: 0.09812*width, y: 0.29871*height), control2: CGPoint(x: 0.1271*width, y: 0.36333*height))
        path.addLine(to: CGPoint(x: 0.16671*width, y: 0.57035*height))
        path.addCurve(to: CGPoint(x: 0.16703*width, y: 0.57402*height), control1: CGPoint(x: 0.16671*width, y: 0.57158*height), control2: CGPoint(x: 0.16695*width, y: 0.57279*height))
        path.addCurve(to: CGPoint(x: 0.16699*width, y: 0.58337*height), control1: CGPoint(x: 0.16703*width, y: 0.57466*height), control2: CGPoint(x: 0.16701*width, y: 0.58204*height))
        path.addLine(to: CGPoint(x: 0.14587*width, y: 0.58354*height))
        path.addCurve(to: CGPoint(x: 0.1252*width, y: 0.60433*height), control1: CGPoint(x: 0.13444*width, y: 0.58362*height), control2: CGPoint(x: 0.1252*width, y: 0.59289*height))
        path.addLine(to: CGPoint(x: 0.12508*width, y: 0.72074*height))
        path.addCurve(to: CGPoint(x: 0.13123*width, y: 0.73556*height), control1: CGPoint(x: 0.12508*width, y: 0.72631*height), control2: CGPoint(x: 0.12727*width, y: 0.73164*height))
        path.addLine(to: CGPoint(x: 0.18429*width, y: 0.78821*height))
        path.addCurve(to: CGPoint(x: 0.21187*width, y: 0.84469*height), control1: CGPoint(x: 0.19083*width, y: 0.80701*height), control2: CGPoint(x: 0.19952*width, y: 0.82589*height))
        path.addLine(to: CGPoint(x: 0.21187*width, y: 0.84473*height))
        path.addCurve(to: CGPoint(x: 0.22542*width, y: 0.85982*height), control1: CGPoint(x: 0.21685*width, y: 0.85228*height), control2: CGPoint(x: 0.22014*width, y: 0.85481*height))
        path.addCurve(to: CGPoint(x: 0.24495*width, y: 0.87695*height), control1: CGPoint(x: 0.23071*width, y: 0.86483*height), control2: CGPoint(x: 0.23723*width, y: 0.87058*height))
        path.addCurve(to: CGPoint(x: 0.30326*width, y: 0.91972*height), control1: CGPoint(x: 0.26041*width, y: 0.88971*height), control2: CGPoint(x: 0.28055*width, y: 0.9049*height))
        path.addCurve(to: CGPoint(x: 0.45687*width, y: 0.97913*height), control1: CGPoint(x: 0.34857*width, y: 0.94928*height), control2: CGPoint(x: 0.40235*width, y: 0.97896*height))
        path.addCurve(to: CGPoint(x: 0.61198*width, y: 0.92045*height), control1: CGPoint(x: 0.5119*width, y: 0.98035*height), control2: CGPoint(x: 0.56611*width, y: 0.9503*height))
        path.addCurve(to: CGPoint(x: 0.67106*width, y: 0.87728*height), control1: CGPoint(x: 0.63496*width, y: 0.9055*height), control2: CGPoint(x: 0.65537*width, y: 0.89016*height))
        path.addCurve(to: CGPoint(x: 0.69088*width, y: 0.86003*height), control1: CGPoint(x: 0.67891*width, y: 0.87084*height), control2: CGPoint(x: 0.68553*width, y: 0.86503*height))
        path.addCurve(to: CGPoint(x: 0.70435*width, y: 0.84554*height), control1: CGPoint(x: 0.69623*width, y: 0.85503*height), control2: CGPoint(x: 0.69955*width, y: 0.85235*height))
        path.addLine(to: CGPoint(x: 0.70463*width, y: 0.84513*height))
        path.addLine(to: CGPoint(x: 0.70492*width, y: 0.84473*height))
        path.addCurve(to: CGPoint(x: 0.73311*width, y: 0.78654*height), control1: CGPoint(x: 0.71765*width, y: 0.82536*height), control2: CGPoint(x: 0.72652*width, y: 0.8059*height))
        path.addLine(to: CGPoint(x: 0.78499*width, y: 0.73507*height))
        path.addCurve(to: CGPoint(x: 0.79114*width, y: 0.72026*height), control1: CGPoint(x: 0.78895*width, y: 0.73115*height), control2: CGPoint(x: 0.79114*width, y: 0.72582*height))
        path.addLine(to: CGPoint(x: 0.79102*width, y: 0.60384*height))
        path.addCurve(to: CGPoint(x: 0.77035*width, y: 0.58301*height), control1: CGPoint(x: 0.79102*width, y: 0.5924*height), control2: CGPoint(x: 0.78178*width, y: 0.58309*height))
        path.addLine(to: CGPoint(x: 0.75012*width, y: 0.58289*height))
        path.addLine(to: CGPoint(x: 0.75012*width, y: 0.49723*height))
        path.addCurve(to: CGPoint(x: 0.8335*width, y: 0.58976*height), control1: CGPoint(x: 0.77896*width, y: 0.51825*height), control2: CGPoint(x: 0.80846*width, y: 0.54677*height))
        path.addCurve(to: CGPoint(x: 0.86316*width, y: 0.39335*height), control1: CGPoint(x: 0.89715*width, y: 0.52889*height), control2: CGPoint(x: 0.89743*width, y: 0.45474*height))
        path.addCurve(to: CGPoint(x: 0.93766*width, y: 0.25871*height), control1: CGPoint(x: 0.91004*width, y: 0.36118*height), control2: CGPoint(x: 0.93465*width, y: 0.30976*height))
        path.addCurve(to: CGPoint(x: 0.83582*width, y: 0.23494*height), control1: CGPoint(x: 0.86924*width, y: 0.23912*height), control2: CGPoint(x: 0.8578*width, y: 0.23735*height))
        path.addCurve(to: CGPoint(x: 0.81689*width, y: 0.23385*height), control1: CGPoint(x: 0.83062*width, y: 0.23438*height), control2: CGPoint(x: 0.82314*width, y: 0.23432*height))
        path.addCurve(to: CGPoint(x: 0.89514*width, y: 0.05644*height), control1: CGPoint(x: 0.85497*width, y: 0.1823*height), control2: CGPoint(x: 0.88599*width, y: 0.12942*height))
        path.addCurve(to: CGPoint(x: 0.62699*width, y: 0.13619*height), control1: CGPoint(x: 0.79674*width, y: 0.06209*height), control2: CGPoint(x: 0.70343*width, y: 0.11626*height))
        path.addCurve(to: CGPoint(x: 0.644*width, y: 0.0627*height), control1: CGPoint(x: 0.63067*width, y: 0.10875*height), control2: CGPoint(x: 0.63637*width, y: 0.0849*height))
        path.addCurve(to: CGPoint(x: 0.37581*width, y: 0.12077*height), control1: CGPoint(x: 0.52858*width, y: 0.02217*height), control2: CGPoint(x: 0.44173*width, y: 0.05767*height))
        path.addCurve(to: CGPoint(x: 0.35758*width, y: 0.04667*height), control1: CGPoint(x: 0.36749*width, y: 0.09661*height), control2: CGPoint(x: 0.36054*width, y: 0.07087*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.57141*width, y: 0.08923*height))
        path.addCurve(to: CGPoint(x: 0.56051*width, y: 0.17635*height), control1: CGPoint(x: 0.56534*width, y: 0.11385*height), control2: CGPoint(x: 0.56051*width, y: 0.14141*height))
        path.addCurve(to: CGPoint(x: 0.81458*width, y: 0.11955*height), control1: CGPoint(x: 0.67338*width, y: 0.20061*height), control2: CGPoint(x: 0.75068*width, y: 0.15918*height))
        path.addCurve(to: CGPoint(x: 0.72689*width, y: 0.25098*height), control1: CGPoint(x: 0.79658*width, y: 0.16525*height), control2: CGPoint(x: 0.76795*width, y: 0.20296*height))
        path.addCurve(to: CGPoint(x: 0.82902*width, y: 0.29708*height), control1: CGPoint(x: 0.79004*width, y: 0.29196*height), control2: CGPoint(x: 0.80612*width, y: 0.29458*height))
        path.addCurve(to: CGPoint(x: 0.86275*width, y: 0.29801*height), control1: CGPoint(x: 0.83868*width, y: 0.29813*height), control2: CGPoint(x: 0.85046*width, y: 0.29848*height))
        path.addCurve(to: CGPoint(x: 0.8092*width, y: 0.35372*height), control1: CGPoint(x: 0.85284*width, y: 0.32165*height), control2: CGPoint(x: 0.83776*width, y: 0.34229*height))
        path.addCurve(to: CGPoint(x: 0.82821*width, y: 0.48311*height), control1: CGPoint(x: 0.81423*width, y: 0.42294*height), control2: CGPoint(x: 0.82369*width, y: 0.45244*height))
        path.addCurve(to: CGPoint(x: 0.71134*width, y: 0.39929*height), control1: CGPoint(x: 0.78593*width, y: 0.44094*height), control2: CGPoint(x: 0.7416*width, y: 0.4149*height))
        path.addLine(to: CGPoint(x: 0.64339*width, y: 0.44568*height))
        path.addCurve(to: CGPoint(x: 0.56095*width, y: 0.33944*height), control1: CGPoint(x: 0.62387*width, y: 0.40456*height), control2: CGPoint(x: 0.59753*width, y: 0.36453*height))
        path.addLine(to: CGPoint(x: 0.21688*width, y: 0.33297*height))
        path.addCurve(to: CGPoint(x: 0.19474*width, y: 0.33846*height), control1: CGPoint(x: 0.20859*width, y: 0.33297*height), control2: CGPoint(x: 0.20121*width, y: 0.33505*height))
        path.addCurve(to: CGPoint(x: 0.17208*width, y: 0.26603*height), control1: CGPoint(x: 0.18402*width, y: 0.31802*height), control2: CGPoint(x: 0.17644*width, y: 0.29406*height))
        path.addCurve(to: CGPoint(x: 0.21712*width, y: 0.28035*height), control1: CGPoint(x: 0.1899*width, y: 0.27175*height), control2: CGPoint(x: 0.20655*width, y: 0.27577*height))
        path.addCurve(to: CGPoint(x: 0.30656*width, y: 0.10754*height), control1: CGPoint(x: 0.25942*width, y: 0.20381*height), control2: CGPoint(x: 0.27527*width, y: 0.14561*height))
        path.addCurve(to: CGPoint(x: 0.33748*width, y: 0.19161*height), control1: CGPoint(x: 0.31393*width, y: 0.13714*height), control2: CGPoint(x: 0.32338*width, y: 0.16638*height))
        path.addCurve(to: CGPoint(x: 0.57141*width, y: 0.08923*height), control1: CGPoint(x: 0.43456*width, y: 0.13665*height), control2: CGPoint(x: 0.50268*width, y: 0.10091*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.22921*width, y: 0.39547*height))
        path.addLine(to: CGPoint(x: 0.53109*width, y: 0.39547*height))
        path.addCurve(to: CGPoint(x: 0.55709*width, y: 0.42273*height), control1: CGPoint(x: 0.53959*width, y: 0.40236*height), control2: CGPoint(x: 0.54843*width, y: 0.41176*height))
        path.addLine(to: CGPoint(x: 0.54411*width, y: 0.43469*height))
        path.addCurve(to: CGPoint(x: 0.48905*width, y: 0.41768*height), control1: CGPoint(x: 0.53359*width, y: 0.42769*height), control2: CGPoint(x: 0.51414*width, y: 0.41768*height))
        path.addCurve(to: CGPoint(x: 0.41683*width, y: 0.47929*height), control1: CGPoint(x: 0.44943*width, y: 0.41768*height), control2: CGPoint(x: 0.41843*width, y: 0.44456*height))
        path.addLine(to: CGPoint(x: 0.3951*width, y: 0.52694*height))
        path.addCurve(to: CGPoint(x: 0.39608*width, y: 0.53662*height), control1: CGPoint(x: 0.39364*width, y: 0.5301*height), control2: CGPoint(x: 0.39404*width, y: 0.53377*height))
        path.addCurve(to: CGPoint(x: 0.40535*width, y: 0.54122*height), control1: CGPoint(x: 0.39814*width, y: 0.5395*height), control2: CGPoint(x: 0.40163*width, y: 0.54122*height))
        path.addLine(to: CGPoint(x: 0.48067*width, y: 0.54122*height))
        path.addCurve(to: CGPoint(x: 0.52812*width, y: 0.49748*height), control1: CGPoint(x: 0.49903*width, y: 0.54122*height), control2: CGPoint(x: 0.52812*width, y: 0.52935*height))
        path.addCurve(to: CGPoint(x: 0.49463*width, y: 0.45886*height), control1: CGPoint(x: 0.52812*width, y: 0.47512*height), control2: CGPoint(x: 0.51402*width, y: 0.45886*height))
        path.addCurve(to: CGPoint(x: 0.46126*width, y: 0.48572*height), control1: CGPoint(x: 0.47152*width, y: 0.45886*height), control2: CGPoint(x: 0.4627*width, y: 0.47643*height))
        path.addCurve(to: CGPoint(x: 0.47074*width, y: 0.49736*height), control1: CGPoint(x: 0.46039*width, y: 0.49134*height), control2: CGPoint(x: 0.46466*width, y: 0.49656*height))
        path.addCurve(to: CGPoint(x: 0.48336*width, y: 0.48861*height), control1: CGPoint(x: 0.47697*width, y: 0.49821*height), control2: CGPoint(x: 0.4825*width, y: 0.49423*height))
        path.addCurve(to: CGPoint(x: 0.49463*width, y: 0.47945*height), control1: CGPoint(x: 0.48348*width, y: 0.48767*height), control2: CGPoint(x: 0.48505*width, y: 0.47945*height))
        path.addCurve(to: CGPoint(x: 0.50578*width, y: 0.49748*height), control1: CGPoint(x: 0.50194*width, y: 0.47945*height), control2: CGPoint(x: 0.50578*width, y: 0.48852*height))
        path.addCurve(to: CGPoint(x: 0.48067*width, y: 0.52063*height), control1: CGPoint(x: 0.50578*width, y: 0.52*height), control2: CGPoint(x: 0.4809*width, y: 0.52063*height))
        path.addCurve(to: CGPoint(x: 0.43884*width, y: 0.48201*height), control1: CGPoint(x: 0.45484*width, y: 0.52063*height), control2: CGPoint(x: 0.43884*width, y: 0.50585*height))
        path.addCurve(to: CGPoint(x: 0.48905*width, y: 0.43827*height), control1: CGPoint(x: 0.43884*width, y: 0.46051*height), control2: CGPoint(x: 0.45762*width, y: 0.43827*height))
        path.addCurve(to: CGPoint(x: 0.53695*width, y: 0.45585*height), control1: CGPoint(x: 0.51724*width, y: 0.43827*height), control2: CGPoint(x: 0.5368*width, y: 0.45571*height))
        path.addCurve(to: CGPoint(x: 0.55273*width, y: 0.45585*height), control1: CGPoint(x: 0.5413*width, y: 0.45987*height), control2: CGPoint(x: 0.5484*width, y: 0.45987*height))
        path.addLine(to: CGPoint(x: 0.56982*width, y: 0.4401*height))
        path.addCurve(to: CGPoint(x: 0.60563*width, y: 0.51335*height), control1: CGPoint(x: 0.58695*width, y: 0.46534*height), control2: CGPoint(x: 0.60124*width, y: 0.49367*height))
        path.addLine(to: CGPoint(x: 0.68762*width, y: 0.49068*height))
        path.addLine(to: CGPoint(x: 0.68762*width, y: 0.56197*height))
        path.addLine(to: CGPoint(x: 0.22921*width, y: 0.56197*height))
        path.addLine(to: CGPoint(x: 0.22921*width, y: 0.39547*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.22933*width, y: 0.62447*height))
        path.addLine(to: CGPoint(x: 0.29366*width, y: 0.62447*height))
        path.addLine(to: CGPoint(x: 0.56429*width, y: 0.62447*height))
        path.addLine(to: CGPoint(x: 0.68762*width, y: 0.62447*height))
        path.addLine(to: CGPoint(x: 0.68762*width, y: 0.65784*height))
        path.addCurve(to: CGPoint(x: 0.67655*width, y: 0.75899*height), control1: CGPoint(x: 0.68762*width, y: 0.69399*height), control2: CGPoint(x: 0.68629*width, y: 0.72687*height))
        path.addCurve(to: CGPoint(x: 0.58236*width, y: 0.7133*height), control1: CGPoint(x: 0.64949*width, y: 0.75471*height), control2: CGPoint(x: 0.61619*width, y: 0.73574*height))
        path.addCurve(to: CGPoint(x: 0.45833*width, y: 0.65625*height), control1: CGPoint(x: 0.54383*width, y: 0.68774*height), control2: CGPoint(x: 0.50686*width, y: 0.65625*height))
        path.addCurve(to: CGPoint(x: 0.33407*width, y: 0.7137*height), control1: CGPoint(x: 0.40968*width, y: 0.65625*height), control2: CGPoint(x: 0.37266*width, y: 0.68796*height))
        path.addCurve(to: CGPoint(x: 0.24032*width, y: 0.7596*height), control1: CGPoint(x: 0.30041*width, y: 0.73616*height), control2: CGPoint(x: 0.26723*width, y: 0.75511*height))
        path.addCurve(to: CGPoint(x: 0.22917*width, y: 0.65784*height), control1: CGPoint(x: 0.23044*width, y: 0.72727*height), control2: CGPoint(x: 0.22917*width, y: 0.69421*height))
        path.addCurve(to: CGPoint(x: 0.22933*width, y: 0.62447*height), control1: CGPoint(x: 0.22917*width, y: 0.63728*height), control2: CGPoint(x: 0.22926*width, y: 0.63871*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.45833*width, y: 0.71875*height))
        path.addCurve(to: CGPoint(x: 0.54781*width, y: 0.76538*height), control1: CGPoint(x: 0.47231*width, y: 0.71875*height), control2: CGPoint(x: 0.50822*width, y: 0.73912*height))
        path.addCurve(to: CGPoint(x: 0.64583*width, y: 0.81645*height), control1: CGPoint(x: 0.57688*width, y: 0.78467*height), control2: CGPoint(x: 0.60914*width, y: 0.80628*height))
        path.addCurve(to: CGPoint(x: 0.63139*width, y: 0.82898*height), control1: CGPoint(x: 0.64194*width, y: 0.82*height), control2: CGPoint(x: 0.63738*width, y: 0.82407*height))
        path.addCurve(to: CGPoint(x: 0.57788*width, y: 0.86808*height), control1: CGPoint(x: 0.61743*width, y: 0.84044*height), control2: CGPoint(x: 0.59861*width, y: 0.85459*height))
        path.addCurve(to: CGPoint(x: 0.45809*width, y: 0.91675*height), control1: CGPoint(x: 0.53642*width, y: 0.89506*height), control2: CGPoint(x: 0.4854*width, y: 0.91741*height))
        path.addLine(to: CGPoint(x: 0.45772*width, y: 0.91675*height))
        path.addLine(to: CGPoint(x: 0.45732*width, y: 0.91675*height))
        path.addCurve(to: CGPoint(x: 0.3374*width, y: 0.86735*height), control1: CGPoint(x: 0.42903*width, y: 0.91675*height), control2: CGPoint(x: 0.37838*width, y: 0.89408*height))
        path.addCurve(to: CGPoint(x: 0.28475*width, y: 0.82874*height), control1: CGPoint(x: 0.31691*width, y: 0.85398*height), control2: CGPoint(x: 0.29841*width, y: 0.84*height))
        path.addCurve(to: CGPoint(x: 0.27124*width, y: 0.81694*height), control1: CGPoint(x: 0.27911*width, y: 0.82408*height), control2: CGPoint(x: 0.27494*width, y: 0.82033*height))
        path.addCurve(to: CGPoint(x: 0.36877*width, y: 0.76571*height), control1: CGPoint(x: 0.30771*width, y: 0.8066*height), control2: CGPoint(x: 0.33983*width, y: 0.78501*height))
        path.addCurve(to: CGPoint(x: 0.45833*width, y: 0.71875*height), control1: CGPoint(x: 0.40844*width, y: 0.73925*height), control2: CGPoint(x: 0.44449*width, y: 0.71875*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.43522*width, y: 0.74215*height))
        path.addCurve(to: CGPoint(x: 0.43229*width, y: 0.74382*height), control1: CGPoint(x: 0.43395*width, y: 0.74196*height), control2: CGPoint(x: 0.43269*width, y: 0.74267*height))
        path.addLine(to: CGPoint(x: 0.4176*width, y: 0.78548*height))
        path.addCurve(to: CGPoint(x: 0.41895*width, y: 0.79781*height), control1: CGPoint(x: 0.41617*width, y: 0.78959*height), control2: CGPoint(x: 0.41667*width, y: 0.79408*height))
        path.addCurve(to: CGPoint(x: 0.45943*width, y: 0.83333*height), control1: CGPoint(x: 0.42603*width, y: 0.80937*height), control2: CGPoint(x: 0.44272*width, y: 0.83333*height))
        path.addCurve(to: CGPoint(x: 0.49878*width, y: 0.79964*height), control1: CGPoint(x: 0.47531*width, y: 0.83333*height), control2: CGPoint(x: 0.49115*width, y: 0.81173*height))
        path.addCurve(to: CGPoint(x: 0.49886*width, y: 0.79435*height), control1: CGPoint(x: 0.4998*width, y: 0.79802*height), control2: CGPoint(x: 0.49984*width, y: 0.796*height))
        path.addCurve(to: CGPoint(x: 0.49406*width, y: 0.79171*height), control1: CGPoint(x: 0.49788*width, y: 0.79271*height), control2: CGPoint(x: 0.49604*width, y: 0.79171*height))
        path.addLine(to: CGPoint(x: 0.45431*width, y: 0.79171*height))
        path.addCurve(to: CGPoint(x: 0.43742*width, y: 0.77576*height), control1: CGPoint(x: 0.44499*width, y: 0.79171*height), control2: CGPoint(x: 0.43742*width, y: 0.78455*height))
        path.addLine(to: CGPoint(x: 0.43742*width, y: 0.74463*height))
        path.addCurve(to: CGPoint(x: 0.43522*width, y: 0.74215*height), control1: CGPoint(x: 0.43742*width, y: 0.7434*height), control2: CGPoint(x: 0.43649*width, y: 0.74233*height))
        path.closeSubpath()
        return path
    }
}


struct KakashiShape_Previews: PreviewProvider {
    static var previews: some View {
        KakashiShape()
    }
}
