//
//  RounderShadowModifier.swift
//  ReZemeUI
//
//  Created by Shakhzod on 25/04/23.
//

import SwiftUI

struct RounderShadowModifier: ViewModifier {
    
    //MARK: - PROPERTIES
    
    var cornerRadius: CGFloat = 8.0
    var backgroundColor: Color = Color.white

    var shadowColor: Color = Color("shadowColor")
    var shadowRadius: CGFloat = 25
    var shadowX: CGFloat = 4
    var shadowY: CGFloat = 4
    
    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(backgroundColor)
                    .customShadow(
                        color: shadowColor,
                        radius: shadowRadius,
                        x: shadowX,
                        y: shadowY
                    )
            )
    }
}


//MARK: - View Modify, .roundedShadow()

extension View {
    
    func roundedShadow(
        cornerRadius: CGFloat = 8,
        backgroundColor: Color = Color.white,
        shadowColor: Color = Color("shadowColor"),
        shadowRadius: CGFloat = 25,
        shadowX: CGFloat = 4,
        shadowY: CGFloat = 4
    ) -> some View {
        modifier(
            RounderShadowModifier(
                cornerRadius: cornerRadius,
                backgroundColor: backgroundColor,
                shadowColor: shadowColor,
                shadowRadius: shadowRadius,
                shadowX: shadowX,
                shadowY: shadowY
            )
        )
    }
    
    func roundedShadowNew(cornerRadius: CGFloat = 8) -> some View {
        modifier(
            RounderShadowModifier(
                shadowColor: Color(hexString: "B6B6D2").opacity(0.22),
                shadowRadius: 15
            )
        )
    }
    
}

struct RounderShadowModifier_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Text("new")
                .font(.system(size: 32))
                .frame(width: 300, height: 300)
                .roundedShadow()
                .padding(30)
        }
    }
}
