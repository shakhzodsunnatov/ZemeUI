//
//  UserChat.swift
//  ReZeme
//
//  Created by Shakhzod on 25/03/23.
//

import SwiftUI

struct UserChat: View {
    
    //MARK: - PROPERTIES
    
    let userName: String
    let message: String
    let imageUrl: String? = nil
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 8) {
            
            chatText(
                name: userName,
                text: message
            )
            .frame(width: SCREEN_WIDTH-126)
            
            userImageOrName(imageUrl: imageUrl)
                .frame(width: 36, height: 36)
                .clipShape(Circle())
            
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
}


//MARK: - UI Components

extension UserChat {
    
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
                        .foregroundColor(.darkBlue)
                        .frame(width: 36, height: 36)
                        .background(
                            Circle()
                                .fill(Color.darkBlue.opacity(0.2))
                        )
                }
            }
        )
    }
    
    private func chatText(name: String, text: String) -> some View {
        HStack {
            Spacer()
            
            VStack(alignment: .leading, spacing: 2) {
                
                Text(name)
                    .medium16
                    .foregroundColor(Color(hexString: "#98C4FF"))
                
                
                Text(text)
                    .regular16
                    .fixedSize(horizontal: false, vertical: true)
                    .foregroundColor(.white)
            }
            .padding(.vertical,9)
            .padding(.leading, 17)
            .padding(.trailing,11)
            .background(Color(hexString: "#006AF9"))
            .cornerRadius(radius: 8,
                          corners: [.topLeft,.topRight, .bottomLeft]
            )
            .glowHard()
        }
    }
}


struct UserChat_Previews: PreviewProvider {
    static var previews: some View {
        UserChat(userName: "Agent", message: "some Message")
            .padding(.trailing, 20)
    }
}
