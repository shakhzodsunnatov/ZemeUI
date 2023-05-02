//
//  NavigationLazy.swift
//  ReZeme
//
//  Created by Shakhzod on 01/04/23.
//

import SwiftUI

struct NavigationLazyView<Content: View>: View {
    let build: () -> Content
    
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    
    
    
    var body: Content {
        build()
    }
}
