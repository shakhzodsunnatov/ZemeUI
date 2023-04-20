//
//  ContentView.swift
//  ReZemeUI
//
//  Created by Shakhzod on 16/04/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView {
            
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
        .padding()
        .navigationBarHidden(true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
