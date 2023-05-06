//
//  ToggleUI.swift
//  ReZemeUI
//
//  Created by Shakhzod on 02/05/23.
//

import SwiftUI

struct ToggleUI: View {
    
    @Binding var changeValue: Int
    
    let titles: [String]
    let valueChanged: (Int)-> Void
    
    @State var selectIndex = 0
    
    @State private var isAppeared = false
    
    init(changeValue: Binding<Int>? = nil, titles: [String], valueChanged: @escaping (Int) -> Void, selectIndex: Int = 0, isAppeared: Bool = false) {
        self._changeValue = changeValue ?? .constant(0)
        self.titles = titles
        self.valueChanged = valueChanged
        self.selectIndex = selectIndex
        self.isAppeared = isAppeared
    }
    
    var body: some View {
        GeometryReader { geo in
            
            ZStack {
                
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.blueGradient.toLinearGradient)
                    .frame(width: geo.frame(in: .local).width/CGFloat(titles.count))
                    .offset(x: geo.frame(in: .local).width/CGFloat(titles.count) * CGFloat(selectIndex))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                
                HStack(spacing: 0) {
                    
                    ForEach((0..<titles.count), id: \.self) { index in
                        
                        if selectIndex == index {
                            Text(titles[index])
                                .semibold14
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .makeButton {
                                    withAnimation {
                                        selectIndex = index
                                        valueChanged(index)
                                    }
                                }
                        } else {
                            Text(titles[index])
                                .regular14
                                .foregroundColor(.textGray)
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
            }
            .animation(isAppeared ? .spring() : nil)
        }
        .padding(.horizontal,6)
        .padding(.vertical, 5)
        .frame(height: 40)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .strokeBorder(Color.textGray.opacity(0.3))
        )
        .onAppear {
            isAppeared = true
        }
        .onChange(of: changeValue) { newValue in
            if newValue != selectIndex {
                selectIndex = newValue
            }
        }
    }
}

struct ToggleUI_Previews: PreviewProvider {
    static var previews: some View {
        ToggleUI(titles: ["Tenants", "Agents"]) { _ in }
    }
}
