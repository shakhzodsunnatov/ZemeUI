//
//  OfferChat.swift
//  ReZeme
//
//  Created by Shakhzod on 11/04/23.
//

import SwiftUI

struct OfferChat: View {
    
    //MARK: - PROPERTIES
    let model: OfferChatModel
    
    let acceptAction = {}
    let denyAction = {}
    
    
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
                        
                        Text(formatCurrency(currency: model.cost))
                        
                        Spacer()
                        
                        Text(model.date, style: .date)
                    }
                    .semibold16
                    .foregroundColor(.darkBlue)
                    .padding(.top, 8)
                }
                .multilineTextAlignment(.leading)
                
            }
            
            acceptDenyButtons(
                accept: acceptAction,
                deny: denyAction
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
                .stroke(Color.darkBlue, lineWidth: 1)
        )
    }
}

//MARK: - UI Components

extension OfferChat {
    
    private func getImageBy(url: URL?) -> some View {
        AsyncImage(
            url: url?.absoluteString,
            placeHolderState: .rectangle,
            placeHolderFor: .AGENT)
    }
    
    private func acceptDenyButtons(
        accept: @escaping ()->Void,
        deny: @escaping ()->Void
    ) -> some View {
        HStack(spacing: 14) {
            
            Spacer()
            
            Button(action: accept) {
                Text("Accept")
                    .semibold14
                    .foregroundColor(.white)
                    .frame(width: 87, height: 36)
                    .background(
                        Capsule()
                            .fill(Color.blueGradient.toLinearGradient)
                    )
            }
            
            Button(action: deny) {
                Text("Deny")
                    .foregroundColor(.darkBlue)
                    .semibold14
                    .frame(width: 87, height: 36)
                    .background(
                        Capsule()
                            .stroke(Color.darkBlue)
                    )
            }
            
        }
    }
    
}

struct OfferChat_Previews: PreviewProvider {
    static var previews: some View {
        OfferChat(
            model: OfferChatModel(
                name: "New Rent Proposal",
                address: "107-02 Queens Blvd Queens",
                date: Date(),
                cost: 1865,
                imageURLStr: "https://images.coolhouseplans.com/plans/44207/44207-b600.jpg"
            )
        )
    }
}
