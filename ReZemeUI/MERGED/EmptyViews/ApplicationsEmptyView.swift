//
//  ApplicationsEmptyView.swift
//  ReZemeUI
//
//  Created by Shakhzod on 25/04/23.
//

import SwiftUI

struct ApplicationsEmptyView: View {
    var body: some View {
        VStack {
            
            Image("homeKey")
                .resizable()
                .scaledToFit()
                .padding(.horizontal, 60)
                .padding(.top, 70)
            
            VStack(spacing: 13) {
                
                Text("No Applications")
                    .medium26
                
                Text("You haven’t applied to any listings. Once you apply they will show here.")
                    .regular16
            }
            .multilineTextAlignment(.center)
            .padding(.horizontal, 48)
            .padding(.top, 34)
            
            Spacer()
            
            ActionButton("Apply now")
                .padding(.horizontal, 76)
            
        }
        .navigationRenter(title: "Application")
    }
}

struct ApplicationsEmptyView_Previews: PreviewProvider {
    static var previews: some View {
        ApplicationsEmptyView()
    }
}
