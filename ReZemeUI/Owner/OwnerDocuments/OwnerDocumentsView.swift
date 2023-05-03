//
//  OwnerDocumentsView.swift
//  ReZemeUI
//
//  Created by Davron_Usmanov on 03.05.2023.
//

import SwiftUI

struct OwnerDocumentsView: View {
    
    private let mockTitles = [
        "Lease Agreement",
        "Move-In Checklist",
        "Rental Application",
        "Tenant Acceptance Letter"
    ]
    
    private let mockSubTitle = [
        "Signed 04/23/2022",
        "Signed 04/23/2022",
        "Signed 04/23/2022",
        "Signed 04/23/2022"
    ]
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            
            Text("View your signed documents here")
                .semibold18
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                .padding(.top, 14)
            
            VStack(spacing: 20) {
                
                ForEach((0..<mockTitles.count), id: \.self) { index in
                    DocumentItemCell(
                        image: "document_ic",
                        title: mockTitles[index],
                        subTitle: mockSubTitle[index],
                        action: { }
                    )
                    .padding(.horizontal, 20)
                }
                
            }
            .padding(.top, 13)
            .padding(.bottom, 50)
        }
        .navigationOwner(title: "Documents")
    }
}

struct OwnerDocumentsView_Previews: PreviewProvider {
    static var previews: some View {
        OwnerDocumentsView()
    }
}


