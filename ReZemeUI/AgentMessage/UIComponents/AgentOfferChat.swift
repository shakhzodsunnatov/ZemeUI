//
//  AgentOfferChat.swift
//  ReZemeUI
//
//  Created by Shakhzod on 19/04/23.
//

import Foundation
import SwiftUI

struct AgentOfferChat: View {
    
    //MARK: - PROPERTIES
    let model: OfferChatModel
    
    var deleteAction = {}
    var changeAction = {}
    
    
    var body: some View {
        VStack(spacing: 0) {
            
            HStack(alignment: .top, spacing: 16) {
                
                getImageBy(url: model.imageURL)
                    .frame(width: 87, height: 68)
                
                VStack(alignment: .leading, spacing: 0) {
                    
                    Text(model.name)
                        .bold14
                    
                    Text(model.address)
                        .medium14
                    
                    HStack {
                        
                        Text(formatCurrency(currency: model.cost) + "/mo")
                        
                        Spacer()
                        
                        Text(model.date, style: .date)
                    }
                    .semibold16
                    .foregroundColor(.darkBlue)
                    .padding(.top, 8)
                }
                .multilineTextAlignment(.leading)
                
            }
            
            deleteChangeButtons(
                delete: deleteAction,
                change: changeAction
            )
            .padding(.top, 15)
            
        }
        .padding(
            EdgeInsets(
                top: 9,
                leading: 9,
                bottom: 18,
                trailing: 16
            )
        )
        .background(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.secondaryPurple, lineWidth: 1)
        )
    }
}

//MARK: - UI Components

extension AgentOfferChat {
    
    private func getImageBy(url: URL?) -> some View {
        AsyncImage(
            url: url?.absoluteString,
            placeHolderState: .rectangle,
            placeHolderFor: .AGENT)
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


struct AgentOfferChat_Previews: PreviewProvider {
    static var previews: some View {
        AgentOfferChat(model: offerModelMock)
    }
}
