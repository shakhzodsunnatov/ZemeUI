//
//  ChatCard.swift
//  ReZeme
//
//  Created by Shakhzod on 14/03/23.
//

import SwiftUI

struct ChatCard: View {
    
    //MARK: - PROPERTIES
    
    let completedUntilNumber: Int
    let model: Property
    let chatBtnAction: ()->Void
    
    //MARK: - body
    
    var body: some View {
        VStack(spacing: 20) {
            
            HStack(spacing: 7) {
                
                propertyImageView
                    .frame(width: 85, height: 63)
                
                
                VStack(alignment: .leading, spacing: 2) {
                    
                    HStack(alignment: .top) {
                        
                        Text("Chat with Robert and David")
                            .medium16
                            .lineLimit(2)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        Spacer()
                        
                        chatButton(action: chatBtnAction)
                        
                    }
                    
                    streetName(title: model.generalInformation?.address ?? "***")
                    
                }
                
                
                
            }
            .frame(height: 63)
            
            ChatProgress(completedIndex: .constant(completedUntilNumber))
                .padding(.bottom,10)
        }
        .padding(10)
        //        .frame(width: SCREEN_WIDTH-40)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}


//MARK: - UI Components

extension ChatCard {
    
    private var propertyImageView: some View {
        Image("mockHomeImage")
            .resizable()
            .scaledToFill()
            .cornerRadius(radius: 8, corners: .allCorners)
    }
    
    private func chatButton(action: @escaping ()-> Void) -> some View {
        Button(action: action) {
            Image("messages_ic")
                .resizable()
                .scaledToFill()
                .padding(10)
                .frame(width: 40, height: 40)
                .background(
                    Circle()
                        .fill(Color.secondaryPurple)
                )
        }
    }
    
    private func streetName(title: String) -> some View {
        HStack(spacing: 8) {
            
            Image("location_ic")
                .resizable()
                .scaledToFill()
                .frame(width: 16, height: 16)
            
            Text(title)
                .regular12
        }
    }
    
}

struct ChatCard_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.background
            
            ChatCard(completedUntilNumber: 3, model: mockProperty) { /* Chat Icon Tapped action */ }
        }
    }
}
