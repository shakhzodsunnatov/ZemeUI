//
//  SavedItemView.swift
//  ReZemeUI
//
//  Created by Shakhzod on 29/04/23.
//

import SwiftUI

struct SavedItemView: View {

    var property: Property
    
    var body: some View {
        VStack(alignment: .leading) {
                ZStack {
                    
                    AsyncImage(
                        url: property.imageInformation?.images?.first?.image,
                        placeHolderState: .rectangle,
                        placeHolderFor: .RENTER
                    )
                    
                    VStack {
                        HStack {
                            TextWithStroke(text: "Easy Apply")
                               
                            Spacer()
                            
                            SavedButton { isLiked in }
                        }
                        .padding(.leading, 13)
                        .padding(.trailing, 9)
                        .padding(.top, 9)
                        
                        Spacer()
                        
                        ItemImageBottomTextView(
                            firstText: "BLVD",
                            secondText: "\(formatCurrency(currency: (property.economicInformation?.cost ?? 0)))/mo"
                        )
                    }
                }
                .frame(height: 172)
                
                Text((property.generalInformation?.address ?? "***"))
                    .medium12
                    .foregroundColor(.black)
                
                Text("Unit 6J")
                    .regular12
                    .foregroundColor(.black)
                
                ItemShortInfoView(
                    bedCount: "\(property.generalInformation?.bedrooms ?? 0)",
                    bathCount: "\(property.generalInformation?.bathrooms ?? 0) bath",
                    areaSqft: "\(property.generalInformation?.squareFootage ?? 0)"
                )
            }
        .padding(10)
        .roundedShadow()
    }
}

struct SavedItemView_Previews: PreviewProvider {
    static var previews: some View {
        SavedItemView(property: mockProperty)
            .padding(.horizontal,20)
//            .background(Color.red)
    }
}
