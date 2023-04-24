//
//  AlarmChat.swift
//  ReZeme
//
//  Created by Shakhzod on 26/03/23.
//

import SwiftUI

struct AlarmChat: View {
    
    let date: Date
    let closeBtnAction: ()-> Void
    
    var body: some View {
        VStack(spacing: 18) {
            
            HStack(spacing:7) {
                
                Image("notification")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20)
                
                Text("Virtual meeting is coming up on \(dateFormatter.string(from: date)).")
                    .medium14
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            LineView()
            
            Button(action: closeBtnAction) {
                Text("Close")
                    .foregroundColor(.white)
                    .semibold14
                    .frame(height: 36)
                    .padding(.horizontal, 24)
                    .background(
                        Capsule()
                            .fill(Color.blueGradient.toLinearGradient)
                    )
            }
        }
        .padding(.vertical, 15)
        .padding(.horizontal, 13)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.darkBlue, lineWidth: 1)
        )
    }
}

struct AlarmChat_Previews: PreviewProvider {
    static var previews: some View {
        AlarmChat(date: Date(), closeBtnAction: {})
    }
}
