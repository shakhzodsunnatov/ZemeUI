//
//  ContentView.swift
//  ReZemeUI
//
//  Created by Shakhzod on 16/04/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            Group {
                NavigationLink(destination: { ApplicationChecklist() }) {
                    Text("Open Application Checklist")
                        .foregroundColor(.white)
                        .padding(15)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.lightBlue)
                        )
                }
                
                NavigationLink(destination: { MessageRenter() }) {
                    Text("Open Renter Message")
                        .foregroundColor(.white)
                        .padding(15)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.lightBlue)
                        )
                }
                
                NavigationLink(destination: { MessageAgent() }) {
                    Text("Open Agent Message")
                        .foregroundColor(.white)
                        .padding(15)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.lightBlue)
                        )
                }
                
                NavigationLink(destination: { PhoneNumberView() }) {
                    Text("Phone Number")
                        .foregroundColor(.white)
                        .padding(15)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.lightBlue)
                        )
                }
            }
            
            Group {
                NavigationLink(destination: { SettingsRenter() }) {
                    Text("Settings")
                        .foregroundColor(.white)
                        .padding(15)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.lightBlue)
                        )
                }
                
                NavigationLink(destination: { SupportRenter() }) {
                    Text("Support")
                        .foregroundColor(.white)
                        .padding(15)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.lightBlue)
                        )
                }
                
                NavigationLink(destination: { MyDocumentsView() }) {
                    Text("My Documents View")
                        .foregroundColor(.white)
                        .padding(15)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.lightBlue)
                        )
                }
                
                NavigationLink(destination: { QRView() }) {
                    Text("Share Property")
                        .foregroundColor(.white)
                        .padding(15)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.lightBlue)
                        )
                }
                
                NavigationLink(destination: {
                    AgentMainView()
                }) {
                    Text("Agent FilterView")
                        .foregroundColor(.white)
                        .padding(15)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.lightBlue)
                        )
                }
                
                NavigationLink(destination: {
                    AgentEditProfile()
                }) {
                    Text("Agent Edit Profile")
                        .foregroundColor(.white)
                        .padding(15)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.lightBlue)
                        )
                }
                
                NavigationLink(destination: {
                    AgentApplicationsView()
                }) {
                    Text("Agent Applications")
                        .foregroundColor(.white)
                        .padding(15)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.lightBlue)
                        )
                }
                
                NavigationLink(destination: {
                    AgentSpecificApplicationView()
                }) {
                    Text("Agent Specific Application")
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
                    ApplicationsEmptyView()
                }) {
                    Text("Application Empty View")
                        .foregroundColor(.white)
                        .padding(15)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.lightBlue)
                        )
                }
                
                NavigationLink(destination: {
                    SavedListingsEmptyView()
                }) {
                    Text("Saved Listings Empty View")
                        .foregroundColor(.white)
                        .padding(15)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.lightBlue)
                        )
                }
                
                NavigationLink(destination: {
                    AgentPhoneNumberView()
                }) {
                    Text("Agent Phone number")
                        .foregroundColor(.white)
                        .padding(15)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.lightBlue)
                        )
                }
                
                NavigationLink(destination: {
                    AgentProStatisticView()
                }) {
                    Text("Agent Property Statistics")
                        .foregroundColor(.white)
                        .padding(15)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.lightBlue)
                        )
                }
               
                NavigationLink(destination: {
                    AgentNotificationView()
                }) {
                    Text("Agent Notification view")
                        .foregroundColor(.white)
                        .padding(15)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.lightBlue)
                        )
                }
                
                NavigationLink(destination: {
                    RenterProfileEditView()
                }) {
                    Text("Renter Profile Edit View")
                        .foregroundColor(.white)
                        .padding(15)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.lightBlue)
                        )
                }
                
                NavigationLink(destination: {
                    RenterPropertyDetailView()
                }) {
                    Text("Renter Property Detail View")
                        .foregroundColor(.white)
                        .padding(15)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.lightBlue)
                        )
                }
                
                NavigationLink(destination: {
                    AgentOverStatView()
                }) {
                    Text("Agent Overall Statistics")
                        .foregroundColor(.white)
                        .padding(15)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.lightBlue)
                        )
                }
                
            }
        }
        .padding()
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
