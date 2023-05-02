//
//  AgentPropertyItem.swift
//  ReZeme
//
//  Created by Davron_Usmanov on 14.04.2023.
//

import SwiftUI

struct AgentPropertyItemView: View {
    
    var property: Property
    let width = UIScreen.main.bounds.width - 60
    let height: CGFloat = 172.0
    
    @Binding var push: Bool
    @Binding var properID: Int
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                ZStack {
                    
                    AsyncImage(
                        url: property.imageInformation?.images?.first?.image,
                        placeHolderState: .rectangle,
                        placeHolderFor: .RENTER
                    )
                    .frame(height: height)
                    
                    VStack {
                        HStack {
                            TextWithStroke(text: "2 New Applications")
                            Spacer()
                            
                            Button {
                                
                            } label: {
                                ZStack {
                                    Circle()
                                        .fill(Color.blue)
                                        .frame(width: 30, height: 30)
                                    Image("pencil-edit")
                                }
                            }
                        }
                        .padding(.leading, 13)
                        .padding(.trailing, 9)
                        .padding(.top, 9)
                        
                        Spacer()
                        
                        ItemImageBottomTextView(
                            firstText: (property.generalInformation!.propertyName!.isEmpty ? "BLVD" : property.generalInformation!.propertyName) ?? "",
                            secondText: "\(formatCurrency(currency: (property.economicInformation?.cost ?? 0)))/mo"
                        )
                    }
                }
                
                Text((property.generalInformation?.address ?? "***"))
                    .medium12
                    .foregroundColor(.black)
                
                Text("Unit 6J")
                    .regular12
                    .foregroundColor(.black)
                
                HStack(spacing: 10) {
                    smallImageWithText(img: "agent-views", text: "100")
                    smallImageWithText(img: "agent-saves", text: "20")
                    smallImageWithText(img: "applications", text: "10")
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        ZStack {
                            Circle()
                                .stroke(Color.purpleGradient.endColor,lineWidth: 1)
                                .frame(width: 40, height: 40)
                            Image("status-up")
                        }
                    }
                    
                    Button {
                        
                    } label: {
                        ZStack {
                            Circle()
                                .fill(Color.purpleGradient.toLinearGradient)
                                .frame(width: 40, height: 40)
                            Image("agent-chats")
                        }
                    }
                }
                
                HStack(spacing: 16) {
                    linkButton(title: "Generate Application") {
                        
                    }
                    linkButtonStroke(title: "View Applications") {
                        properID = property.id ?? 0
                        push = true
                    }
                }
            }
            .padding(.all, 10)
            .background(Color.white)
            .cornerRadius(8)
        }
        .padding(.all, 8)
        .glow(radius: 20)
    }
    
  
}

extension AgentPropertyItemView {
    

    func smallImageWithText(img: String, text: String)-> some View {
        HStack {
            HStack(spacing: 5) {
                Image(img)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 15, height: 15)
                Text(text)
                    .foregroundColor(.black)
                    .medium12
            }
        }
    }

//
    
    func linkButton(title: String,action: @escaping () -> Void) -> some View {
        
        Button(action: action) {
            ZStack {
                Color.blueGradient.toLinearGradient
                HStack {
                    Image("qr_code_white")
                        .resizable()
                        .frame(width: 13,height: 13)
                    
                    Text(title)
                        .foregroundColor(.white)
                        .medium12
                }
            }
            .frame(height: 40)
            .cornerRadius(20)
        }
    }
    
    func linkButtonStroke(title: String,action: @escaping () -> Void) -> some View {
        
        Button(action: action) {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.blueGradient.startColor,lineWidth: 1)
                
                Text(title)
                    .foregroundColor(Color.blueGradient.startColor)
                    .medium12
                
            }
            .frame(height: 40)
            .frame(maxWidth: .infinity)
            .cornerRadius(20)
        }
    }
}
