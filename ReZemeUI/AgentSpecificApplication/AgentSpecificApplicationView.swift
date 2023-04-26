//
//  AgentSpecificApplicationView.swift
//  ReZemeUI
//
//  Created by Davron_Usmanov on 24.04.2023.
//

import SwiftUI

struct AgentSpecificApplicationView: View {
    
    var grid: [GridItem] = [
        GridItem(.flexible(), spacing: 80 , alignment: .leading),
        GridItem(.flexible(), spacing: 80 , alignment: .leading)
    ]
    @State var isActive: Bool = false
    
    @State var income: Bool = false
    @State var properyApplication: Bool = false
    
    var topTitleArray: [String] = ["Laundromat", "Gym","Doorman", "Dog-110 lbs"]
    
    var topiconArray: [String] = ["clearmashine", "gym", "polisman", "pet" ]
    
    var titleArray: [String] = [
        "Plaid Verified Bank Statements",
        "Paystubs",
        "W2 Forms",
        "Bank Statements",
        "Credit Report"
    ]
    
    var iconArray: [String] = [
        "bank_ic",
        "money-send",
        "document_ic",
        "bank_ic",
        "speed_ic"
    ]
    
    var users: [String] = [
        "Robert",
        "Lisa"
    ]
    
    var body: some View {
        CustomNavBar(
            content: {
                ZStack(alignment: .bottom) {
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        VStack(alignment: .leading,spacing: 0) {

                            topView()
                            
                            ForEach((0..<users.count), id:\.self) { index in
                                ExpandingCellForApp(
                                    text: "Applicant #\(index+1) • \(users[index])",
                                    views: [
                                        cellView()
                                    ]
                                )
                                .padding(.bottom,20)
                            }
                            .padding(.horizontal,20)
                        }
                        .padding(.bottom,100)
                    }
                    
                    if properyApplication {
                        RoundedRectangle(cornerRadius: 0)
                            .fill(Color.white)
                            .frame(height: 150)
                            .overlay(
                                VStack(spacing: 17) {
                                    
                                    linkButton(title: "View Property Application",type: .RENTER) {
                                        properyApplication.toggle()
                                    }
                                    .frame(height: 45)
                                    HStack(spacing: 16) {
                                        
                                        linkButton(title: "Deny", stoke: true) {
                                            properyApplication.toggle()
                                        }
                                        linkButton(title: "Accept",type: .AGENT) {
                                            properyApplication.toggle()
                                        }
                                    }
                                }
                                    .padding(EdgeInsets(top: 25, leading: 45, bottom: 18, trailing: 45))
                            )
                    }
                }
            },
            title: "Application #1",
            style: .newTitleAndIcon,
            type: .agent
        )
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarHidden(true)
    }
}


extension AgentSpecificApplicationView {
    
    func topView() -> some View {
        ZStack {
            VStack(alignment: .leading) {
                Image("testHouse")
                    .resizable()
                    .frame(height: 172)
                    .scaledToFill()
                    .overlay (
                        VStack {
                            HStack {
                                Spacer()
                            }
                            .padding(.leading, 13)
                            .padding(.trailing, 9)
                            .padding(.top, 9)
                            
                            Spacer()
                            
                            ItemImageBottomTextView(
                                firstText: "Oriana",
                                secondText: "$3,894/mo"
                            )
                        }
                    )
                
                HStack {
                    Image("pin")
                        .renderingMode(.template)
                        .frame(width: 12, height: 12)
                        .padding(.horizontal,6)
                        .padding(.vertical,13)
                        .foregroundColor(Color.blue)
                    Text("420 E 54th St, New York, NY 10022")
                        .medium12
                }
            }
            .padding(10)
        }
        .background(Color.white)
        .cornerRadius(8)
        .shadowCustom()
        .padding(20)
    }
    
    func cellView() -> some View {
        VStack(alignment: .leading, spacing: 15) {
            
            Text("Applicant priorities")
                .regular12
            
            LazyVGrid(columns: grid, spacing: 14) {
                ForEach(0..<titleArray.count-1,id: \.self) { index in
                    HStack {
                        Image(topiconArray[index])
                            .renderingMode(.template)
                            .frame(width: 20, height: 20)
                            .foregroundColor(Color.blue)
                        Text(topTitleArray[index])
                            .regular14
                    }
                }
            }
            
            
            
            sliderView(title: "Income", subtitle: "Min. Income: $155k ", agent: true)
                .frame(maxWidth: .infinity)
            
            LineView()
                .opacity(0.7)
                .padding(.vertical,0)
        
            sliderView(title: "Credit Score", subtitle: "Min. Score: 720", agent: false)
            
            
            
            VStack(alignment: .leading, spacing: 0) {
                
                HStack(spacing: 54) {
                    Button {
                        income.toggle()
                    } label: {
                        VStack(alignment: .leading,spacing: 0) {
                            Text("Income")
                                .semibold14
                                .foregroundColor(.darkBlue)
                            
                            RoundedRectangle(cornerRadius: 1.5)
                                .fill(Color.darkBlue)
                                .frame(width: 16, height: 3)
                                .opacity(!income ? 1 : 0)
                        }
                    }

                    Button {
                        income.toggle()
                    } label: {
                        VStack(alignment: .leading,spacing: 0) {
                            Text("Balance")
                                .semibold14
                                .foregroundColor(.darkBlue)
                            
                            RoundedRectangle(cornerRadius: 1.5)
                                .fill(Color.darkBlue)
                                .frame(width: 16, height: 3)
                                .opacity(income ? 1 : 0)
                        }
                    }
                }
                .padding(.leading,10)
                
                HomeChart(data: [121,55,98,52,88,87,65,44,67,22,65,88,45])
                    .frame(height: 200)
                    .offset(x:-10,y: -10)
            }
            
            LineView()
                .opacity(0.7)
                .padding(.vertical,0)
            
            VStack(spacing: 10) {
                dropdownCell(text: "Documents Submitted")
                
                if isActive {
                    VStack(spacing: 10) {
                        ForEach(0..<titleArray.count, id: \.self) { id in
                            dropcell(title: titleArray[id], image: iconArray[id])
                        }
                    }
                }
            }
            
            linkButton(title: "Message Applicant", stoke: true) {
                properyApplication.toggle()
            }
            .padding(.horizontal,25)
            .padding(.bottom,20)
        }
    }
    
    func sliderView(title: String, subtitle:String, agent: Bool) -> some View {
        VStack {
            HStack {
                VStack(alignment: .leading,spacing: 0) {
                    
                    Text(title)
                        .semibold16
                        .foregroundColor(.black)
                    
                    Text(subtitle)
                        .medium12
                        .foregroundColor(agent ? .purpleLow : .darkBlue)
                }
                
                Spacer()
                
                HStack {
                    Image("tick-square")
                        .renderingMode(.template)
                        .frame(width: 15, height: 15)
                        .foregroundColor(agent ? .darkBlue : .purpleLow )
                    
                    Text("In range")
                        .regular14
                        .foregroundColor(agent ? .darkBlue : .purpleLow )
                }
                .padding(6)
                .background(agent ? Color.darkBlue.opacity(0.1) : Color.purpleLow.opacity(0.1))
                .cornerRadius(8)
            }
            
            VStack {
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 3)
                        .fill(agent ? Color.darkBlue : Color.purpleLow)
                        .frame(maxWidth: 250, maxHeight: 6)
                    
                    RoundedRectangle(cornerRadius: 3)
                        .fill(agent ? Color.darkBlue.opacity(0.1) : Color.purpleLow.opacity(0.1))
                        .frame(maxWidth: .infinity, maxHeight: 6)
                        
                    
                    Circle()
                        .fill(Color.white)
                        .frame(width: 20,height: 20)
                        .offset(x: 250)
                        .overlay (
                            Circle()
                                .fill(agent ? Color.darkBlue : Color.purpleLow)
                                .frame(width: 17,height: 17)
                                .offset(x: 250)
                        )
                       
                    RoundedRectangle(cornerRadius: 6)
                        .fill(agent ? Color.purpleLow : Color.darkBlue)
                        .frame(width: 15, height: 3)
                        .rotationEffect(.degrees(90))
                        .offset(x: 200)
                        
                }
                
                HStack(spacing: 30) {
                    Text("720")
                        .foregroundColor(.purpleLow)
                        .medium12
                    
                    Text("740")
                        .foregroundColor(.darkBlue)
                        .medium12
                }
                .offset(x: 80)
            }
        }
        .padding(10)
        .background(agent ? Color.darkBlue.opacity(0.05) : Color.purpleLow.opacity(0.05))
        .cornerRadius(8)
    }
    
    func linkButton(title: String,type:AccountType = .AGENT,stoke: Bool = false ,action: @escaping () -> Void) -> some View {
        
        Button(action: action) {
            ZStack {
                
                if stoke {
                    RoundedRectangle(cornerRadius: 23)
                        .stroke(Color.purpleLow,lineWidth: 1)
                        .frame(height: 45)
                        .overlay (
                            Text(title)
                                .foregroundColor(.purpleLow)
                                .semibold16
                        )
                } else {
                    RoundedRectangle(cornerRadius: 23)
                        .fill(type == .AGENT ? Color.purpleGradient.toLinearGradient : Color.blueGradient.toLinearGradient)
                        .frame(height: 45)
                        .overlay (
                            Text(title)
                                .foregroundColor(.white)
                                .semibold16
                        )
                }
            }
            
        }
    }
    
    func dropdownCell(text: String)-> some View {
        Button {
            withAnimation {
                isActive.toggle()
            }
        } label: {
            HStack(spacing: 17) {
                
                Text(text)
                    .semibold16
                    .foregroundColor(Color.darkBlue)
                    .multilineTextAlignment(.leading)
                    .padding(10)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.purpleLow)
                    .frame(width: 19, height: 12)
                    .rotationEffect(.degrees(isActive ? 90:0))
                    .background(
                    Circle()
                        .fill(Color.purpleLow.opacity(0.1))
                        .frame(width: 30,height: 30)
                        
                    )
            }
            .frame(minHeight: 52)
        }
    }
    
    func dropcell(title: String, image: String)-> some View {
        Button {
            
        } label: {
            HStack(spacing: 12) {
                Image(image)
                    .resizable()
                    .renderingMode(.template)
                    .scaledToFit()
                    .foregroundColor(Color.darkBlue)
                    .padding(15)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.darkBlue.opacity(0.1))
                    )
                    .frame(width: 52, height: 52)
                
                
                Text(title)
                    .medium16
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.purpleLow)
                    .frame(width: 19, height: 12)
                    .background(
                    Circle()
                        .fill(Color.purpleLow.opacity(0.1))
                        .frame(width: 30,height: 30)
                        
                    )
            }
            .frame(minHeight: 52)
        }

        
    }
}


struct AgentSpecificApplicationView_Previews: PreviewProvider {
    static var previews: some View {
        AgentSpecificApplicationView()
    }
}


