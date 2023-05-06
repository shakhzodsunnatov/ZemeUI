//
//  OwnerServiceRequestDetailView.swift
//  ReZemeUI
//
//  Created by Davron_Usmanov on 03.05.2023.
//

import SwiftUI

struct OwnerServiceRequestDetailView: View {
    
    private let currens = ["In Progress","In Review", "Resolved"]
    private let property = ["John Doe","Melissa Reed", "Jake Jackson", "Michael Green"]
    
    var grid: [GridItem] = [
        GridItem(.flexible(), spacing: 10 , alignment: .leading),
        GridItem(.flexible(), spacing: 10 , alignment: .leading),
        GridItem(.flexible(), spacing: 10 , alignment: .leading)
    ]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading,spacing: 20) {
                fistCell()
                    
                centerCell()
                Text("Assignee Information")
                    .semibold18
                
                thirdCell()
                
                lastCell()
            }
            .padding(.horizontal,20)
            .padding(.vertical,12)
        }
        .navigationOwner(title: "Service Request Details")
    }
}

extension OwnerServiceRequestDetailView {
    
    func fistCell()-> some View {
        ZStack(alignment: .topTrailing) {
            VStack(alignment: .leading, spacing: 6) {
                Text("No. 674669")
                    .semibold16
                
                Text("Sink Clogged")
                    .semibold22
                
                HStack {
                    Image("danger")
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 15,height: 15)
                        .foregroundColor(.red)
                    
                    Text("High Priority")
                        .regular12
                }
                
                Text("Bathroom Sink ")
                    .medium12
                    .foregroundColor(.purpleLow)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical,7)
                    .background(Color.purpleLow.opacity(0.1))
                    .cornerRadius(8)
                    .padding(.bottom,10)
            }
            
            DropDownMenuSmoller(titles: currens, selectedIndex: { selectedIndex in},borderColor: .darkBlue ,content: {
                
            })
            .frame(width: 120)
        }
        .padding(.horizontal,12)
        .padding(.vertical,12)
        .roundedShadowNew()
    }
    
    func centerCell()-> some View {
        VStack {
            HStack {
                Image("mockHomeImage")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 110, height: 85)
                    .cornerRadius(8)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("Sven LIC")
                        .semibold16
                    
                    Text("29-59 Northern Blvd, Long Island City, NY 11101C")
                        .medium12
                    
                    Text("Unit 39F")
                        .regular12
                }
            }
            
            Text("My sink is clogged since last night. I have tried various strong products to see if it unclogs but it does not.")
                .medium12
            
            LazyVGrid(columns: grid, spacing: 10) {
                ForEach(0..<3,id: \.self) { model in
                    Image("mockHomeImage")
                        .resizable()
                        .scaledToFill()
                        .frame(height: 85)
                        .cornerRadius(8)
                }
            }
            
            HStack() {
                Image("calendar")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 15,height: 15)
                    .foregroundColor(.darkBlue)
                
                Text("Preferred Service:")
                    .regular12
                    .foregroundColor(.gray.opacity(0.9))
                
                Text("Wed. 04/03/2022 at 10:00 AM")
                    .semibold11
                
                Spacer()
                
            }
            
            HStack() {
                Image("inputIcon")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 15,height: 15)
                    .foregroundColor(.darkBlue)
                
                Text("Permission to access without tenant present?")
                    .regular12
                    .foregroundColor(.gray.opacity(0.9))
                
                Image("tick-square")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 15,height: 15)
                    .foregroundColor(.green)
                
                Spacer()
            }
        }
        .padding(10)
        .roundedShadowNew()
    }
    
    func thirdCell()-> some View {
        VStack(alignment: .leading,spacing: 20) {
            HStack() {
                Image("buliding_ic")
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 15,height: 15)
                    .foregroundColor(.darkBlue)
                
                Text("Assign to Property Maintenance")
                    .regular12
                    .foregroundColor(.gray.opacity(0.9))
                Spacer()
            }
            
            DropDownMenuNew(titles: property, selectedIndex: { selectedIndex in}) {
                
            }
            
            HStack(spacing: 14) {
                linkButton(title: "Re-Assign",type: .RENTER, stoke: true) {
                    
                }
                
                linkButton(title: "Follow Up",type: .RENTER) {
                    
                }
            }
        }
        .padding(20)
        .roundedShadowNew()
    }
    
    func lastCell() -> some View {
        HStack(alignment: .center, spacing: 12) {
            
            VStack(alignment: .leading, spacing: 3) {
                
                Text("Find local professionals, Handymen, and services")
                    .semibold14
                
                Text("Find a service pro near you")
                    .medium12
            }
            .foregroundColor(.black)
            .multilineTextAlignment(.leading)
            
            Spacer()
            
            Image(systemName: "chevron.right.circle")
                .resizable()
                .scaledToFill()
                .foregroundColor(.darkBlue)
                .frame(width: 26, height: 26)
        }
        .padding(EdgeInsets(top: 13, leading: 10, bottom: 12, trailing: 24))
        .roundedShadow()
        .makeButton{}
    }
    
    func linkButton(title: String,type:AccountType = .AGENT,stoke: Bool = false ,action: @escaping () -> Void) -> some View {
        
        Button(action: action) {
            ZStack {
                
                if stoke {
                    RoundedRectangle(cornerRadius: 27.5)
                        .stroke(type == .AGENT ? Color.purpleGradient.toLinearGradient : Color.blueGradient.toLinearGradient,lineWidth: 1)
                        .frame(height: 55)
                        .overlay (
                            Text(title)
                                .foregroundColor(type == .AGENT ? Color.purpleLow : Color.darkBlue )
                                .bold18
                        )
                } else {
                    RoundedRectangle(cornerRadius: 27.5)
                        .fill(type == .AGENT ? Color.purpleGradient.toLinearGradient : Color.blueGradient.toLinearGradient)
                        .frame(height: 55)
                        .overlay (
                            Text(title)
                                .foregroundColor(.white)
                                .bold18
                        )
                }
            }
            
        }
    }
}

struct OwnerServiceRequestDetailView_Previews: PreviewProvider {
    static var previews: some View {
        OwnerServiceRequestDetailView()
    }
}




