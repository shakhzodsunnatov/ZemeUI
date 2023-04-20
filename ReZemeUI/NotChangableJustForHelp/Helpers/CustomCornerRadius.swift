//
//  CustomCornerRadius.swift
//  ReZeme
//
//  Created by Yunus on 19/02/23.
//

import SwiftUI
/*
 
 Usage
 
 .cornerRadius(radius: 20.0, corners: [.topLeft])
 
 Rectangle()
 .frame(width: 100, height: 100, alignment: .center)
 .cornerRadius(radius: 20.0, corners: [.topLeft, .bottomLeft])
 
 */

struct CornerRadiusShape: Shape {
    var radius = CGFloat.infinity
    var corners = UIRectCorner.allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct CornerRadiusStyle: ViewModifier {
    var radius: CGFloat
    var corners: UIRectCorner
    
    func body(content: Content) -> some View {
        content
            .clipShape(CornerRadiusShape(radius: radius, corners: corners))
    }
}

extension View {
    func cornerRadius(radius: CGFloat, corners: UIRectCorner) -> some View {
        ModifiedContent(content: self, modifier: CornerRadiusStyle(radius: radius, corners: corners))
    }
}
