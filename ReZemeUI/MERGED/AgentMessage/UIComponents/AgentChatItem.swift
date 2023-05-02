//
//  AgentChatItem.swift
//  ReZemeUI
//
//  Created by Shakhzod on 19/04/23.
//

import SwiftUI

struct AgentChatItem: View {
    
    //MARK: - PROPERTIES
    let messageType: MessageType
    
    let chatDelegates: AgentChatTypesProtocol?
    
    var body: some View {
        
        switch messageType {
            
        case .text(let text, let isUser):
            
            if isUser {
                UserChat(userName: "Renter", message: text)
            } else {
                ClientChat(userName: "Agent", message: text)
            }
            
        case .offer(let offer):
            
            AgentOfferChat(
                model: offer,
                deleteAction: {
                    chatDelegates?.deleteOffer(offer)
                },
                changeAction: {
                    chatDelegates?.changeOffer(offer)
                }
            )
            
        case .meeting(let date):
            
            AgentMeetingChat(
                date: date,
                changeDateAction: {
                    chatDelegates?.changeMeetingDate($0)
                },
                deleteDateAction: {
                    chatDelegates?.deleteMeetingDate($0)
                }
            )
            
        case .reminder(let date):
            
            AgentAlarmChat {
                chatDelegates?.sendReminder()
            }
        }
    }
}

struct AgentChatItem_Previews: PreviewProvider {
    static var previews: some View {
        AgentChatItem(
            messageType: .reminder(Date()),
            chatDelegates: nil
        )
    }
}
