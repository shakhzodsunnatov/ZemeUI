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
            
            NavigationLink(destination: { MyHomeView() }) {
                Text("My Home View")
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
            
            Group {
                NavigationLink(destination: {
                    OwnerRegistarionVC()
                }) {
                    Text("Owner Registarion")
                        .foregroundColor(.white)
                        .padding(15)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.lightBlue)
                        )
                }
                
                NavigationLink(destination: {
                    OwnerAddMaintenaceContact()
                }) {
                    Text("Owner Add Maintenace Contact")
                        .foregroundColor(.white)
                        .padding(15)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.lightBlue)
                        )
                }
                
                NavigationLink(destination: {
                    ManageMaintenanceListVC()
                }) {
                    Text("Owner Manage Maintenance List")
                        .foregroundColor(.white)
                        .padding(15)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.lightBlue)
                        )
                }
                
                NavigationLink(destination: {
                    OwnerDocumentsView()
                }) {
                    Text("Owner Documents")
                        .foregroundColor(.white)
                        .padding(15)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.lightBlue)
                        )
                }
            }
            
            Group {
                NavigationLink(destination: {
                    OwnerTransactionDetailView()
                }) {
                    Text("Owner Transaction Detail")
                        .foregroundColor(.white)
                        .padding(15)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.lightBlue)
                        )
                }
                
                NavigationLink(destination: {
                    OwnerCreateInvoiceView()
                }) {
                    Text("Owner Create Invoice")
                        .foregroundColor(.white)
                        .padding(15)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.lightBlue)
                        )
                }
                
                NavigationLink(destination: {
                    OwnerServiceRequestDetailView()
                }) {
                    Text("Owner Service Request Detail")
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
}

struct NewContentView_Previews: PreviewProvider {
    static var previews: some View {
        NewContentView()
    }
}
