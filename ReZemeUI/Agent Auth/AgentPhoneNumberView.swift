//
//  AgentPhoneNumberView.swift
//  ReZemeUI
//
//  Created by Davron_Usmanov on 26.04.2023.
//

import SwiftUI

struct AgentPhoneNumberView: View {
    
    @StateObject var viewModel = AuthViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .top) {
                
                topHeaderView(geo: geo)
                
                    VStack(alignment: .leading, spacing: 0) {
                        
                        Text("Enter Phone Number")
                            .foregroundColor(.purpleLow)
                            .semibold18
                        
                        
                        lineDivider
                        .padding(.top, 13)
                        
                        
                        VStack(alignment: .leading) {
                            
                            textFieldHeader
                            
                            phoneTextField(phone: $viewModel.phone)
                            
                        }
                        .padding(.top, 19)
                        
                        
                        Text("We will send a verification to code to this number ")
                            .regular12
                            .fixedSize(horizontal: false, vertical: true)
                            .frame(maxWidth: .infinity)
                            .padding(.top, 19)
                        
                        Image("agentPhoneNumber_ic")
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
                    
                    NavigationLink(destination: {
                        AgentPinCodeView()
                            .environmentObject(viewModel)
                    }, label: {
                        ActionButton(
                            "Continue",
                            onlyLayer: false,
                            isActiveCondition: { viewModel.phone.count == 12 }
                        )
                    })
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

struct AgentPhoneNumberView_Previews: PreviewProvider {
    static var previews: some View {
        AgentPhoneNumberView()
    }
}


//MARK: - UI

extension AgentPhoneNumberView {
    
    private func topHeaderView(geo: GeometryProxy) -> some View {
        ZStack(alignment: .top) {
            Image("authBGsec")
                .resizable()
                .scaledToFit()
                
            
            Image("zemeLogo")
                .resizable()
                .scaledToFit()
                .padding(.horizontal, 111)
                .padding(.top, geo.safeAreaInsets.top + 50)
            
            HStack {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.white)
                        .frame(width: 27, height: 27)
                }

                
                Spacer()
            }
            .padding(.horizontal,17)
            .padding(.top, geo.safeAreaInsets.top)
        }
            .ignoresSafeArea()
    }
    
    private var lineDivider: some View {
        ZStack(alignment: .leading) {
            Divider()
                .frame(maxWidth: .infinity)
            
            Rectangle()
                .fill(Color.purpleLow)
                .frame(height: 2)
                .frame(width: 15)
        }
    }
    
    private var textFieldHeader: some View {
        HStack(spacing: 7) {
            
            Image(systemName: "phone")
                .resizable()
                .scaledToFit()
                .foregroundColor(.purpleLow)
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
                .onChange(of: viewModel.phone) { newValue in
                    viewModel.phone = format(with: "XXX-XXX-XXXX", phone: newValue)
                    
                    if viewModel.phone.count == 12 {
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
