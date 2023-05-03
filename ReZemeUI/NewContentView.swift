//
//  NewContentView.swift
//  ReZemeUI
//
//  Created by Shakhzod on 02/05/23.
//

import SwiftUI

struct NewContentView: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            
            NavigationLink(destination: { MyServiceRequestView() }) {
                Text("My Service Request View")
                    .foregroundColor(.white)
                    .padding(15)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.lightBlue)
                    )
            }
            
            NavigationLink(destination: {
                OwnerNotificationView()
            }) {
                Text("Owner Notification View")
                    .foregroundColor(.white)
                    .padding(15)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.lightBlue)
                    )
            }
            
            NavigationLink(destination: {
                OwnerEditProfileView()
            }) {
                Text("Owner Edit Profile View")
                    .foregroundColor(.white)
                    .padding(15)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.lightBlue)
                    )
            }
            
            NavigationLink(destination: {
                OwnerPropertyStatisticsView()
            }) {
                Text("Owner Property Statistics View")
                    .foregroundColor(.white)
                    .padding(15)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.lightBlue)
                    )
            }
            
            NavigationLink(destination: {
                OwnerApplicationsView()
            }) {
                Text("Owner Applications View")
                    .foregroundColor(.white)
                    .padding(15)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.lightBlue)
                    )
            }
            
            NavigationLink(destination: {
                OwnerSpecificApplicationView()
            }) {
                Text("Owner Specific Application View")
                    .foregroundColor(.white)
                    .padding(15)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.lightBlue)
                    )
            }
            
        }
    }
}

struct NewContentView_Previews: PreviewProvider {
    static var previews: some View {
        NewContentView()
    }
}
