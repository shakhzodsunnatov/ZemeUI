//
//  PayForLease.swift
//  ReZemeUI
//
//  Created by Davron_Usmanov on 30.04.2023.
//

import SwiftUI

struct PayForLease: View {
    
    var grid: [GridItem] = [
        GridItem(.flexible(), spacing: 20 , alignment: .leading),
        GridItem(.flexible(), spacing: 20 , alignment: .leading)
    ]
    
    let fistArray: [AgentProStatisticDM] = [
        .init(icon: "eye", title: "200", subtitle: "Total Views"),
        .init(icon: "heart", title: "200", subtitle: "Total Saves")
    ]
    
    @State var cardHolder: String = ""
    @State var cardnumber: String = ""
    @State var exp: String = ""
    @State var cvv: String = ""
    @State var street: String = ""
    @State var city: String = ""
    @State var state: String = ""
    @State var country: String = ""
    @State var zip: String = ""
    
    var body: some View {
        
        ScrollView(.vertical,showsIndicators: false) {
            VStack(alignment: .leading, spacing: 16) {
                
                VStack(spacing: 11) {
                    HStack {
                        Text("Rent (15 Mar, 2023)")
                            .medium14
                        
                        Spacer()
                        
                        Text("$1,119.96")
                            .medium14
                    }
                    HStack {
                        Text("Late Fee")
                            .medium14
                        
                        Spacer()
                        
                        Text("$250.00")
                            .medium14
                    }
                    
                    LineView()
                        .padding(.vertical,0)
                    
                    HStack {
                        Text("Total")
                            .semibold14
                        
                        Spacer()
                        
                        Text("$1,369.96")
                            .semibold14
                    }
                }
                .padding(20)
                .roundedShadow()
                .padding(.top ,20)
                .padding(.horizontal,20)
                
                makeCell(image: "card-tick", title: "Set Up AutoPay")
                    .padding(.horizontal,20)
                
                Text("Add Payment Method")
                    .semibold18
                    .padding(.horizontal,20)
                
                gridView()
                    .padding(.horizontal,20)
                
                Text("Add Payment Method")
                    .semibold18
                    .padding(.horizontal,20)
                
                VStack {
                    TextFieldWithIcon(image: "profile", topTitle: "Cardholder Name", text: $cardHolder, textFiledStyle: .simple, emailError:.constant(false))
                    
                    TextFieldWithIcon(image: "card-pos", topTitle: "Card Number", text: $cardnumber, textFiledStyle: .simple, emailError:.constant(false))
                        .keyboardType(.numberPad)
                    
                    HStack(spacing: 14) {
                        TextFieldWithIcon(image: "calendar_ic", topTitle: "Exp Date", text: $exp, textFiledStyle: .simple, emailError:.constant(false))
                            .keyboardType(.numberPad)
                        
                        TextFieldWithIcon(image: "password-check", topTitle: "CVV", text: $cvv, textFiledStyle: .simple, emailError:.constant(false))
                            .keyboardType(.numberPad)
                    }
                }
                .padding(20)
                .roundedShadow()
                .padding(.horizontal,20)
                
                Text("Billing Info")
                    .semibold18
                    .padding(.horizontal,20)
                
                VStack {
                    TextFieldWithIcon(image: "renter_pin", topTitle: "Street Address", text: $street, textFiledStyle: .simple, emailError:.constant(false))
                    
                    HStack(spacing: 14) {
                        TextFieldWithIcon(image: "building-3", topTitle: "City", text: $city, textFiledStyle: .simple, emailError:.constant(false))
                        
                        TextFieldWithIcon(image: "global-edit", topTitle: "State", text: $state, textFiledStyle: .simple, emailError:.constant(false))
                    }
                    
                    HStack(spacing: 14) {
                        TextFieldWithIcon(image: "global", topTitle: "Country", text: $country, textFiledStyle: .simple, emailError:.constant(false))
                        
                        TextFieldWithIcon(image: "password-check", topTitle: "Zip Code", text: $zip, textFiledStyle: .simple, emailError:.constant(false))
                    }
                }
                .padding(20)
                .roundedShadow()
                .padding(.horizontal,20)
                
                ActionButton("Next")
                    .padding(EdgeInsets(top: 10, leading: 76, bottom: 50, trailing: 76))
                
            }
            .onChange(of: cardnumber) { newValue in
                self.cardnumber = format(with: "XXXX XXXX XXXX XXXX", phone: newValue)
            }
            .onChange(of: exp) { newValue in
                self.exp = format(with: "XX/XX", phone: newValue)
            }
            .onChange(of: cvv) { newValue in
                self.cvv = format(with: "XXX", phone: newValue)
            }
            
        }
        .navigationRenter(title: "Pay for Lease")
        .onTapGesture {
            UIApplication.shared.windows.filter{$0.isKeyWindow}.first?.endEditing(true)
        }
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarHidden(true)
        
    }
}

struct PayForLease_Previews: PreviewProvider {
    static var previews: some View {
        PayForLease()
    }
}


extension PayForLease {
    
    func gridView() -> some View {
        VStack(alignment: .leading) {
            
            LazyVGrid(columns: grid, spacing: 14) {
                
                AminityViewForReg(imageName: "plaid", title: "Link Bank Account", action: { i in
                    
                }, type: .buyer)
                
                AminityViewForReg(imageName: "card-pos", title: "Pay With Credit Card", action: { i in
                    
                }, type: .buyer)
                
            }
        }
    }
    
    private func makeCell(image: String, title: String) -> some View {
        HStack(spacing: 15) {
            
            Image(image)
                .resizable()
                .scaledToFill()
                .frame(width: 24, height: 24)
            
            Text(title)
                .medium16
            
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
                .fixedSize(horizontal: false, vertical: true)
            
            Spacer()
            
            Image(systemName: "chevron.right.circle")
                .resizable()
                .scaledToFill()
                .foregroundColor(.darkBlue)
                .frame(width: 26, height: 26)
        }
        .padding(14)
        .roundedShadowNew()
    }
}

struct AminityViewForReg: View {
    
    @State var isSelected: Bool = false
    var imageName: String
    var title: String
    var action: (Bool)-> Void
    var type: UserType = .buyer
    
    var body: some View {
        Button(action: {
            isSelected.toggle()
            action(isSelected)
        }) {
            ZStack(alignment: .topTrailing) {
                VStack {
                    
                    Image(imageName)
                        .renderingMode(.template)
                        .frame(width: 52, height: 52)
                        .foregroundColor(type == .buyer ? Color.purpleLow : Color.blueGradient.startColor)
                    
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(type == .buyer ? Color.purpleLow.opacity(0.15) : Color.blueGradient.endColor.opacity(0.15))
                        )
                    
                    Text(title)
                        .foregroundColor(.black)
                        .medium16
                        .padding(.horizontal)
                    
                }
                .frame(height: 142)
                .frame(maxWidth: .infinity)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(type != .buyer ? Color.purpleLow : Color.blueGradient.startColor, lineWidth: 3)
                        .opacity(isSelected ? 1 : 0)
                )
                .background(Color.white)
                .cornerRadius(8)
                .shadow(color: .gray.opacity(0.2), radius: 12)
                
                Circle()
                    .stroke(type != .buyer ? Color.purpleLow : Color.blueGradient.startColor, lineWidth: 1)
                    .frame(width: 20, height: 20)
                    .padding(12)
                    .overlay(
                        Image(systemName: "checkmark" )
                            .resizable()
                            .frame(width: 10, height: 10)
                            .foregroundColor(type != .buyer ? Color.purpleLow : Color.blueGradient.startColor)
                            .opacity(isSelected ? 1 : 0)
                    )
            }
            
        }
    }
}


struct AminityHorViewForReg: View {
    
    @Binding var isSelected: Bool
    var imageName: String
    var title: String
    var action: (Bool)-> Void
    var type: UserType = .buyer
    
    var body: some View {
        Button(action: {
            isSelected.toggle()
            action(isSelected)
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.white)
                    .frame(height: 60)
                    .roundedShadowNew()
                
                HStack {
                    Image(imageName)
                        .renderingMode(.template)
                        .frame(width: 52, height: 52)
                        .foregroundColor(type == .buyer ? Color.purpleLow : Color.blueGradient.endColor)
                    
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(type == .buyer ? Color.purpleLow.opacity(0.15) : Color.blueGradient.endColor.opacity(0.15))
                        )
                    
                    Text(title)
                        .foregroundColor(.black)
                        .medium16
                    Spacer()
                    
                    Circle()
                        .stroke(type != .buyer ? Color.purpleLow : Color.blueGradient.endColor, lineWidth: 1)
                        .frame(width: 20, height: 20)
                        .padding(12)
                        .overlay(
                            Image(systemName: "checkmark" )
                                .resizable()
                                .frame(width: 10, height: 10)
                                .foregroundColor(type != .buyer ? Color.purpleLow : Color.blueGradient.endColor)
                                .opacity(isSelected ? 1 : 0)
                        )
                }
                .frame(maxWidth: .infinity)
                .padding(10)
                
            }
            .roundedShadowNew()
        }
    }
}
