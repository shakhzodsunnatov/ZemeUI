//
//  ApplicationsListView.swift
//  ReZeme
//
//  Created by Davron_Usmanov on 14.04.2023.
//

import SwiftUI

struct ApplicationItemView: View {
    
    var property: Property
    let height: CGFloat = 172.0
    
    var body: some View {
        VStack {
            VStack(alignment: .leading,spacing: 11) {
                ZStack {
                    
                    AsyncImage(
                        url: property.imageInformation?.images?.first?.image,
                        placeHolderState: .rectangle,
                        placeHolderFor: .RENTER
                    )
                    .frame(height: height)
                    
                    VStack {
                        HStack {
                            Spacer()
                            
                            TextWithStroke(text: "Application # \(property.id ?? 1)")
                            
                        }
                        .padding(.leading, 13)
                        .padding(.trailing, 9)
                        .padding(.top, 9)
                        
                        Spacer()
                        
                        ItemImageBottomTextView(
                            firstText: "BLVD",
                            secondText: ""
                        )
                    }
                }
                
                Text((property.generalInformation?.address ?? "***"))
                    .medium12
                    .foregroundColor(.black)
                
                ItemShortInfoView(
                    bedCount: "\(property.generalInformation?.bedrooms ?? 0)",
                    bathCount: "\(property.generalInformation?.bathrooms ?? 0) bath",
                    areaSqft: "\(property.generalInformation?.squareFootage ?? 0)"
                )
                
                ZStack {
                    Color.purpleLow.opacity(0.03)
                        .cornerRadius(10)
                    
                    ApplicationProgress(completedIndex: .constant(2))
                        .padding(20)
                    
                }.padding(.vertical,10)
                
                HStack(spacing: 16) {
                    linkButton(title: "View Application") {
                        
                    }
                    linkButtonStroke(title: "Message Renter") {
                        
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


extension ApplicationItemView {
    

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
//                HStack {
//                    Image("qr_code_white")
//                        .resizable()
//                        .frame(width: 13,height: 13)
                    
                    Text(title)
                        .foregroundColor(.white)
                        .medium12
//                }
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
