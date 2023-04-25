//
//  ItemShortInfoView.swift
//  ReZeme
//
//  Created by Yunus on 19/02/23.
//

import SwiftUI

struct ItemShortInfoView: View {
    var bedCount: String
    var bathCount: String
    var areaSqft: String
    
    var body: some View {
        HStack {
            itemView(imageName: "big-beds", text: "\(bedCount) bds")
            itemView(imageName: "big_baths", text: "\(bathCount) ba")
            itemView(imageName: "map_ic", text: "\(areaSqft) sqft")
        }
    }
    
    func itemView(imageName: String, text: String) -> some View {
       return HStack {
            Image(imageName)
               .renderingMode(.template)
               .resizable()
               .scaledToFit()
               .foregroundColor(.secondaryPurple)
               .frame(width: 24, height: 24)
            
            Text(text)
                .regular12
                .foregroundColor(.textGray)
        }
       .padding(.trailing)
    }
}

struct ItemShortInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ItemShortInfoView(bedCount: "2", bathCount: "1", areaSqft: "600")
    }
}
