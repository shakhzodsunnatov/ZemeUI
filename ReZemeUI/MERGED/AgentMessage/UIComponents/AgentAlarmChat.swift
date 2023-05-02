//
//  AgentAlarmChat.swift
//  ReZemeUI
//
//  Created by Shakhzod on 19/04/23.
//

import SwiftUI

struct AgentAlarmChat: View {
    
    let sendReminder: ()-> Void
    
    var body: some View {
        VStack(spacing: 18) {
            
            HStack(spacing:7) {
                
                Image("notification")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20)
                
                Text("Applicant hasn’t applied yet")
                    .medium14
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            //TODO: - Custom divider here
            
            Button(action: sendReminder) {
                Text("Send Reminder")
                    .foregroundColor(.white)
                    .semibold14
                    .frame(height: 36)
                    .padding(.horizontal, 24)
                    .background(
                        Capsule()
                            .fill(Color.blueGradient.toLinearGradient)
                    )
            }
        }
        .padding(.vertical, 15)
        .padding(.horizontal, 13)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.secondaryPurple, lineWidth: 1)
        )
    }
}

struct AgentAlarmChat_Previews: PreviewProvider {
    static var previews: some View {
        AgentAlarmChat(sendReminder: {})
    }
}
