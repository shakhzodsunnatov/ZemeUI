//
//  RenterMainExView.swift
//  ReZemeUI
//
//  Created by Shakhzod on 27/04/23.
//

import SwiftUI

struct RenterMainExView: View {
    
    //MARK: - PROPERTIES
    @State var showFilter = true
    
    var body: some View {
        CustomNavBar(
            content: {
                ZStack {
                    
                    Text("Some Main View")
                        .semibold22
                    
                    VStack(spacing: 0) {
                        
                        
                        
                    }
                    .roundedShadowNew()
                    
                }
            },
            title: "",
            style: .filteredinput,
            type: .buyer) {
                withAnimation(.easeInOut) {
                    showFilter.toggle()
                }
            }
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarHidden(true)
    }
}


struct RenterMainExView_Previews: PreviewProvider {
    static var previews: some View {
        RenterMainExView()
    }
}
