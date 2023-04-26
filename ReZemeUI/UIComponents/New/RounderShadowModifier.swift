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
    
    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(backgroundColor)
                    .glowEasy()
            )
    }
}


//MARK: - View Modify, .roundedShadow()

extension View {
    
    func roundedShadow(cornerRadius: CGFloat = 8, backgroundColor: Color = Color.white) -> some View {
        modifier(RounderShadowModifier(cornerRadius: cornerRadius, backgroundColor: backgroundColor))
    }
    
}

struct RounderShadowModifier_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hey")
            .font(.system(size: 32))
            .frame(width: 300, height: 300)
            .roundedShadow()
            .padding(30)
    }
}
