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
    
    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Color.white)
                    .glowEasy()
            )
    }
}


//MARK: - View Modify, .roundedShadow()

extension View {
    
    func roundedShadow(cornerRadius: CGFloat = 8) -> some View {
        modifier(RounderShadowModifier(cornerRadius: cornerRadius))
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
