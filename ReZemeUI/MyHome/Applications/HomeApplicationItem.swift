//
//  HomeApplicationItem.swift
//  ReZemeUI
//
//  Created by Shakhzod on 04/05/23.
//

import SwiftUI

struct HomeApplicationItem: View {
    
    var property: Property
    let height: CGFloat = 172.0
    
    let removeAction: EmptyClosure
    let viewApplicationAction: EmptyClosure
    let messageAgentAction: EmptyClosure
    
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
                            
                            TextWithStroke(text: "Easy Apply")
                            
                            Spacer()
                            
                            Image(systemName: "trash")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.white)
                                .padding(8)
                                .frame(width: 30, height: 30)
                                .background(
                                    Circle()
                                        .fill(.red)
                                )
                                .makeButton(action: removeAction)
                            
                        }
                        .padding(.leading, 6)
                        .padding(.trailing, 9)
                        .padding(.top, 9)
                        
                        Spacer()
                        
                        ItemImageBottomTextView(
                            firstText: "Application #1",
                            secondText: "Likeability: 8/10"
                        )
                    }
                }
                
                Text((property.generalInformation?.address ?? "***"))
                    .medium12
                    .foregroundColor(.black)
                
                ItemShortInfoViewHome(
                    bedCount: "\(property.generalInformation?.bedrooms ?? 0)",
                    bathCount: "\(property.generalInformation?.bathrooms ?? 0)",
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
                        viewApplicationAction()
                    }
                    
                    linkButtonStroke(title: "Message Renter") {
                        messageAgentAction()
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


extension HomeApplicationItem {
    
    
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
                
                Text(title)
                    .foregroundColor(.white)
                    .medium14
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

extension HomeApplicationItem {
    
    struct ItemShortInfoViewHome: View {
        var bedCount: String
        var bathCount: String
        var areaSqft: String
        
        var body: some View {
            HStack {
                itemView(imageName: "big-beds", text: "\(bedCount) Studio")
                itemView(imageName: "big_baths", text: "\(bathCount) ba")
                itemView(imageName: "map_ic", text: "\(areaSqft) sqft")
            }
        }
        
        func itemView(imageName: String, text: String) -> some View {
            return HStack {
                Image(imageName)
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.secondaryPurple)
                    .frame(width: 24, height: 24)
                
                Text(text)
                    .regular12
                    .foregroundColor(.textGray)
            }
            .padding(.trailing)
        }
    }
    
}

struct HomeApplicationItem_Previews: PreviewProvider {
    static var previews: some View {
        HomeApplicationItem(property: mockProperty, removeAction: {}, viewApplicationAction: {}, messageAgentAction: {})
            .frame(height: 419)
    }
}
