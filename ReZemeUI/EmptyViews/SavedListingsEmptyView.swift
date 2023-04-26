//
//  SavedListingsEmptyView.swift
//  ReZemeUI
//
//  Created by Shakhzod on 25/04/23.
//

import SwiftUI

struct SavedListingsEmptyView: View {
    var body: some View {
        VStack {
            
            Image("savesEmpty")
                .resizable()
                .scaledToFit()
                .padding(.horizontal, 67)
                .padding(.top, 70)
            
            VStack(spacing: 13) {
                
                Text("No Applications")
                    .medium26
                
                Text("You haven’t applied to any listings. Once you apply they will show here.")
                    .regular16
            }
            .multilineTextAlignment(.center)
            .padding(.horizontal, 48)
            .padding(.top, 64)
            
            Spacer()
            
            ActionButton("Apply now")
                .padding(.horizontal, 76)
            
        }
        .navigationRenter(title: "Saved Listings")
    }
}

struct SavedListingsEmptyView_Previews: PreviewProvider {
    static var previews: some View {
        SavedListingsEmptyView()
    }
}
