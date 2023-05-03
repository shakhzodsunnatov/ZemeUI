//
//  MyServiceRequestView.swift
//  ReZemeUI
//
//  Created by Shakhzod on 02/05/23.
//

import SwiftUI

struct MyServiceRequestView: View {
    
    @State var searchText = ""
    private let titles: [String] = [
        "Processing",
        "In Progress",
        "In Review",
        "Resolved"
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            
            searchTextField($searchText)
                .padding(.top, 9)
                .padding(.horizontal,20)
            
            ActionButton("Create Service Request")
                .padding(.top, 15)
                .padding(.horizontal, 20)
            
            ToggleUI(titles: ["Open", "Completed"]) { index in}
                .padding(.top, 15)
                .padding(.horizontal, 20)
            
            ScrollView(showsIndicators: false) {
                
                VStack(spacing: 20) {
                    
                    ForEach((0..<3), id: \.self) { _ in
                        requestItem()
                            .padding(.horizontal, 20)
                    }
                    
                }
                .padding(.top, 10)
                .padding(.bottom, 80)
                
            }
            .padding(.top,10)
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
    
    private func requestItem() -> some View {
        VStack(spacing: 0) {
            
            HStack {
                Text("Sink clogged")
                    .semibold16
                
                Spacer()
                
                HStack(spacing: 6) {
                    Image(systemName: "exclamationmark.triangle")
                        .foregroundColor(.red)
                    
                    Text("Hight Priority")
                        .regular14
                        .fixedSize()
                }
                
            }
            
            ProgressUI(titles: titles, step: Binding<Int>.constant(2))
                .padding(.top, 22)
            
        }
        .padding(EdgeInsets(top: 8, leading: 9, bottom: 10, trailing: 9))
        .roundedShadowNew()
    }
    
}


struct MyServiceRequestView_Previews: PreviewProvider {
    static var previews: some View {
        MyServiceRequestView()
    }
}
