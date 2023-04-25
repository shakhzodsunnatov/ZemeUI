//
//  AgentApplicationsView.swift
//  ReZemeUI
//
//  Created by Davron_Usmanov on 24.04.2023.
//

import SwiftUI

struct AgentApplicationsView: View {
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
            type: .agent
        )
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarHidden(true)
        
    }
}

struct AgentApplicationsView_Previews: PreviewProvider {
    static var previews: some View {
        AgentApplicationsView()
    }
}
