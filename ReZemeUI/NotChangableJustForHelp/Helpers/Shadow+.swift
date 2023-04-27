//
//  Shadow+.swift
//  ReZeme
//
//  Created by Yunus on 06/02/23.
//

import SwiftUI

extension View {
    func glow(radius: CGFloat = 20) -> some View {
        self.shadow(color: Color("shadowColor"), radius: radius, x: 4, y: 4)
    }
    
    func glowEasy(radius: CGFloat = 25) -> some View {
        self.shadow(color: Color("shadowColor"), radius: radius, x: 4, y: 4)
    }
    
    func glowHard(radius: CGFloat = 10) -> some View {
        self.shadow(color: Color.gray.opacity(0.5), radius: radius, x: 4, y: 4)
    }
    
    func customShadow(color: Color = Color("shadowColor"), radius: CGFloat = 10, x: CGFloat, y: CGFloat ) -> some View {
        self.shadow(color: color, radius: radius, x: x, y: y) // (hexString: "B6B6D2") same ("shadowColor")
    }
}
