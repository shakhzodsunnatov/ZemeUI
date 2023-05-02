//
//  SavedListingsView.swift
//  ReZemeUI
//
//  Created by Shakhzod on 29/04/23.
//

import SwiftUI

struct SavedListingsView: View {
    
    @State var properties = Array(repeating: mockProperty, count: 10)
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 20) {
                
                ForEach((0..<properties.count), id: \.self) { index in
                    SavedItemView(property: properties[index])
                        .padding(.horizontal, 20)
                }
                
            }
            .padding(.top,22)
            .padding(.bottom,50)
        }
        .navigationRenter(
            title: "Saved Listings",
            withBeckBtn: true, // In the real project need to be false
            rightButton: settingNavButton { }
        )
    }
}


//MARK: - UI

extension SavedListingsView {
    
    private func settingNavButton(action: @escaping EmptyClosure) -> AnyView {
        AnyView(
            ZStack {
                Image("filter")
                    .resizable()
                    .scaledToFill()
                    .padding(15)
                    .frame(width: 50, height: 50)
                    .roundedShadow(cornerRadius: 16)
                
                
            }.makeButton(action: action)
        )
    }
}

struct SavedListingsView_Previews: PreviewProvider {
    static var previews: some View {
        SavedListingsView()
    }
}
