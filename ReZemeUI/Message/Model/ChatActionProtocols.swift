//
//  ChatActionProtocols.swift
//  ReZemeUI
//
//  Created by Shakhzod on 18/04/23.
//

import Foundation

protocol ChatMeetingProtocol {
    func changeDateAction(_ date: Date)
    func acceptAction(_ date: Date)
    func denyAction(_ date: Date)
}
