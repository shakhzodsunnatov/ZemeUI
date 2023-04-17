//
//  HomeView.swift
//  ReZemeUI
//
//  Created by Davron_Usmanov on 18.04.2023.
//

import SwiftUI

struct HomeView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ScrollView() {
            VStack(alignment: .leading) {
                Text("Property Manager")
                    .semibold18
                    .multilineTextAlignment(.leading)
                    .padding(.leading,20)
                ForEach(0...1, id: \.self) { i in
                    propertyCell()
                }
                
                Text("Agents")
                    .semibold18
                    .multilineTextAlignment(.leading)
                    .padding(.leading,20)
                ForEach(0...3, id: \.self) { i in
                    agentsCell()
                        .onTapGesture {
                            presentationMode.wrappedValue.dismiss()
                        }
                }
            }
            
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


extension HomeView {
    
    func propertyCell() -> some View {
        HStack(spacing: 12) {
            Image("mockHomeImage")
                .resizable()
                .scaledToFill()
                .frame(width: 85,height: 63)
                .cornerRadius(8)
            
            VStack(spacing: 3) {
                HStack {
                    VStack(alignment: .leading,spacing: 0) {
                        Text("Robert Johnson")
                            .medium16
                        
                        HStack {
                            Image("home")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 12,height: 12)
                            Text("Sven LLC - Unit 4A")
                                .medium12
                        }
                    }
                    
                    Spacer()
                    Button {
                        
                    } label: {
                        Image("agent_message")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40,height: 40)
                            .cornerRadius(20)
                    }
                }
                HStack {
                    Image("renter_pin")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 12,height: 12)
                    Text("315 W 33rd St. New York, NY 10001")
                        .lineLimit(1)
                        .medium12
                    
                    Spacer()
                }
            }
            
            
        }
        .padding(10)
        .background(Color.white)
        .cornerRadius(8)
        .padding(.horizontal,20)
        .padding(.top,10)
        .shadowCustom()
        
        
    }
    
    func agentsCell() -> some View {
        HStack(spacing: 12) {
            Image("person")
                .resizable()
                .scaledToFill()
                .frame(width: 50,height: 50)
                .cornerRadius(25)
            
            VStack(alignment: .leading,spacing: 0) {
                Text("Melissa Smith")
                    .medium16
                
                Text("Castle Realtor Group")
                    .medium12
            }
            Spacer()
            Button {
                
            } label: {
                Image("agent_message")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40,height: 40)
                    .cornerRadius(20)
            }
        }
        .padding(10)
        .background(Color.white)
        .cornerRadius(8)
        .padding(.horizontal,20)
        .padding(.top,10)
        .shadowCustom()
        
        
    }
}

