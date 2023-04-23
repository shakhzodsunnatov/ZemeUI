//
//  ExpandingCell.swift
//  ReZemeUI
//
//  Created by Shakhzod on 23/04/23.
//

import SwiftUI

struct ExpandingCell: View {
    
    var text: String
    var image: UIImage?
    var type: AccountType
    var views: [AnyView]
    
    init(text: String, image: UIImage? = nil, type: AccountType, views: [any View] = []) {
        self.text = text
        self.image = image
        self.type = type
        self.views = views.map({ AnyView($0) })
    }
    
    @State var isActive = false
    
    var body: some View {
        VStack {
            
            headerCell
                .makeButton {
                    withAnimation {
                        isActive.toggle()
                    }
                }
            
            
            if isActive {
                VStack {
                    ForEach((0..<views.count), id: \.self) { index in
                        views[index]
                            .frame(minHeight: 40)
                    }
                }
                .animation(.easeIn)
                .padding(.top,15)
            }
            
        }
        .padding(EdgeInsets(top: 7, leading: 8, bottom: 7, trailing: 20))
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.white)
                .glowEasy()
        )
    }
}


//MARK: - UI Components

extension ExpandingCell {
    
    private var headerCell: some View {
        HStack(spacing: 17) {
            
            Image(uiImage: image ?? UIImage(systemName: "xmark")!)
                .resizable()
                .scaledToFit()
                .foregroundColor(type.color)
                .padding(15)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(type.color.opacity(0.15))
                )
                .frame(width: 52, height: 52)
            
            Text(text)
                .medium16
                .foregroundColor(.black)
                
            Spacer()
            
            Image(systemName: "chevron.right.circle")
                .resizable()
                .scaledToFit()
                .foregroundColor(.darkBlue)
                .frame(width: 26, height: 26)
                .rotationEffect(.degrees(isActive ? 90:0))
        }
    }
    
}

struct ExpandingCell_Previews: PreviewProvider {
    static var previews: some View {
        ExpandingCell(
            text: "Edit Profile",
            image: UIImage(named: "notification"),
            type: .AGENT,
            views: [ SomeExView() ]
        )
            .padding(.horizontal, 20)
    }
}



struct SomeExView: View {
    
    var body: some View {
        
        HStack {
            Text("Email notification")
            
            Spacer()
            
            Capsule()
                .fill(Color.darkBlue)
                .frame(width: 40, height: 24)
        }
        .frame(height: 60)
        .background(Color.red)
        
    }
    
}
