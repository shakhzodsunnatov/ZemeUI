//
//  Shadow+.swift
//  ReZeme
//
//  Created by Yunus on 06/02/23.
//

import SwiftUI

extension View {
    func glow(radius: CGFloat = 20) -> some View {
        self
            .shadow(color: Color("shadowColor"), radius: radius, x: 4, y: 4)
    }
    
    func glowEasy(radius: CGFloat = 25) -> some View {
        self
            .shadow(color: Color("shadowColor"), radius: radius, x: 4, y: 4)
    }
    
    func glowHard(radius: CGFloat = 10) -> some View {
        self
            .shadow(color: Color.gray.opacity(0.5), radius: radius, x: 4, y: 4)
    }
}
