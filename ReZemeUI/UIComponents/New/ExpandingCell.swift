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
    var withLine: Bool
    var isOpened: Bool
    var views: [AnyView]
    
    init(
        text: String,
        image: UIImage? = nil,
        type: AccountType = .AGENT,
        withLine: Bool = true,
        isOpened: Bool = false,
        views: [any View] = []
    ) {
        self.text = text
        self.image = image
        self.type = type
        self.withLine = withLine
        self.isOpened = isOpened
        self.views = views.map({ AnyView($0) })
    }
    
    @State var isActive = false
    
    var body: some View {
        VStack(spacing: 0) {
            
            headerCell
                .makeButton {
                    withAnimation {
                        isActive.toggle()
                    }
                }
            
            if withLine {
                LineView()
                    .padding(.horizontal, 20)
                    .opacity(isActive ? 1 : 0)
                    .padding(.top, 7)
            }
            
            if isActive {
                VStack(spacing: 0) {
                    ForEach((0..<views.count), id: \.self) { index in
                        views[index]
                            .frame(minHeight: 40)
                        
                        if withLine && views.count-1 != index {
                            LineView()
                                .padding(.horizontal, 20)
                                .opacity(isActive ? 1 : 0)
                                .frame(height: 1)
                        }
                    }
                    .padding(.bottom, 13)
                }
                .padding(.top,15)
            }
            
        }
        .padding(EdgeInsets(top: 7, leading: 8, bottom: withLine ? 0:7, trailing: 20))
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.white)
                .glowEasy()
        )
        .onAppear{
            isActive = isOpened
        }
    }
}


//MARK: - UI Components

extension ExpandingCell {
    
    private var headerCell: some View {
        HStack(spacing: 17) {
            
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(type.color)
                    .padding(15)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(type.color.opacity(0.15))
                    )
                    .frame(width: 52, height: 52)
            }
            
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
        .frame(minHeight: 52)
    }
    
}

struct ExpandingCell_Previews: PreviewProvider {
    static var previews: some View {
        ExpandingCell(
            text: "Edit Profile",
            image: UIImage(named: "notification"),
            type: .AGENT,
            views: [ SomeExView() ,  SomeExView(),SomeExView() ,  SomeExView() ]
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
        .frame(height: 40)
        
    }
    
}
