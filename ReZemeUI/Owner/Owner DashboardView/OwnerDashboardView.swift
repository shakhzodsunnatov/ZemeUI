//
//  OwnerDashboardView.swift
//  ReZemeUI
//
//  Created by Davron_Usmanov on 06.05.2023.
//

import SwiftUI

struct OwnerDashboardView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    private let currens = ["31-60 days","1-30 days"]

    var grid: [GridItem] = [
        GridItem(.flexible(), spacing: 20 , alignment: .leading),
        GridItem(.flexible(), spacing: 20 , alignment: .leading)
    ]
    
    @State var selectIndex = 0
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Image("dashbordOwner")
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: 120)
                
                HStack {
                    Text("Dashboard")
                        .semibold22
                        .foregroundColor(.white)
                        .makeButton {
                            presentationMode.wrappedValue.dismiss()
                        }
                    
                    Spacer()
                    
                    Image("person")
                        .resizable()
                        .frame(width: 44,height: 44)
                    
                }
                .padding(.top,30)
                .padding(.horizontal,20)
            }
            
            
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading ,spacing: 16) {
                    fistCell()
                    
                    VStack(spacing: 14) {
                        HStack{
                            Text("Open Service Requests")
                                .regular14
                            
                            Spacer()
                            
                            Text("4")
                                .semibold18
                        }
                        linkButton(title: "Manage Service Requests",type: .RENTER, stoke: true) {
                            
                        }
                    }
                    .padding(.horizontal,20)
                    .padding(.vertical,20)
                    .roundedShadow()
                    
                    Text("My Listings")
                        .semibold18
                        .padding(.top,14)
                    
                    linkButton(title: "Add New Property",type: .RENTER) {
                        
                    }
                    
                    ToggleUI(titles: ["Closed Listings", "Open Listings"]) { i in
                        selectIndex = i
                    }
                    
                    ForEach(0..<2, id: \.self) { property in
                        if selectIndex == 0 {
                            cellClosing()
                        } else {
                            cellOpening()
                        }
                    }
                }
                .padding(.horizontal,20)
                .padding(.vertical,12)
                
            }
        }
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)
    }
}

extension OwnerDashboardView {
    
    func fistCell()-> some View {
        ZStack(alignment: .topTrailing) {
            VStack(alignment: .leading, spacing: 12) {
                Text("Stats")
                    .semibold18
                
                LazyVGrid(columns: grid, spacing: 10) {
                    circleView(loaded: 0.65, title: "My Listings", amount: "7", subtile1: "Occupied", subvalue1: "5", subtile2: "Vacant", subvalue2: "2")
                    
                    circleView(loaded: 0.85, title: "Payments", amount: "$4,400", subtile1: "Paid", subvalue1: "$3,900", subtile2: "Outstanding", subvalue2: "$600")
                }
            }
            
            DropDownMenuSmoller(titles: currens, selectedIndex: { selectedIndex in},borderColor: Color(hexString: "DFDFDF") ,content: {
                
            })
            .frame(width: 105)
            
            
        }
    }
    
    func circleView(loaded: Double,title: String, amount: String, subtile1: String, subvalue1: String, subtile2: String, subvalue2: String) -> some View {
        VStack(alignment: .center,spacing: 14) {
            
            HStack {
                Text(title)
                    .medium16
                Spacer()
            }
            
            ZStack {
                Circle()
                    .stroke(Color.darkBlue,lineWidth: 8)
                    .frame(width: 88)
                
                Circle()
                    .trim(from: loaded,to: 1)
                    .stroke(Color.purpleLow,lineWidth: 8)
                    .frame(width: 88)
                    .rotated(Angle(degrees: -90))
                
                VStack(spacing: -5) {
                    Text(amount)
                        .bold18
                    Text("Total")
                        .regular12
                    
                }
            }
            
            VStack(spacing: 5) {
                HStack {
                    HStack(spacing: 8) {
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 8)
                        Text(subtile1)
                            .regular12
                    }
                    Spacer()
                    
                    Text(subvalue1)
                        .regular12
                }
                
                HStack {
                    HStack(spacing: 8) {
                        Circle()
                            .fill(Color.purpleLow)
                            .frame(width: 8)
                        Text(subtile2)
                            .regular12
                    }
                    Spacer()
                    
                    Text(subvalue2)
                        .regular12
                }
            }
            
        }
        .padding(17)
        .roundedShadowNew()
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
                    RoundedRectangle(cornerRadius: 30)
                        .fill(type == .AGENT ? Color.purpleGradient.toLinearGradient : Color.blueGradient.toLinearGradient)
                        .frame(height: 60)
                        .overlay (
                            Text(title)
                                .foregroundColor(.white)
                                .bold18
                        )
                }
            }
            
        }
    }
    
    // MARK:  cell components
    
    func cellOpening() -> some View {
        VStack {
            VStack(alignment: .leading, spacing: 6) {
                ZStack {
                    
                   Image("testHouse")
                        .resizable()
                        .frame(maxWidth: .infinity,maxHeight: 170)
                    
                    
                    VStack {
                        HStack {
                            TextWithStroke(text: "2 New Applications")
                            Spacer()
                            
                            Button {
                                
                            } label: {
                                ZStack {
                                    Circle()
                                        .fill(Color.blue)
                                        .frame(width: 30, height: 30)
                                    Image("pencil-edit")
                                }
                            }
                        }
                        .padding(.leading, 13)
                        .padding(.trailing, 9)
                        .padding(.top, 9)
                        
                        Spacer()
                        
                        HStack {
                            Text("Sven LIC")
                                .semibold16
                                .foregroundColor(.white)
                            
                            Spacer()
                        }
                        .padding(5)
                        .background(Color.black.opacity(0.4))
                        
                    }
                    .cornerRadius(8)
                }
                
                Text("29-59 Northern Blvd, Long Island City, NY 11101")
                    .medium12
                    .foregroundColor(.black)
                
                Text("Unit 40F")
                    .regular12
                    .foregroundColor(.black)
                
                HStack(spacing: 10) {
                    smallImageWithText(img: "agent-views", text: "100")
                    smallImageWithText(img: "agent-saves", text: "20")
                    smallImageWithText(img: "applications", text: "10")
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        ZStack {
                            Circle()
                                .stroke(Color.purpleGradient.endColor,lineWidth: 1)
                                .frame(width: 40, height: 40)
                            
                            Image("qr_code_white")
                                .resizable()
                                .renderingMode(.template)
                                .foregroundColor(.purpleLow)
                                .frame(width: 20, height: 20)
                        }
                    }
                    
                    Button {
                        
                    } label: {
                        ZStack {
                            Circle()
                                .stroke(Color.purpleGradient.endColor,lineWidth: 1)
                                .frame(width: 40, height: 40)
                            Image("status-up")
                        }
                    }
                    
                    Button {
                        
                    } label: {
                        ZStack {
                            Circle()
                                .fill(Color.purpleGradient.toLinearGradient)
                                .frame(width: 40, height: 40)
                            Image("agent-chats")
                        }
                    }
                }
                
                HStack(spacing: 12) {
                    linkButton(title: "De-List Property") {
                        
                    }
                    linkButtonStroke(title: "View Applications") {
                        
                    }
                }
                .padding(.vertical,10)
            }
        }
        .padding(10)
        .roundedShadow()
    }
    
    func cellClosing() -> some View {
        VStack {
            VStack(alignment: .leading, spacing: 6) {
                ZStack {
                    
                   Image("testHouse")
                        .resizable()
                        .frame(maxWidth: .infinity,maxHeight: 170)
                    
                    
                    VStack {
                        HStack {
                            
                            Spacer()
                            
                            Button {
                                
                            } label: {
                                ZStack {
                                    Circle()
                                        .fill(Color.blue)
                                        .frame(width: 30, height: 30)
                                    Image("pencil-edit")
                                }
                            }
                        }
                        .padding(.leading, 13)
                        .padding(.trailing, 9)
                        .padding(.top, 9)
                        
                        Spacer()
                        
                        HStack {
                            Text("Sven LIC")
                                .semibold16
                                .foregroundColor(.white)
                            
                            Spacer()
                        }
                        .padding(5)
                        .background(Color.black.opacity(0.4))
                        
                    }
                    .cornerRadius(8)
                }
                
                Text("29-59 Northern Blvd, Long Island City, NY 11101")
                    .medium12
                    .foregroundColor(.black)
                
                Text("Unit 40F")
                    .regular12
                    .foregroundColor(.black)
                
                HStack(spacing: 10) {
                    smallImageWithTextNew(img: "beds", text: "Studio")
                    smallImageWithTextNew(img: "big_baths", text: "1 ba")
                    smallImageWithTextNew(img: "big_footage", text: "600 sqft")
                    
                    Spacer()
                    
                   
                    Button {
                        
                    } label: {
                        ZStack {
                            Circle()
                                .stroke(Color.purpleGradient.endColor,lineWidth: 1)
                                .frame(width: 40, height: 40)
                            Image("status-up")
                        }
                    }
                    
                    Button {
                        
                    } label: {
                        ZStack {
                            Circle()
                                .fill(Color.purpleGradient.toLinearGradient)
                                .frame(width: 40, height: 40)
                            Image("agent-chats")
                        }
                    }
                }
                
                VStack(alignment: .leading) {
                    LineView()
                    
                    Text("Tenants : John Doe")
                        .medium14
                    HStack {
                        Text("Outstanding Payment")
                            .regular12
                        
                        Spacer()
                        
                        Text("$0.00")
                            .semibold18
                            .foregroundColor(.darkBlue)
                    }
                    HStack {
                        smallImageWithTextNew(img: "calendar_light", text: "Lease End Date")
                        
                        Spacer()
                        
                        Text("30 Mar 2023")
                            .medium12
                        
                    }
                   
                    
                }
                
                HStack(spacing: 12) {
                    linkButton(title: "Send Lease Renewal") {
                        
                    }
                    linkButtonStroke(title: "Post Property") {
                        
                    }
                }
                .padding(.vertical,10)
            }
        }
        .padding(10)
        .roundedShadow()
    }
    
    func smallImageWithText(img: String, text: String)-> some View {
        HStack {
            HStack(spacing: 8) {
                Image(img)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 15, height: 15)
                Text(text)
                    .foregroundColor(.black)
                    .medium12
            }
        }
    }
    
    func smallImageWithTextNew(img: String, text: String)-> some View {
        HStack {
            HStack(spacing: 8) {
                Image(img)
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 15, height: 15)
                    .foregroundColor(.purpleLow)
                
                Text(text)
                    .foregroundColor(Color(hexString: "717171"))
                    .regular12
            }
        }
    }

//
    
    func linkButton(title: String,action: @escaping () -> Void) -> some View {
        
        Button(action: action) {
            ZStack {
                Color.blueGradient.toLinearGradient
                HStack {
//                    Image("qr_code_white")
//                        .resizable()
//                        .frame(width: 13,height: 13)
                    
                    Text(title)
                        .foregroundColor(.white)
                        .medium12
                }
            }
            .frame(height: 40)
            .cornerRadius(20)
        }
    }
    
    func linkButtonStroke(title: String,action: @escaping () -> Void) -> some View {
        
        Button(action: action) {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.blueGradient.startColor,lineWidth: 1)
                
                Text(title)
                    .foregroundColor(Color.blueGradient.startColor)
                    .medium12
                
            }
            .frame(height: 40)
            .frame(maxWidth: .infinity)
            .cornerRadius(20)
        }
    }
}

struct OwnerDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        OwnerDashboardView()
    }
}
