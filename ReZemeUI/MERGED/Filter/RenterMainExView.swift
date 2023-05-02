//
//  RenterMainExView.swift
//  ReZemeUI
//
//  Created by Shakhzod on 27/04/23.
//

import SwiftUI

struct RenterMainExView: View {
    
    //MARK: - PROPERTIES
    @StateObject var filterViewModel = FilterViewModel()
    
    @State var filterShow = true
    
    var body: some View {
        CustomNavBar(
            content: {
                
                VStack {
                    Text("Some Main View")
                        .semibold22
                    
                }
                
                .renterFilterView(
                    isPresent: $filterShow,
                    viewModel: _filterViewModel)
                
            },
            title: "",
            style: .filteredinput,
            type: .buyer) {
                withAnimation(.easeInOut) {
                    filterShow.toggle()
                }
            }
            .navigationBarHidden(true)
    }
}


struct RenterMainExView_Previews: PreviewProvider {
    static var previews: some View {
        RenterMainExView()
    }
}

