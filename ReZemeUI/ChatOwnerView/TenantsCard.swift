//
//  TenantsCard.swift
//  ReZemeUI
//
//  Created by Shakhzod on 06/05/23.
//

import SwiftUI

struct TenantsCard: View {
    
    //MARK: - PROPERTIES
    
    let completedUntilNumber: Int
    let model: Property
    let chatBtnAction: ()->Void
    
    //MARK: - body
    
    var body: some View {
        VStack(spacing: 12) {
            
            HStack(spacing: 7) {
                
                propertyImageView
                    .frame(width: 85, height: 63)
                
                VStack(alignment: .leading, spacing: 2) {
                    
                    HStack(alignment: .top) {
                        
                        Text(model.generalInformation?.propertyName ?? "***")
                            .medium16
                            .lineLimit(2)
                            .fixedSize(horizontal: false, vertical: true)
                        
                        Spacer()
                        
                        chatButton(action: chatBtnAction)
                        
                    }
                    
                    streetName(title: model.generalInformation?.address ?? "***")
                    
                }
                
            }
            .frame(height: 63)
            
            addressTitles()
        }
        .padding(10)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}


//MARK: - UI Components

extension TenantsCard {
    
    private var propertyImageView: some View {
        Image("mockHomeImage")
            .resizable()
            .scaledToFill()
            .cornerRadius(radius: 8, corners: .allCorners)
    }
    
    private func chatButton(action: @escaping ()-> Void) -> some View {
        Button(action: action) {
            Image("messages_ic")
                .resizable()
                .scaledToFill()
                .padding(10)
                .frame(width: 40, height: 40)
                .background(
                    Circle()
                        .fill(Color.secondaryPurple)
                )
        }
    }
    
    private func streetName(title: String) -> some View {
        HStack(spacing: 4) {
            
            Image("home")
                .resizable()
                .scaledToFill()
                .frame(width: 16, height: 16)
            
            Text("Sven LLC - Unit 4A")
                .regular12
        }
    }
    
    private func addressTitles() -> some View {
        VStack(spacing: 7) {
            
            HStack(spacing:6) {
                Image("location_ic")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 12, height: 12)
                
                Text("315 W 33rd St. Unit 4A, New York, NY 10001")
                    .regular12
                
                Spacer()
            }
            
            HStack(spacing:6) {
                Image("calendar_ic")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 12, height: 12)
                
                Text("Lease End Date")
                    .foregroundColor(.textGray)
                    .regular12
                
                Text("30 Mar 2023")
                    .medium12
                
                Spacer()
            }
        }
    }
    
}

struct TenantsCard_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.background
            
            TenantsCard(completedUntilNumber: 3, model: mockProperty) { /* Chat Icon Tapped action */ }
        }
    }
}
