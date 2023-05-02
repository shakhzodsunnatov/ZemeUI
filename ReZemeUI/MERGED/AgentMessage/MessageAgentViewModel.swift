//
//  MessageAgentViewModel.swift
//  ReZemeUI
//
//  Created by Shakhzod on 19/04/23.
//

import Foundation
import SwiftUI

class MessageAgentViewModel: ObservableObject {
    
    //MARK: - PROPERTIES
    
    @Published var messages: [MessageType] = []
    
    
    //MARK: - init
    init() {
        messages = getMessages()
    }
    
    
    //MARK: - Methods
    
    func sendText(_ text: String) {
        let textChat = MessageType.text(text, true) // bool is from client
        addMessage(textChat)
    }
    
    func addMessage(_ message: MessageType) {
        messages.append(message)
    }
    
    func getMessages() -> [MessageType] {
        if messages.isEmpty {
            return MessageType.allCases // just place holder
        } else {
            return messages
        }
    }

}
