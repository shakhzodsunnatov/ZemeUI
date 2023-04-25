//
//  RenterChatTypesProtocol.swift
//  ReZemeUI
//
//  Created by Shakhzod on 18/04/23.
//

import Foundation

protocol RenterChatTypesProtocol: RenterChatMeetingProtocol {
    
}


//MARK: - Offer Chat

protocol RenterChatOfferProtocol {
    
}


//MARK: - Meeting Chat

protocol RenterChatMeetingProtocol {
    func changeDateAction(_ date: Date)
    func acceptAction(_ date: Date)
    func denyAction(_ date: Date)
}
