//
//  ContentView.swift
//  ReZemeUI
//
//  Created by Shakhzod on 16/04/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            
            NavigationLink(destination: { ApplicationChecklist() }) {
                Text("Open Application Checklist")
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
