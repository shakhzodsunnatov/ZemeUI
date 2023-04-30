//
//  DropDownMenu.swift
//  ReZemeUI
//
//  Created by Shakhzod on 30/04/23.
//

import SwiftUI

struct DropDownMenu<Content: View>: View {
    
    //MARK: - PROPERTIES

    @State private var selectedTitle: String
    private let titles: [String]
    private let selectedIndex: (Int)->Void
    
    private let content: ()->Content
    
    @State private var isActive = false
    
    init(
        selectedTitle: String? = nil,
        titles: [String],
        selectedIndex: @escaping (Int)->Void,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self._selectedTitle = State(wrappedValue: (selectedTitle != nil ? selectedTitle! : titles.first ?? "Place Holder"))
        self.titles = titles
        self.selectedIndex = selectedIndex
        self.content = content
    }
    
    
    //MARK: - body
    
    var body: some View {
        ZStack(alignment: .top) {
            
            content()
                .padding(.top,60)
            
            VStack(spacing: 0) {
                
                HStack {
                    
                    Text(selectedTitle)
                        .medium16
                    
                    Spacer()
                    
                    Image(systemName: "chevron.down")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .rotated(Angle(degrees: isActive ? 180:0))
                }
                .foregroundColor(.black)
                .makeButton {
                    withAnimation {
                        isActive.toggle()
                    }
                }
                
                
                if isActive {
                    VStack(spacing: 0) {

                        LineView()
                            .padding(.top, 15)


                        ForEach((0..<titles.count), id: \.self) { index in
                            menuItem(title: titles[index])
                                .makeButton {
                                    selectedTitle = titles[index]
                                    selectedIndex(index)
                                    withAnimation {
                                        isActive.toggle()
                                    }
                                }

                            Divider()
                                .opacity(index == titles.count-1 ? 0:1)
                        }
                    }
                }
                
            }
            .padding(19)
            .roundedShadowNew()
            
        }
    }
}


//MARK: - UI

extension DropDownMenu {
    
    private func menuItem(title: String) -> some View {
        HStack {
            Text(title)
                .medium14
                .foregroundColor(.black)
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.leading)
            
            Spacer()
        }
        .frame(height: 40)
        .padding(.horizontal,10)
    }
    
}

struct DropDownMenu_Previews: PreviewProvider {
    static var previews: some View {
        DropDownMenu(titles: ["a", "b", "C"], selectedIndex: {_ in} ,content: {
            Text("Service request is not urgent and can be addressed within the next 1-2 weeks")
                .regular11
                .padding(.top, 11)
        })
    }
}
