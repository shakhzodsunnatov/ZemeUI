//
//  LineView.swift
//  ReZemeUI
//
//  Created by Shakhzod on 23/04/23.
//

import SwiftUI

struct LineView: View {
    
    var height: CGFloat = 0.5
    
    var body: some View {
        Line()
            .stroke(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.blue.opacity(0),
                        Color.blue,
                        Color.blue.opacity(0)
                    ]),
                    startPoint: .leading,
                    endPoint: .trailing
                ), lineWidth: height)
            .frame(height: height)
    }
}

extension LineView {
    struct Line: Shape {
        func path(in rect: CGRect) -> Path {
            var path = Path()
            path.move(to: CGPoint(x: rect.minX, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
            return path
        }
    }
}

struct LineView_Previews: PreviewProvider {
    static var previews: some View {
        LineView()
    }
}
