//
//  DocumentItemCell.swift
//  ReZemeUI
//
//  Created by Shakhzod on 29/04/23.
//

import SwiftUI

struct DocumentItemCell: View {
    
    let image: String
    let title: String
    let subTitle: String
    let action: EmptyClosure
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            
            Image(image)
                .resizable()
                .scaledToFill()
                .padding(12)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.darkBlue.opacity(0.15))
                )
                .frame(width: 44, height: 44)
            
            VStack(alignment: .leading, spacing: 3) {
                
                Text(title)
                    .medium16
                
                Text(subTitle)
                    .regular14
            }
            .foregroundColor(.black)
            .multilineTextAlignment(.leading)
            .fixedSize(horizontal: false, vertical: true)
            
            Spacer()
            
            Image(systemName: "chevron.right.circle")
                .resizable()
                .scaledToFill()
                .foregroundColor(.darkBlue)
                .frame(width: 26, height: 26)
        }
        .padding(EdgeInsets(top: 13, leading: 10, bottom: 12, trailing: 24))
        .roundedShadow()
        .makeButton(action: action)
    }
}

struct DocumentItemCell_Previews: PreviewProvider {
    static var previews: some View {
        DocumentItemCell(
            image: "document_ic",
            title: "Lease Agreement",
            subTitle: "Uploaded Jan. 7"
        ) { }
            .padding(20)
    }
}
