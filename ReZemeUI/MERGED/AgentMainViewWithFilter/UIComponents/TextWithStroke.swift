//
//  TextWithStroke.swift
//  ReZeme
//
//  Created by Yunus on 19/02/23.
//

import SwiftUI

struct TextWithStroke: View {
    var text: String
    
    var body: some View {
        VStack {
            Text(text)
                .medium12
                .foregroundColor(.white)
                .padding(.all, 4)
                .padding(.horizontal,5)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.white)
                        .background(Color.black.opacity(0.3))
                        )
                .cornerRadius(8)
        }
    }
}

struct TextWithStroke_Previews: PreviewProvider {
    static var previews: some View {
        TextWithStroke(text: "Easy Apply")
    }
}
