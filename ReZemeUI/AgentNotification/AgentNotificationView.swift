//
//  AgentNotificationView.swift
//  ReZemeUI
//
//  Created by Davron_Usmanov on 26.04.2023.
//

import SwiftUI

struct AgentNotificationView: View {
    
    @State var isActive: Bool = false
    
    var body: some View {
        CustomNavBar(
            content: {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 0) {
                        ForEach(0..<3, id: \.self) { _ in
                            notificationCell()
                        }
                    }
                    .padding(.top,20)
                    .padding(.bottom, 50)
                }
            },
            title: "Notifications",
            style: .newTitleAndIcon,
            type: .agent
        )
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarHidden(true)
    }
}

extension AgentNotificationView {
    
    func notificationCell() -> some View {
        VStack {
            HStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.darkBlue.opacity(0.1))
                    .frame(width: 66,height: 55)
                    .overlay(
                    Image("agent-notification")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(.darkBlue)
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                    )
                
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Text("Jake Jones")
                            .bold14
                        Spacer()
                        Text("Jan 4, 2022")
                            .medium14
                            .foregroundColor(.darkBlue)
                    }
                    
                    Text("Jan 4, 2022")
                        .medium14
                    
                    HStack {
                        HStack {
                            Image("pin")
                                .renderingMode(.template)
                                .frame(width: 12, height: 12)
                                .padding(.horizontal,6)
                                .padding(.vertical,10)
                                .foregroundColor(Color.blue)
                            Text("420 E 54th St, New York, NY 10022")
                                .medium12
                        }
                        Spacer()
                        
                        Button {
                            self.isActive.toggle()
                        } label: {
                            Image(systemName: "chevron.right")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.purpleLow)
                                .frame(width: 19, height: 12)
                                .rotationEffect(.degrees(isActive ? 90:0))
                                .background(
                                Circle()
                                    .fill(Color.purpleLow.opacity(0.1))
                                    .frame(width: 30,height: 30)
                                    
                                )
                        }

                        
                    }
                    .padding(.bottom,0)
                }
            }
            .padding(.trailing,10)
            if isActive {
                dropcell(title: "Contract Signed", image: "")
                    .padding(.top,12)
                    .padding(.horizontal,13)
            }
        }
        .padding(.horizontal, 13)
        .padding(.vertical, 19)
        .roundedShadow()
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
    }
    
    func dropcell(title: String, image: String)-> some View {
        Button {
            
        } label: {
            HStack(spacing:0) {
                Image(image)
                    .resizable()
                    .renderingMode(.template)
                    .scaledToFit()
                    .foregroundColor(Color.darkBlue)
                    .padding(15)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.darkBlue.opacity(0))
                    )
                    .frame(width: 52, height: 52)
                
                
                Text(title)
                    .medium14
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.purpleLow)
                    .frame(width: 19, height: 12)
                    .background(
                    Circle()
                        .stroke(Color.purpleLow,lineWidth: 1)
//                        .fill(Color.purpleLow.opacity(0.1))
                    
                        .frame(width: 30,height: 30)
                        
                    )
            }
            .frame(minHeight: 52)
        }

        
    }
}

struct AgentNotificationView_Previews: PreviewProvider {
    static var previews: some View {
        AgentNotificationView()
    }
}
