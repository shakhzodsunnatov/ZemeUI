//
//  TenantDetailsOwner.swift
//  ReZemeUI
//
//  Created by Shakhzod on 04/05/23.
//

import SwiftUI

struct TenantDetailsOwner: View {
    
    private let icons: [String] = [
        "big-beds",
        "big_baths",
        "big_footage"
    ]
    private let iconNames = [
        "Studio",
        "1 ba",
        "600 sqft"
    ]
    private let dates = [
        "Jan",
        "Feb",
        "Mar",
        "Apr",
        "May"
    ]
    private let leaseTitles = [
        "Lease Term",
        "Lease Start",
        "Lease End"
    ]
    private let leaseDates = [
        "12 Months",
        "14 Mar 2023",
        "30 Mar 2023"
    ]
    private let payStatus = PayStateType.allCases
    @State var showTips = 9999
    private let priceTitle = ["Paid","Overdue"]
    private let priceStr = ["$40,735.84","$119.96"]
    @State var assignButtonActive = false
    
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                
                profileUI()
                    .padding([.horizontal, .top], 20)
                
                VStack(spacing: 0) {
                    
                    imageUI(name: "Sven LIC", image: UIImage(named: "mockHomeImage")!)
                    
                    ZStack(alignment: .top) {
                        VStack(spacing:0) {
                            subtitlesUI()
                                .padding(.top, 11)
                            
                            leaseTermsLabel()
                                .padding(.top,15)
                            
                            leaseItems()
                                .padding(.top, 15)
                        }
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            
                            HStack(spacing: -10) {
                                
                                ForEach((0..<dates.count), id: \.self) { index in
                                    
                                    
                                    ZStack(alignment: .top) {
                                        
                                        VStack(spacing: 4) {
                                            
                                            HStack(alignment: .top, spacing: 4) {
                                                Text(dates[index])
                                                    .medium12
                                                    .foregroundColor(.blue)
                                                
                                                Button {
                                                    self.showTips = index
                                                } label: {
                                                    Image(systemName: "exclamationmark.circle")
                                                        .resizable()
                                                        .scaledToFit()
                                                        .foregroundColor(.secondaryPurple)
                                                        .frame(width: 11, height: 11)
                                                }
                                                
                                            }
                                            
                                            Image(payStatus[index].iconName)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 16, height: 16)
                                            
                                            Text(payStatus[index].description)
                                                .regular11
                                        }
                                        .padding(5)
                                        .roundedShadowNew()
                                        .padding(.top, 50)
                                        
                                        Text("Within 1-10 days late")
                                            .regular11
                                            .fixedSize(horizontal: false, vertical: true)
                                            .frame(width: 74, height: 47)
                                            .background(
                                                RoundedRectangle(cornerRadius: 8)
                                                    .fill(Color.white)
                                            )
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 8)
                                                    .strokeBorder(Color.secondaryPurple)
                                            )
                                            .opacity(showTips == index ? 1:0)
                                            .animation(.easeInOut)
                                    }
                                    
                                }
                                
                            }
                            .padding(.vertical, 10)
                            .padding(.bottom, 7)
                            
                        }
                        .padding(.top, 300)
                    }
                    
                    priceUI()
                    
                }
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 24, trailing: 10))
                .roundedShadowNew()
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
                
                transactionsHeader()
                    .padding(.top, 22)
                    .padding(.horizontal, 20)
                
                paymentHistoryList()
                    .padding(.top, 15)
            }
            
        }
        .navigationOwner(title: "Tenant Details")
        .onTapGesture {
            showTips = 999
        }
    }
}

//MARK: - UI Components

extension TenantDetailsOwner {
    
    private func profileUI() -> some View {
        HStack(spacing: 14) {
            
            Image(systemName: "person.fill")
                .resizable()
                .scaledToFit()
                .foregroundColor(.secondaryPurple)
                .padding(12)
                .frame(width: 54, height: 54)
                .background(
                    Circle()
                        .fill(Color.secondaryPurple.opacity(0.2))
                )
            
            VStack(alignment: .leading, spacing: 0) {
                
                Text("Elior Alayev")
                    .semibold16
                    .foregroundColor(.black)
                
                Text(verbatim: "alayev.elior@gmail.com")
                    .regular11
                    .foregroundColor(.textGray)
                    .padding(.top, 2)
                
                Text("+1 917-770-7717")
                    .regular11
                    .foregroundColor(.blue)
                    .padding(.top, 6)
                
            }
            
            Spacer()
            
            Image("chat_ic")
                .resizable()
                .scaledToFit()
                .padding(11)
                .frame(width: 42, height: 42)
                .background(
                    Circle()
                        .fill(Color.blueGradient.toLinearGradient)
                )
                .makeButton {}
        }
        .padding(EdgeInsets(top: 16, leading: 20, bottom: 12, trailing: 23))
        .roundedShadow()
    }
    
    private func navBarButton(action: @escaping ()->Void) -> AnyView {
        AnyView(
            ZStack {
                Image("profile-agent")
                    .resizable()
                    .scaledToFill()
                    .padding(15)
                    .frame(width: 50, height: 50)
                    .roundedShadow(cornerRadius: 16)
                
                
            }.makeButton(action: action)
        )
    }
    
    private func imageUI(name: String, image: UIImage) -> some View {
        ZStack(alignment: .bottom) {
            
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
        }
        .frame(height: 172)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
    
    private func subtitlesUI() -> some View {
        HStack(spacing: 7) {
            
            VStack(alignment: .leading, spacing: 12) {
                Text("29-59 Northern Blvd, Long Island City, NY 11101")
                    .medium12
                    .foregroundColor(.black)
                
                HStack(spacing: 22) {
                    ForEach((0..<icons.count), id: \.self) { index in
                        HStack(spacing:6) {
                            Image(icons[index])
                                .resizable()
                                .scaledToFit()
                                .frame(width: 22, height: 22)
                            
                            Text(iconNames[index])
                                .regular12
                                .foregroundColor(.textGray)
                        }
                    }
                }
            }
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private func chatButton(action: @escaping EmptyClosure) -> some View {
        Button(action: action) {
            ZStack(alignment: .topTrailing) {
                Image("chat_ic")
                    .resizable()
                    .scaledToFit()
                    .padding(11)
                    .frame(width: 49, height: 43)
                    .background(
                        Circle()
                            .fill(Color.blueGradient.toLinearGradient)
                    )
                
                Image(systemName: "1.circle")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.white)
                    .background(
                        Circle()
                            .fill(Color.secondaryPurple)
                    )
                    .frame(width: 20, height: 20)
                    .offset(y: -5)
            }
        }
    }
    
    private func leaseTermsLabel() -> some View {
        VStack(spacing: 16) {
            
            HStack(spacing: 4) {
                
                Text("Request Money")
                    .semibold16
                    .foregroundColor(.white)
                    .frame(height: 45)
                    .frame(maxWidth: .infinity)
                    .background(
                        Capsule()
                            .fill(Color.secondaryPurple)
                    )
                    .makeButton {}
                
                Text("Refund Money")
                    .semibold16
                    .foregroundColor(.secondaryPurple)
                    .frame(height: 45)
                    .frame(maxWidth: .infinity)
                    .background(
                        Capsule()
                            .strokeBorder(Color.secondaryPurple)
                    )
                    .makeButton {}
                
            }
            
            HStack(spacing: 4) {
                
                Text("View  Documents")
                    .semibold16
                    .foregroundColor(.white)
                    .frame(height: 45)
                    .frame(maxWidth: .infinity)
                    .background(
                        Capsule()
                            .fill(Color.blueGradient.toLinearGradient)
                    )
                    .makeButton {}
                
                ZStack(alignment: .topTrailing) {
                    Text("Service Requests")
                        .semibold16
                        .foregroundColor(.darkBlue)
                        .frame(height: 45)
                        .frame(maxWidth: .infinity)
                        .background(
                            Capsule()
                                .strokeBorder(Color.darkBlue)
                        )
                    
                    Image(systemName: "3.circle.fill")
                        .resizable()
                        .foregroundColor(.secondaryPurple)
                        .frame(width: 21, height: 21)
                        .background(
                            Circle()
                                .fill(Color.white)
                        )
                        .offset(x:5, y:-5)
                }
                .makeButton {}
                
            }
            
            
            if assignButtonActive {
                
                Button {
                    assignButtonActive = false
                } label: {
                    HStack(spacing:9) {
                        Image(systemName: "checkmark.circle")
                            .resizable()
                            .scaledToFill()
                            .foregroundColor(.darkBlue)
                            .frame(width: 26, height: 26)
                        
                        Text("Assigned to Melissa Smith")
                            .semibold18
                            .foregroundColor(.darkBlue)
                    }
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .background(
                        Capsule()
                            .fill(Color.darkBlue.opacity(0.2))
                    )
                }
                .padding(.top, 2)
                
            } else {
                ActionButton("Assign to Agent", action: {
                    assignButtonActive = true
                })
                .padding(.top, 2)
            }
            
            LineView()
                .padding(.horizontal,20)
                .padding(.top,5)
        }
    }
    
    private func leaseItems() -> some View {
        HStack(spacing:20) {
            
            ForEach((0..<leaseTitles.count), id: \.self) { index in
            
                VStack(alignment: .trailing, spacing: 7) {
                    
                    HStack(spacing:7) {
                        
                        Image(index != 0 ? "calendar":"document-text")
                            .resizable()
                            .frame(width: 16, height: 16)
                        
                        Text(leaseTitles[index])
                            .regular12
                            .foregroundColor(.textGray)
                    }
                    
                    Text(leaseDates[index])
                        .medium12
                }
            }
        }
    }
    
    private func priceUI() -> some View {
        VStack(spacing: 0) {
            
            HStack {
                
                Text("Outstanding")
                    .regular14
                
                Spacer()
                
                Text("$1,119.96")
                    .semibold16
            }
            
            ForEach((0..<priceTitle.count), id: \.self) { index in
                
                LineView()
                    .padding(.vertical, 14)
                
                HStack {
                    
                    Text(priceTitle[index])
                        .regular14
                    
                    Spacer()
                    
                    Text(priceStr[index])
                        .medium12
                }
                
            }
            
        }
        .padding(EdgeInsets(top: 13, leading: 16, bottom: 14, trailing: 16))
        .roundedShadow()
    }
    
    private func transactionsHeader() -> some View {
        HStack(spacing: 7) {
            
            Text("Transactions")
                .semibold18
            
            Spacer()
            
            Button(action: {}) {
                Image(systemName: "plus.circle")
                    .resizable()
                    .scaledToFill()
                    .foregroundColor(.darkBlue)
                    .frame(width: 30, height: 30)
            }
            
        }
    }
    
    private func paymentHistoryList() -> some View {
        VStack(spacing: 20) {
            ForEach((0..<3), id: \.self) { index in
                
                paymentHistoryItem()
                    .padding(.horizontal, 20)
                
            }
        }
    }
    
    private func paymentHistoryItem() -> some View {
        VStack(spacing: 5) {
            HStack {
                
                Text("Elior Alayev")
                    .medium16
                
                Spacer()
                
                Text("15 Mar 2023")
                    .medium12
                    .foregroundColor(.textGray)
            }
            
            HStack(spacing:4) {
                
                Text("Rent")
                    .medium12
                
                Spacer()
                
                Text("+$1,000.00")
                    .semibold14
                    .foregroundColor(.secondaryPurple)
                
            }
        }
        .padding(.vertical, 14)
        .padding(.horizontal, 16)
        .roundedShadow()
    }
}

struct TenantDetailsOwner_Previews: PreviewProvider {
    static var previews: some View {
        TenantDetailsOwner()
    }
}
