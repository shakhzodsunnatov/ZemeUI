//
//  HeaderWithImageTitleTip.swift
//  ReZemeUI
//
//  Created by Shakhzod on 27/04/23.
//

import SwiftUI


//MARK: - HeaderWithImageTitleTip

extension RenterFilterView {
    
    struct HeaderWithImageTitleTip<Content: View>: View {
        
        @State var showTip: Bool = false
        
        let image: String
        let title: String
        var tipStr: String? = nil
        let content: ()-> Content
        
        var body: some View {
            ZStack(alignment: .topTrailing) {
                
                VStack(alignment: .leading, spacing: 0) {
                    
                    HStack(spacing: 0) {
                        Image(image)
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.secondaryPurple)
                            .font(.title.weight(.light))
                            .frame(width: 20, height: 20)
                        
                        Text(title)
                            .regular14
                            .padding(.leading,8)
                        
                        Spacer()
                        
                        Image(systemName: "exclamationmark.circle")
                            .resizable()
                            .scaledToFill()
                            .foregroundColor(.secondaryPurple)
                            .font(.title.weight(.light))
                            .frame(width: 20, height: 20)
                            .makeButton {
                                withAnimation {
                                    showTip.toggle()
                                }
                            }
                            .opacity(tipStr == nil ? 0:1)
                    }
                    
                    
                    content()
                }
                
                if showTip {
                    
                    Text(tipStr ?? "")
                        .regular14
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(7)
                        .frame(width: 163)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .strokeBorder(Color.secondaryPurple)
                        )
                        .background(Color.white)
                        .padding(.top,30)
                }
            }
        }
    }
}
