//
//  RenterFilterView_UI.swift
//  ReZemeUI
//
//  Created by Shakhzod on 28/04/23.
//

import SwiftUI

//MARK: - UI Components

extension RenterFilterView {
    
    func filterHeaderView(deselectAction action: @escaping EmptyClosure) -> some View {
        HStack {
            
            Text("Filter by")
                .foregroundColor(.black)
                .semibold18
            
            Spacer()
            
            Text("Deselect All")
                .semibold14
                .foregroundColor(.secondaryPurple)
                .makeButton(action: action)
        }
    }
    
    func textFieldUI(text: Binding<String>, placeHolder: String = "Search by keyword...") -> some View {
        TextField(placeHolder, text: text)
            .autocorrectionDisabled()
            .padding(.horizontal, 16)
            .padding(.vertical,13)
            .frame(height: 48)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .strokeBorder(Color.textGray.opacity(0.2), lineWidth: 1)
            )
    }
    
    func easyApplyPropertyHeader<Content: View>(@ViewBuilder content: ()-> Content) -> some View {
        ZStack(alignment: .topTrailing) {
            
            VStack(alignment: .leading, spacing: 0) {
                
                HStack(spacing: 0) {
                    Image(systemName: "checkmark.square")
                        .resizable()
                        .scaledToFill()
                        .foregroundColor(.secondaryPurple)
                        .font(.title.weight(.light))
                        .frame(width: 20, height: 20)
                    
                    Text("Easy Apply Properties")
                        .medium16
                        .padding(.leading,8)
                    
                    Image(systemName: "exclamationmark.circle")
                        .resizable()
                        .scaledToFill()
                        .foregroundColor(.secondaryPurple)
                        .font(.title.weight(.light))
                        .frame(width: 24, height: 24)
                        .padding(.leading, 2)
                        .makeButton {
                            withAnimation {
                                easyApplyTipShow.toggle()
                            }
                        }
                    
                    Spacer()
                }
                
                
                content()
            }
            
            if easyApplyTipShow {
                
                Text("Filters for properties that require the least documentation and our most streamlined process")
                    .regular14
                    .padding(7)
                    .frame(width: 163)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .strokeBorder(Color.secondaryPurple)
                    )
                    .background(Color.white)
                    .padding(.top,30)
            }
        }
    }
    
    func selectableGrid(dictionary: [Dictionary<String, Bool>.Element], selectedAction: @escaping (String)-> Void) -> some View {
        HStack(spacing: 7) {
            
            ForEach(dictionary, id: \.key) { bedroom in
                let (key, isActive) = bedroom
                
                Text(key)
                    .medium16
                    .foregroundColor(.black)
                    .padding(.vertical,10)
                    .frame(maxWidth: .infinity)
                    .roundedShadow(shadowRadius: 10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .strokeBorder(Color.secondaryPurple, lineWidth: 1)
                            .opacity(isActive ? 1:0)
                    )
                    .makeButton { selectedAction(key) }
            }
        }
    }
    
    func monthlyRentView() -> some View {
        HeaderWithImageTitleTip(
            image: "wallet",
            title: "Monthly Rent Range") {
                
                VStack(spacing:0) {
                    
                    HStack {
                        Spacer()
                        
                        Text("$1,200 -$ 1,800")
                            .regular14
                    }
                    
                    ZStack {
                        
                        Capsule()
                            .fill(Color.secondaryPurple.opacity(0.2))
                            .frame(height: 7)
                        
                        HStack(spacing: 0) {
                            Circle()
                                .fill(Color.secondaryPurple)
                                .padding(1)
                                .background(
                                    Circle()
                                        .fill(Color.white)
                                )
                                .frame(width: 16, height: 16)
                            
                            Rectangle()
                                .fill(Color.secondaryPurple)
                                .frame(width: 96, height: 7)
                            
                            
                            Circle()
                                .fill(Color.secondaryPurple)
                                .padding(1)
                                .background(
                                    Circle()
                                        .fill(Color.white)
                                )
                                .frame(width: 16, height: 16)
                        }
                        
                    }
                    
                    HStack {
                        Text(formatMoney(value: 0))
                            .regular14
                            .foregroundColor(.textGray.opacity(0.5))
                        
                        Spacer()
                        
                        Text(formatMoney(value: 10_000))
                            .regular14
                            .foregroundColor(.textGray.opacity(0.5))
                    }
                }
            }
            .padding(.top, 24)
    }
    
    func bedroomsView() -> some View {
        HeaderWithImageTitleTip(
            image: "bedroomNew",
            title: "Bedrooms") {
                
                selectableGrid(
                    dictionary: viewModel.bedroomsFilterValues.sorted(by: { $0.key < $1.key })
                ) { key in
                    viewModel.bedroomChangeValue(by: key)
                }
                .padding(.top, 8)
                
            }
            .padding(.top, 26)
    }
    
    func bathroomsView() -> some View {
        HeaderWithImageTitleTip(
            image: "bathroomNew",
            title: "Bathroom") {
                
                selectableGrid(
                    dictionary: viewModel.bathroomsFilterValues.sorted(by: { $0.key < $1.key })
                ) { key in
                    viewModel.bathroomChangeValue(by: key)
                }
                .padding(.top, 8)
                
            }
            .padding(.top, 23)
    }
    
    func upfrontTextField(text: Binding<String>) -> some View {
        TextField("$400", text: text)
            .autocorrectionDisabled()
            .padding(.horizontal, 16)
            .padding(.vertical,13)
            .frame(height: 48)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .strokeBorder(Color.textGray.opacity(0.2), lineWidth: 1)
            )
    }
    
    func totalMonthlyTextField(text: Binding<String>) -> some View {
        HeaderWithImageTitleTip(
            image: "wallet",
            title: "Est. Total Monthly Cost",
            tipStr: "Includes estimates for ongoing costs rent + utilities and fees not covered by the landlord."
        ) {
            
            upfrontTextField(text: text)
                .padding(.top,4)
            
        }
    }
    
    func amenitiesView(models: [Dictionary<String, Bool>.Element], pressedItem: @escaping (String) -> Void) -> some View {
        return HeaderWithImageTitleTip(image: "share", title: "Amenities") {
            
            LazyVGrid(
                columns: [
                    GridItem(.flexible(), spacing: 20, alignment: .leading),
                    GridItem(.flexible(), spacing: 20, alignment: .leading)
                ]
            ) {
                ForEach(models, id: \.key) { value in
                    let (key, isActive) = value
                    HStack(spacing: 8) {
                        
                        Image(systemName: "\(isActive ? "checkmark." : "")square")
                            .resizable()
                            .scaledToFill()
                            .font(.title.weight(.light))
                            .foregroundColor(isActive ? .secondaryPurple : .textGray.opacity(0.25))
                            .frame(width: 20, height: 20)
                        
                        Text(key)
                            .medium16
                            .foregroundColor(.black)
                            .fixedSize(horizontal: false, vertical: true)
                            .multilineTextAlignment(.leading)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .makeButton { pressedItem(key) }
                    
                }
                
            }
            .padding(.top, 11)
            
        }
    }
    
    func squareFootageView() -> some View {
        HeaderWithImageTitleTip(
            image: "vector",
            title: "Square Footage") {
                
                VStack(spacing:0) {
                    
                    HStack {
                        Spacer()
                        
                        Text("$1,200 -$ 1,800")
                            .regular14
                    }
                    
                    ZStack {
                        
                        Capsule()
                            .fill(Color.secondaryPurple.opacity(0.2))
                            .frame(height: 7)
                        
                        HStack(spacing: 0) {
                            Circle()
                                .fill(Color.secondaryPurple)
                                .padding(1)
                                .background(
                                    Circle()
                                        .fill(Color.white)
                                )
                                .frame(width: 16, height: 16)
                            
                            Rectangle()
                                .fill(Color.secondaryPurple)
                                .frame(width: 96, height: 7)
                            
                            
                            Circle()
                                .fill(Color.secondaryPurple)
                                .padding(1)
                                .background(
                                    Circle()
                                        .fill(Color.white)
                                )
                                .frame(width: 16, height: 16)
                        }
                        
                    }
                    
                    HStack {
                        Spacer()
                        
                        Text(formatMoney(value: 25_000))
                            .regular14
                            .foregroundColor(.textGray.opacity(0.5))
                    }
                }
            }
            .padding(.top, 24)
    }
    
    func moveInDateView(date: Binding<String>) -> some View {
        HeaderWithImageTitleTip(
            image: "calendar",
            title: "Move-In Date") {
                
                textFieldUI(text: date, placeHolder: "DD/MM/YYY")
                    .padding(.top, 13)
            }
    }
    
    func timeToWorkView(timeCount: Binding<Int>) -> some View {
        HeaderWithImageTitleTip(image: "clock", title: "Time to Work") {
            TimePickerUI(time: timeCount)
                .padding(.top,11)
        }
    }
    
    func appleButton(action: @escaping EmptyClosure) -> some View {
        ActionButton("Apply", action: action)
            .padding(.horizontal, 55)
    }
}
