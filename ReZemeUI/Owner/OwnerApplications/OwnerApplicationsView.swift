//
//  OwnerApplicationView.swift
//  ReZemeUI
//
//  Created by Davron_Usmanov on 02.05.2023.
//

import SwiftUI


struct OwnerApplicationsView: View {
    var body: some View {
        
        CustomNavBar(
            content: {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        ForEach(0..<3, id: \.self) { property in
                            
                            ApplicationItemView(property: mockProperty)
                            
                        }
                    }
                    .padding(.bottom, 50)
                }
            },
            title: "Applications",
            style: .newTitleAndIcon,
            type: .owner
        )
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarHidden(true)
        
    }
}

struct OwnerApplicationView_Previews: PreviewProvider {
    static var previews: some View {
        OwnerApplicationsView()
    }
}
