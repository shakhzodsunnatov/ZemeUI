//
//  ChatTextFiledStyle.swift
//  ReZeme
//
//  Created by Shakhzod on 26/03/23.
//

import SwiftUI

struct ChatTextFiledStyle: TextFieldStyle {
    
    let sendBtnAction: ()-> Void
    let fileBtnAction: ()-> Void
    
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        HStack(spacing: 20) {
            
            fileButton(action: fileBtnAction)
            
            configuration
                .regular18
            
            sendButton(action: sendBtnAction)
        }
            .padding(
                EdgeInsets(
                    top: 10,
                    leading: 19,
                    bottom: 10,
                    trailing: 11
                )
            )
            .background (
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.white)
                    .glow()
            )
    }
}


//MARK: - Helper UIs

extension ChatTextFiledStyle {
    
    private func fileButton(action: @escaping ()-> Void) -> some View {
        Button(action: action) {
            Image("file")
                .resizable()
                .scaledToFill()
                .frame(width: 25, height: 25)
        }
    }
    
    private func sendButton(action: @escaping ()-> Void) -> some View {
        Button(action: action) {
            Image("sendChat")
                .resizable()
                .scaledToFill()
                .foregroundColor(.white)
                .padding(5)
                .padding([.top,.trailing], 2.5)
                .frame(width: 38, height: 38)
                .background(
                    Circle()
                        .fill(Color.blueGradient.toLinearGradient)
                )
        }
    }
    
}

struct ChatTextFiledStyle_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            TextField("Type a message...", text: .constant(""))
                .textFieldStyle(ChatTextFiledStyle(
                    sendBtnAction: {
                    
                    },
                    fileBtnAction: {
                        
                    }
                ))
                .padding(.horizontal, 20)
        }
        .background(Color.red)
    }
}
