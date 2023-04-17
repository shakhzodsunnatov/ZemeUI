//
//  MessageType.swift
//  ReZeme
//
//  Created by Shakhzod on 23/03/23.
//

import SwiftUI


enum MessageType: CaseIterable {
    
    static var allCases: [MessageType] {
        return [
            .text("Some Message", true),
            .text("Some Message", false),
            .offer(offerModelMock),
            .meeting(Date()),
            .reminder(Date())
        ]
    }
    
    case text(String,Bool)
    case offer(OfferChatModel)
    case meeting(Date)
    case reminder(Date)
}



