//
//  MyServiceRequestView.swift
//  ReZemeUI
//
//  Created by Shakhzod on 02/05/23.
//

import SwiftUI

struct MyServiceRequestView: View {
    
    @State var searchText = ""
    
    var body: some View {
        VStack(spacing: 0) {
            
            searchTextField($searchText)
                .padding(.top, 9)
                .padding(.horizontal,20)
            
            ActionButton("Create Service Request")
                .padding(.top, 15)
                .padding(.horizontal, 20)
            
        }
        .navigationRenter(title: "My Service Requests")
    }
}


//MARK: - UI

extension MyServiceRequestView {
    
    private func searchTextField(_ text: Binding<String>) -> some View {
        HStack(spacing: 6) {
            
            Image("search_")
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .foregroundColor(.secondaryPurple)
                .frame(width: 16, height: 16)
            
            TextField("Search", text: text)
                .autocorrectionDisabled()
                .regular14
        }
        .padding(17)
        .frame(maxWidth: .infinity)
        .frame(height: 50)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .strokeBorder(Color.textGray.opacity(0.3), lineWidth: 1)
        )
    }
    
}


struct MyServiceRequestView_Previews: PreviewProvider {
    static var previews: some View {
        MyServiceRequestView()
    }
}
