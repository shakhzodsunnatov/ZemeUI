//
//  PhoneNumberView.swift
//  ReZemeUI
//
//  Created by Shakhzod on 20/04/23.
//

import SwiftUI

struct PhoneNumberView: View {
    
    //MARK: - PROPERTIES
    
    @State var phoneNumber = ""
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .top) {
                
                topHeaderView(geo: geo)
                
                    VStack(alignment: .leading, spacing: 0) {
                        
                        Text("Enter Phone Number")
                            .foregroundColor(.darkBlue)
                            .semibold18
                        
                        
                        lineDivider
                        .padding(.top, 13)
                        
                        
                        VStack(alignment: .leading) {
                            
                            textFieldHeader
                            
                            phoneTextField(phone: $phoneNumber)
                            
                        }
                        .padding(.top, 19)
                        
                        
                        Text("We will send a verification to code to this number ")
                            .regular12
                            .fixedSize(horizontal: false, vertical: true)
                            .frame(maxWidth: .infinity)
                            .padding(.top, 19)
                        
                        Image("phoneNumber_ic")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 54)
                            .padding(.top, 41)
                        
                    }
                    .padding(
                        EdgeInsets(
                            top: 26,
                            leading: 18,
                            bottom: 38,
                            trailing: 18
                        )
                    )
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.white)
                            .glow()
                    )
                    .padding(.horizontal, 20)
                    .padding(.top, (geo.safeAreaInsets.top + 50) + 35)
                    .padding(.bottom, geo.safeAreaInsets.bottom)
                
                
                ZStack(alignment: .bottom) {
                    
                    Color.clear
                    
                    Button {
                        // Continue Button action
                    } label: {
                        Text("Continue")
                            .bold18
                            .foregroundColor(.white)
                            .frame(height: 60)
                            .frame(maxWidth: .infinity)
                            .background(
                                Capsule()
                                    .fill(Color.blueGradient.toLinearGradient)
                            )
                    }
                    .padding(.horizontal, 76)
                }
            }
            .navigationBarHidden(true)
            .onTapGesture {
                dismissKeyboard()
            }
        }
    }
}


//MARK: - UI

extension PhoneNumberView {
    
    private func topHeaderView(geo: GeometryProxy) -> some View {
        ZStack(alignment: .top) {
            Image("authBG")
                .resizable()
                .scaledToFit()
                
            
            Image("zemeLogo")
                .resizable()
                .scaledToFit()
                .padding(.horizontal, 111)
                .padding(.top, geo.safeAreaInsets.top + 50)
            
            HStack {
                Image(systemName: "arrow.left")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.white)
                    .frame(width: 27, height: 27)
                
                Spacer()
            }
            .padding(.horizontal,17)
            .padding(.top, geo.safeAreaInsets.top)
        }
//            .frame(height: SCREEN_HEIGHT, alignment: .top)
            .ignoresSafeArea()
    }
    
    private var lineDivider: some View {
        ZStack(alignment: .leading) {
            Divider()
                .frame(maxWidth: .infinity)
            
            Rectangle()
                .fill(Color.darkBlue)
                .frame(height: 2)
                .frame(width: 15)
        }
    }
    
    private var textFieldHeader: some View {
        HStack(spacing: 7) {
            
            Image(systemName: "phone")
                .resizable()
                .scaledToFit()
                .foregroundColor(.darkBlue)
                .frame(width: 18, height: 18)
            
            Text("Phone Number")
                .regular14
        }

    }
    
    private func phoneTextField(phone: Binding<String>) -> some View {
        HStack(spacing: 11) {
            
            Text("+1")
            
            Divider()
            
            TextField(format(with: "XXX-XXX-XXX", phone: "0000000000"), text: phone)
                .autocorrectionDisabled()
                .keyboardType(.numberPad)
                .onChange(of: phoneNumber) { newValue in
                    phoneNumber = format(with: "XXX-XXX-XXX", phone: newValue)
                    
                    if phoneNumber.count == 11 {
                        dismissKeyboard()
                    }
                }
                
            Spacer()
        }
        .medium16
        .padding(.vertical, 10)
        .padding(.horizontal, 21)
        .frame(height: 58)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.white)
                .glow()
        )
    }
}

struct PhoneNumberView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneNumberView()
    }
}
