//
//  ClientChat.swift
//  ReZeme
//
//  Created by Shakhzod on 25/03/23.
//

import SwiftUI

struct ClientChat: View {
    
    //MARK: - PROPERTIES
    
    let userName: String
    let message: String
    let imageUrl: String? = nil
    
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 5) {
            
            userImageOrName(imageUrl: imageUrl)
                .frame(width: 36, height: 36)
                .clipShape(Circle())
            
            chatText(
                name: userName,
                text: message
            )
            .frame(width: SCREEN_WIDTH-126)
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}


//MARK: - UI Components

extension ClientChat {
    
    private func userImageOrName(imageUrl: String?) -> some View {
        return AnyView(
            ZStack {
                if let imageUrl {
                    AsyncImage(
                        url: imageUrl,
                        placeHolderState: .circle,
                        placeHolderFor: .RENTER
                    )
                } else {
                    Text(userName.prefix(1))
                        .medium16
                        .foregroundColor(.secondaryPurple)
                        .frame(width: 36, height: 36)
                        .background(
                            Circle()
                                .fill(Color.secondaryPurple.opacity(0.2))
                        )
                }
            }
        )
    }
    
    private func chatText(name: String, text: String) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                
                Text(name)
                    .medium16
                    .foregroundColor(.primaryBlue)
                
                Text(text)
                    .regular16
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(.vertical,9)
            .padding(.leading, 17)
            .padding(.trailing,11)
            .background(Color.white)
            .cornerRadius(radius: 8,
                          corners: [.topLeft,.topRight, .bottomRight]
            )
            .glow()
            
            Spacer()
        }
    }
}
struct ClientChat_Previews: PreviewProvider {
    static var previews: some View {
        ClientChat(userName: "Agent", message: "Some Meessage here")
            .padding(.leading, 20)
    }
}
