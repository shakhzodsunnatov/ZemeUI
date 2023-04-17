//
//  OfferChat.swift
//  ReZeme
//
//  Created by Shakhzod on 25/03/23.
//

import SwiftUI

struct MeetingChat: View {
    
    //MARK: - PROPERTIES
    
    let date: Date
    
    var body: some View {
        VStack(spacing: 20) {

            headerTime
            
            //TODO: - Custom Divider
            
            HStack(spacing: 0) {
                
                changeDateButton { /* TODO: change btn action here */ }
                
                Spacer(minLength: 0)
                
                acceptButton { /* TODO: accept btn action here */ }
                
                Spacer(minLength: 0)
                
                denyButton { /* TODO: deny btn action here */ }
            }
        }
        .padding(.vertical, 15)
        .padding(.horizontal, 13)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.darkBlue, lineWidth: 1)
        )
    }
    
}


//MARK: - UI Components
extension MeetingChat {
    
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

            Text(date, style: .date)
                .medium16

        }
    }
    
    private func changeDateButton(action: @escaping ()-> Void) -> some View {
        Button(action: action) {
            Text("Change Date")
                .foregroundColor(.darkBlue)
                .semibold14
                .padding(.horizontal, 15)
                .frame(height: 36)
                .frame(width: (SCREEN_WIDTH-92)/2.5)
                .background(
                    Capsule()
                        .fill(Color.lightBlue.opacity(0.2))
                )
        }
    }
    
    private func acceptButton(action: @escaping ()-> Void) -> some View {
        Button(action: action) {
            
        Text("Accept")
            .foregroundColor(.white)
            .semibold14
            .padding(.horizontal, 15)
            .frame(height: 36)
            .frame(width: (SCREEN_WIDTH-92)/3.2)
            .background(
                Capsule()
                    .fill(Color.blueGradient.toLinearGradient)
            )
        }
    }
    
    private func denyButton(action: @escaping ()-> Void) -> some View {
        Button(action: action) {
            Text("Deny")
                .foregroundColor(.darkBlue)
                .semibold14
                .padding(.horizontal, 15)
                .frame(height: 36)
                .frame(width: (SCREEN_WIDTH-92)/3.2)
                .background(
                    Capsule()
                        .stroke(Color.darkBlue, lineWidth: 1)
                )
        }
    }
}

struct MeetingChat_Previews: PreviewProvider {
    static var previews: some View {
        MeetingChat(date: Date())
            .frame(height: 50)
    }
}
