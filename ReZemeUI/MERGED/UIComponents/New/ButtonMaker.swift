//
//  ButtonMaker.swift
//  ReZemeUI
//
//  Created by Shakhzod on 23/04/23.
//

import SwiftUI

struct ButtonMaker: ViewModifier {
    
    var action: ()->Void
    
    func body(content: Content) -> some View {
        Button(action: action) {
            content
        }
    }
}

extension View {
    
    func makeButton(action: @escaping () -> Void) -> some View {
        modifier(
            ButtonMaker(action: action)
        )
    }
}

struct ButtonMaker_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello Tapp me")
            .makeButton { /*Button Action here*/}
    }
}
