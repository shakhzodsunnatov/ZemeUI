//
//  AgentPinCodeView.swift
//  ReZemeUI
//
//  Created by Davron_Usmanov on 26.04.2023.
//

import SwiftUI

struct AgentPinCodeView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .top) {
                
                topHeaderView(geo: geo)
                
                    VStack(alignment: .leading, spacing: 0) {
                        
                        Text("Enter Verification Code")
                            .foregroundColor(.purpleLow)
                            .semibold18
                        
                        Text("Enter the code that was sent to your number ending in \(String(viewModel.phone.suffix(4)))")
                            .regular12
                            .fixedSize(horizontal: false, vertical: true)
                        
                        lineDivider
                        .padding(.top, 13)
                        
                        
                        VStack(alignment: .leading) {
                            
                            PinCodeTextField { pinCode in
                                // Here
                                if pinCode.count == 6 {
                                    dismissKeyboard()
                                }
                            }
                            
                        }
                        .padding(.top, 13)
                        
                        
                        Button {
                            // Resend logic
                        } label: {
                            Text("Resend Code")
                                .medium12
                                .foregroundColor(.darkBlue)
                                .fixedSize(horizontal: false, vertical: true)
                                .padding(.top, 18)
                        }

                        
                        Image("agentPinCode_ic")
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
                    
                    ActionButton("Continue", action: {
                        // Continue Button action
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

struct AgentPinCodeView_Previews: PreviewProvider {
    static var previews: some View {
        
        AgentPhoneNumberView()
        AgentPinCodeView()
            .environmentObject(AuthViewModel())
    }
}

extension AgentPinCodeView {
    
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
    
}
