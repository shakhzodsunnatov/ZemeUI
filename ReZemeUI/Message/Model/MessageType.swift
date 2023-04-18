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

//MARK: -

extension MessageType: Equatable {
    static func == (lhs: MessageType, rhs: MessageType) -> Bool {
        switch (lhs, rhs) {
        case let (.text(leftText, leftFlag), .text(rightText, rightFlag)):
            return leftText == rightText && leftFlag == rightFlag
        case let (.offer(leftOffer), .offer(rightOffer)):
            return leftOffer == rightOffer
        case let (.meeting(leftDate), .meeting(rightDate)):
            return leftDate == rightDate
        case let (.reminder(leftDate), .reminder(rightDate)):
            return leftDate == rightDate
        default:
            return false
        }
    }
}


