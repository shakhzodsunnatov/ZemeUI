//
//  AgentChatTypesProtocol.swift
//  ReZemeUI
//
//  Created by Shakhzod on 19/04/23.
//

import Foundation

protocol AgentChatTypesProtocol: AgentChatOfferProtocol, AgentChatMeetingProtocol, AgentChatReminderProtocol {
    
}


//MARK: - Offer Chat

protocol AgentChatOfferProtocol {
    func deleteOffer(_ offer: OfferChatModel)
    func changeOffer(_ offer: OfferChatModel)
}


//MARK: - Meeting Chat

protocol AgentChatMeetingProtocol {
    func changeMeetingDate(_ date: Date)
    func deleteMeetingDate(_ date: Date)
}


//MARK: - Reminder Chat

protocol AgentChatReminderProtocol {
    func sendReminder()
}
