//
//  MyHomeView.swift
//  ReZemeUI
//
//  Created by Shakhzod on 04/05/23.
//

import SwiftUI

struct MyHomeView: View {
    
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
    private let payStatus = PayStateType.allCases
    @State var showTips = 9999
    private let priceTitle = ["Paid","Overdue"]
    private let priceStr = ["$40,735.84","$119.96"]
    @State var searchText = ""
    private var originalPaymentHistory = paymentMockData
    @State var listHistory: [PaymentModel] = paymentMockData
    
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                
                ToggleUI(titles: ["Manage My Home", "Applications"]) { _ in }
                    .padding(.top, 27)
                    .padding(.horizontal, 20)
                
                VStack(spacing: 0) {

                    imageUI(name: "Sven LIC", image: UIImage(named: "mockHomeImage")!)

                    ZStack(alignment: .top) {
                        VStack(spacing:0) {
                            subtitlesUI()
                                .padding(.top, 11)

                            leaseTermsLabel()
                                .padding(.top,15)

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

                        }
                        .padding(.top, 60)
                    }

                    priceUI()

                    ActionButton("Make Payment")
                        .padding(.top, 30)

                    HStack(spacing: 4) {

                        Button(action: {}) {
                            Text("View  Documents")
                                .foregroundColor(.white)
                                .semibold14
                                .frame(height: 60)
                                .frame(maxWidth: .infinity)
                                .background(
                                    Capsule()
                                        .fill(Color.blueGradient.toLinearGradient)
                                )
                        }

                        Button(action: {}) {
                            Text("Service Requests")
                                .foregroundColor(Color.darkBlue)
                                .semibold14
                                .frame(height: 60)
                                .frame(maxWidth: .infinity)
                                .background(
                                    Capsule()
                                        .strokeBorder(Color.darkBlue)
                                )
                        }
                    }
                    .padding(.top, 16)

                }
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 24, trailing: 10))
                .roundedShadowNew()
                .padding(.horizontal, 20)
                .padding(.top, 17)
                
                
                searchTransactionsUI(searchText: $searchText)
                    .padding(.top, 19)
                    .padding(.horizontal, 20)
                
                paymentHistoryList(list: $listHistory)
                    .padding(.top, 16)
            }
            
            .onChange(of: searchText) { newValue in
                if newValue.isEmpty {
                    listHistory = originalPaymentHistory
                } else {
                    listHistory = originalPaymentHistory.filter({ $0.name.uppercased().contains(searchText.uppercased()) })
                }
            }
        }
        .onTapGesture {
            dismissKeyboard()
            showTips = 999
        }
        .navigationRenter(
            title: "My Hoem",
            rightButton: navBarButton {
                //TODO: - Nav Bar Profile Button action
            }
        )
    }
}

//MARK: - UI
extension MyHomeView {
    
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
            
            chatButton {}
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
        Text("Lease Terms: 12 Months")
            .foregroundColor(.secondaryPurple)
            .medium12
            .frame(height: 31)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.secondaryPurple.opacity(0.1))
            )
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
    
    private func searchTransactionsUI(searchText: Binding<String>) -> some View {
        HStack(spacing: 7) {
            
            Image("search_")
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .foregroundColor(.black)
                .frame(width: 18, height: 18)
            
            TextField("Search transactions...", text: searchText)
                .autocorrectionDisabled()
                .regular14
            
            Spacer()
            
            Button(action: {}) {
                Text("All")
                    .regular14
                    .foregroundColor(.black)
                
                Image(systemName: "chevron.down")
                    .foregroundColor(.black)
            }
            
        }
        .padding(.horizontal,14)
        .frame(height: 50)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .strokeBorder(Color.textGray.opacity(0.2))
        )
    }
    
    private func paymentHistoryList(list: Binding<[PaymentModel]>) -> some View {
            VStack(spacing: 20) {
                ForEach((0..<list.wrappedValue.count), id: \.self) { index in
                    
                    paymentHistoryItem(model: list.wrappedValue[index])
                        .padding(.horizontal, 20)
                    
                }
            }
    }
    
    private func paymentHistoryItem(model: PaymentModel) -> some View {
        VStack(spacing: 5) {
            HStack {
                
                Text(model.name)
                    .medium16
                    
                Spacer()
                
                Text("\(model.date, formatter: dateFormatterMockData)")
                    .medium12
                    .foregroundColor(.textGray)
            }
            
            HStack(spacing:4) {
                
                Text(model.price)
                    .semibold14
                    .foregroundColor(.secondaryPurple)
                
                Spacer()
                
                Image(model.state.iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 16, height: 16)
                
                Text(model.state.description)
                    .medium12
            }
        }
        .padding(.vertical, 14)
        .padding(.horizontal, 16)
        .roundedShadow()
    }
}

struct MyHomeView_Previews: PreviewProvider {
    static var previews: some View {
        MyHomeView()
    }
}



let dateFormatterMockData: DateFormatter = {
    var formate = DateFormatter()
    formate.dateFormat = "dd MMM yyyy"
    return formate
}()


let paymentMockData: [PaymentModel] = [
    PaymentModel(name: "Rent January", price: "$530.00", state: .onTime, date: dateFormatterMockData.date(from: "01 May 2023")!),
    PaymentModel(name: "Rent February", price: "$400.00", state: .late, date: dateFormatterMockData.date(from: "05 May 2023")!),
    PaymentModel(name: "Rent March", price: "$700.00", state: .tooLate, date: dateFormatterMockData.date(from: "10 May 2023")!),
    PaymentModel(name: "Invoice for General Expense", price: "$300.00", state: .onTime, date: dateFormatterMockData.date(from: "30 Apr 2023")!),
    PaymentModel(name: "Rent April", price: "$400.00", state: .pending, date: dateFormatterMockData.date(from: "15 Apr 2023")!)
]
