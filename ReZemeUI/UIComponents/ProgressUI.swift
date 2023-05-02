//
//  ProgressUI.swift
//  ReZemeUI
//
//  Created by Shakhzod on 02/05/23.
//

import SwiftUI

struct ProgressUI: View {
    
    let titles: [String]
    @Binding var step: Int
    
    var body: some View {
        GeometryReader { geo in
            HStack(spacing: 15) {
                
                ForEach((0..<titles.count), id: \.self) { index in

                    VStack(spacing: 6) {
                        
                        Image(systemName: index < step ? "checkmark.circle" : "\(index+1).circle")
                            .resizable()
                            .scaledToFit()
                            .font(.title.weight(.light))
                            .foregroundColor(.secondaryPurple)
                            .frame(width: 18, height: 18)
                            .background(
                                Circle()
                                    .fill(Color.white)
                            )
                            
                        Text(titles[index])
                            .foregroundColor(index < step ? .secondaryPurple : .black)
                            .semibold11
                    }
                    .frame(maxWidth: .infinity)
                    
                }
            }
            .background(
                ZStack {
                    Rectangle()
                        .fill(Color.secondaryPurple.opacity(3))
                        .frame(height: 4)
                        .frame(width: geo.frame(in: .local).width/CGFloat(titles.count)*CGFloat(step))
                }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.secondaryPurple.opacity(0.3))
                    .padding(
                        .horizontal,
                        geo.frame(in: .local).width/CGFloat(titles.count)/2
                    )
                    .offset(y: -10)
                    
            )
        }
        .padding(.vertical, 6)
        .frame(height: 50)
        .padding(.vertical, 10)
        .roundedShadow(backgroundColor: .secondaryPurple.opacity(0.06))
    }
}

struct ProgressUI_Previews: PreviewProvider {
    static var previews: some View {
        ProgressUI(titles: [
            "Processing",
            "In Progress",
            "In Review",
            "Resolved"
        ], step: .constant(2))
    }
}
