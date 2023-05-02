//
//  SavedButton.swift
//  ReZeme
//
//  Created by Yunus on 19/02/23.
//

import SwiftUI

struct SavedButton: View {
  
    @State var isLiked: Bool = false
    var likeBtnAction: (Bool) -> ()
    
    var body: some View {
        VStack {
            Button {
                isLiked.toggle()
                likeBtnAction(isLiked)
                
            } label: {
                Image(isLiked ? "heart_filled" : "heart")
                    .resizable()
                    .frame(width: 18, height: 18)
            }
        }
        .padding(.all, 6)
        .background(Color.black.opacity(0.3))
        .cornerRadius(5)
    }
}

struct SavedButton_Previews: PreviewProvider {
    static var previews: some View {
        SavedButton() { isLiked in }
    }
}
