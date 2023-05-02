//
//  ToggleUI.swift
//  ReZemeUI
//
//  Created by Shakhzod on 02/05/23.
//

import SwiftUI

struct ToggleUI: View {
    
    let titles: [String]
    let valueChanged: (Int)-> Void
    
    @State var selectIndex = 0
    
    
    var body: some View {
        GeometryReader { geo in
            
            ZStack {
                
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.blueGradient.toLinearGradient)
                    .frame(width: geo.frame(in: .local).width/2)
                    .offset(x: geo.frame(in: .local).width/2 * CGFloat(selectIndex))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                
                HStack(spacing: 0) {
                    
                    ForEach((0..<titles.count), id: \.self) { index in
                        
                        Text(titles[index])
                            .semibold14
                            .foregroundColor(selectIndex == index ?  .white : .textGray)
                            .frame(maxWidth: .infinity)
                            .makeButton {
                                withAnimation {
                                    selectIndex = index
                                    valueChanged(index)
                                }
                            }
                        
                    }
                }
            }
            .animation(.spring())
        }
        .padding(.horizontal,6)
        .padding(.vertical, 5)
        .frame(height: 40)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .strokeBorder(Color.textGray.opacity(0.3))
        )
    }
}

struct ToggleUI_Previews: PreviewProvider {
    static var previews: some View {
        ToggleUI(titles: []) { _ in }
    }
}
