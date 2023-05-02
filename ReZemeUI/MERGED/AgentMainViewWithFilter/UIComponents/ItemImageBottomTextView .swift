//
//  ItemImageBottomTextView.swift
//  ReZeme
//
//  Created by Yunus on 19/02/23.
//

import SwiftUI

struct ItemImageBottomTextView: View {
    
    var firstText: String
    var secondText: String
    
    var body: some View {
        HStack {
            Text(firstText)
                .semibold16
                .foregroundColor(.white)
                .padding(.leading, 8)
            
            Spacer()
            
            Text(secondText)
                .semibold16
                .foregroundColor(.white)
                .padding(.trailing, 8)
        }
        .padding([.top, .bottom], 4)
        .background(Color.black.opacity(0.4))
        .cornerRadius(radius: 8, corners: [.bottomLeft, .bottomRight])
        
    }
}

struct ItemImageBottomTextView_Previews: PreviewProvider {
    static var previews: some View {
        ItemImageBottomTextView(firstText: "BLVD", secondText: "$1,377/mo")
    }
}
