//
//  RenterProfileHelperSubviews.swift
//  ReZemeUI
//
//  Created by Shakhzod on 26/04/23.
//

import Foundation
import SwiftUI

//MARK: - RenterProfileEditView & ExpandableSimpleCell

extension RenterProfileEditView {
    
    struct ExpandableProfileCell<Content: View>: View {
        
        @State var isActive = true
        let title: String
        let content: () -> Content
        
        init(_ title: String, @ViewBuilder content: @escaping () -> Content) {
            self.title = title
            self.content = content
        }
        
        var body: some View {
            VStack(alignment: .leading, spacing: 0) {
                
                HStack(alignment: .top) {
                    Text(title)
                        .foregroundColor(.black)
                        .semibold18
                        .multilineTextAlignment(.leading)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.\(isActive ? "up" : "down").circle")
                        .resizable()
                        .scaledToFill()
                        .font(.title.weight(.light))
                        .foregroundColor(.darkBlue)
                        .frame(width: 26, height: 26)
                }
                .makeButton {
                    withAnimation {
                        isActive.toggle()
                    }
                }
                
                if isActive {
                    content()
                        .padding(.top, 4)
                }
            }
            .padding(18)
            .padding(.bottom, 2)
            .roundedShadow()
            .padding(.horizontal, 20)
        }
    }
    
    struct ExpandableSimpleCell: View {
        
        @State var isActive = false
        @State var selectedIndex = 0
        @State var options: [String] = []
        
        let action: (Int)->Void
        
        init(options: [String], action: @escaping (Int)->Void) {
            self._options = State(wrappedValue: options)
            self.action = action
        }
        
        
        var body: some View {
            VStack(alignment: .leading) {
                HStack {
                    Text(options.isEmpty ? "Selected the way" : "\(options[selectedIndex])")
                        .foregroundColor(.black)
                        .medium16
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.\(isActive ? "up" : "down")")
                        .resizable()
                        .scaledToFit()
                        .font(.title.weight(.light))
                        .foregroundColor(.black)
                        .frame(width: 20, height: 20)
                    
                }
                .makeButton {
                    withAnimation {
                        isActive.toggle()
                    }
                }
                
                
                if isActive {
                    VStack(alignment: .leading) {
                        ForEach((0..<options.count), id: \.self) { index in
                            
                            Divider()
                            
                            HStack {
                                Text(options[index])
                                    .foregroundColor(.black)
                                    .regular16
                                    .multilineTextAlignment(.leading)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .padding(.leading,10)
                                
                                Spacer()
                            }
                            .makeButton {
                                selectedIndex = index
                                action(index)
                                withAnimation {
                                    isActive.toggle()
                                }
                            }
                        }
                    }
                }
                
            }
            .padding(EdgeInsets(top: 18, leading: 20, bottom: 15, trailing: 16))
            .roundedShadow()
            
        }
    }
}
