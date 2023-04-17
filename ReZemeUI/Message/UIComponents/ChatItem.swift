//
//  TextChat.swift
//  ReZeme
//
//  Created by Shakhzod on 23/03/23.
//

import SwiftUI

struct ChatItem: View {
    
    //MARK: - PROPERTIES
    let messageType: MessageType
    
    
    var body: some View {
        
        switch messageType {
            
        case .text(let text, let isUser):
            
            if isUser {
                UserChat(userName: "Renter", message: text)
            } else {
                ClientChat(userName: "Agent", message: text)
            }
            
        case .offer(let offer):
            
            OfferChat(model: offer)
            
        case .meeting(let date):
            
            MeetingChat(date: date)
            
        case .reminder(let date):
            
            AlarmChat(date: date) { }
        }
    }
}



struct ChatItem_Previews: PreviewProvider {
    static var previews: some View {
        ChatItem(messageType: .text("Some message", false))
    }
}
