//
//  SelectDocumentTypeView.swift
//  ReZemeUI
//
//  Created by Shakhzod on 17/04/23.
//

import SwiftUI

struct SelectDocumentTypeView: View {
    
    private let imageName = ["bank_ic",
                             "document_ic",
                             "people_ic",
                             "money-send"]
    private let docNames = [
        "Plaid Verified Bank \nStatements",
        "W2 Forms",
        "Employment Verification",
        "Paystubs"
    ]
    
    var closeAction = {}
    var selectedIndex: (Int)->Void = {_ in}
    
    var body: some View {
        VStack(spacing: 0) {
            
            HStack {
                Text("What type of document are you uploading?")
                    .medium16
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.trailing, 25)
                
                Spacer()
                
                Button(action: closeAction) {
                    Image(systemName: "xmark.circle")
                        .resizable()
                        .scaledToFill()
                        .font(.title.weight(.light))
                        .frame(width: 30, height: 30)
                }
            }
            .padding(EdgeInsets(top: 22, leading: 22, bottom: 0, trailing: 18))
            
            VStack(spacing: 35) {
                ForEach((0..<docNames.count), id: \.self) { index in
                    documentTypeItem(
                        image: imageName[index],
                        name: docNames[index],
                        action: { selectedIndex(index) }
                    )
                }
            }
            .padding(.top,40)
            .padding(.horizontal, 20)
            .padding(.bottom, 38)
            
        }
        .frame(width: SCREEN_WIDTH)
        .background(Color.white)
        .cornerRadius(radius: 8, corners: [.topLeft, .topRight])
        .glowHard()
        
    }
}

//MARK: - UIComponents

extension SelectDocumentTypeView {
    
    private func documentTypeItem(image: String, name: String, action: @escaping ()-> Void) -> some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .padding(12)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.darkBlue.opacity(0.15))
                    )
                
                Text(name)
                    .medium16
                    .foregroundColor(.black)
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.leading)
                
                Spacer()
                
                Image(systemName: "chevron.forward.circle")
                    .resizable()
                    .font(.title.weight(.light))
                    .frame(width: 26, height: 26)
            }
        }
    }
}



struct SelectDocumentTypeView_Previews: PreviewProvider {
    static var previews: some View {
        SelectDocumentTypeView()
    }
}
