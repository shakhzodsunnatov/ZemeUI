//
//  AgentMeetingChat.swift
//  ReZemeUI
//
//  Created by Shakhzod on 19/04/23.
//

import SwiftUI

struct AgentMeetingChat: View {
    
    //MARK: - PROPERTIES
    
    let date: Date
    let changeDateAction: (Date)-> Void
    let deleteDateAction: (Date)-> Void
    
    var body: some View {
        VStack(spacing: 20) {

            headerTime
            
            //TODO: - Custom Divider
            
            deleteChangeButtons(
                delete: { deleteDateAction(date) },
                change: { changeDateAction(date) }
            )
        }
        .padding(.vertical, 15)
        .padding(.horizontal, 13)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.secondaryPurple, lineWidth: 1)
        )
    }
}


//MARK: - UI Components
extension AgentMeetingChat {
    
    private var headerTime: some View {
        HStack(spacing: 7) {

            Image("calendar")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)

            Text("Meeting Date")
                .foregroundColor(Color.textGray)
                .medium16

            Spacer()

            Text(dateFormatter.string(from: date))
                .medium16

        }
    }
    
    private func deleteChangeButtons(
        delete: @escaping ()->Void,
        change: @escaping ()->Void
    ) -> some View {
        HStack(spacing: 14) {
            
            Spacer()
            
            Button(action: delete) {
                Text("Delete")
                    .semibold14
                    .foregroundColor(.secondaryPurple)
                    .frame(width: 87, height: 36)
                    .background(
                        Capsule()
                            .stroke(Color.secondaryPurple, lineWidth: 1)
                    )
            }
            
            Button(action: change) {
                Text("Change")
                    .foregroundColor(Color.white)
                    .semibold14
                    .frame(width: 87, height: 36)
                    .background(
                        Capsule()
                            .fill(Color.blueGradient.toLinearGradient)
                    )
            }
            
        }
    }
}


struct AgentMeetingChat_Previews: PreviewProvider {
    static var previews: some View {
        AgentMeetingChat(
            date: Date(),
            changeDateAction: {_ in},
            deleteDateAction: {_ in}
        )
    }
}

