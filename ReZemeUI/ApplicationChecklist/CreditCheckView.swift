//
//  CreditCheckView.swift
//  ReZeme
//
//  Created by Shakhzod on 19/03/23.
//

import SwiftUI

struct CreditCheckView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var nameText = ""
    @State var showAlert = false
    @State var openCongratsView = false
    
    var body: some View {
        NavigationNavBar(title: "Credit Check") {
            ZStack {
                ScrollView {
                    
                    Text("Personal Info")
                        .semibold18
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 22)
                        .padding(.horizontal,20)
                    
                    
                    VStack(spacing: 20) {
                        
                        
                        TextField("First Name", text: .constant(""))
                            .textFieldStyle(
                                PrimaryTextFieldStyle(
                                    title: "Legal First Name",
                                    image: "profile_agent_red",
                                    error: .constant(false)
                                )
                            )
                            .frame(height: 90)
                        
                        TextField("Middle Name", text: .constant(""))
                            .textFieldStyle(
                                PrimaryTextFieldStyle(
                                    title: "Legal Middle Name",
                                    image: "profile_agent_red",
                                    error: .constant(false)
                                )
                            )
                            .frame(height: 90)
                        
                        TextField("Last Name", text: .constant(""))
                            .textFieldStyle(
                                PrimaryTextFieldStyle(
                                    title: "Legal Last Name",
                                    image: "profile_agent_red",
                                    error: .constant(false)
                                )
                            )
                            .frame(height: 90)
                        
                        TextField("Number", text: .constant(""))
                            .textFieldStyle(
                                PrimaryTextFieldStyle(
                                    title: "Social Security Number",
                                    image: "password-check",
                                    error: .constant(false)
                                )
                            )
                            .frame(height: 90)
                        
                        TextField("dd/mm/yyyy", text: $nameText)
                            .textFieldStyle(
                                PrimaryTextFieldStyle(
                                    title: "Date of Birth",
                                    image: "calendar",
                                    error: .constant(false)
                                )
                            )
                            .frame(height: 90)
                        
                    }
                    .padding(EdgeInsets(top: 27, leading: 18, bottom: 25, trailing: 18))
                    .background(Color.white)
                    .cornerRadius(radius: 8, corners: .allCorners)
                    .shadow(color: .gray.opacity(0.3), radius: 12)
                    .padding(.top, 10)
                    .padding(.horizontal, 20)
                    
                    
                    Button(action: {
                        showAlert = true
                    }) {
                        Text("Confirm Information")
                            .semibold18
                            .foregroundColor(.white)
                            .frame(height: 60)
                            .frame(maxWidth: .infinity)
                            .background(
                                Capsule()
                                    .fill(Color.blueGradient.toLinearGradient)
                            )
                            .padding(.horizontal, 76)
                    }
                    .padding(.top, 24)
                }
                .frame(width: SCREEN_WIDTH)
                .onTapGesture {
                    dismissKeyboard()
                }
                
                if showAlert {
                    CustomAlert(presentAlert: $showAlert) {
                        //TODO: - Do Confirm action AND close
                        
                        showAlert = false
                        openCongratsView = true
                    }
                }
                
                NavigationLink(
                    isActive: $openCongratsView,
                    destination: { CongratsView() }
                ) { EmptyView() }
                    .navigationBarHidden(true)
            }
        }
    }
}



//MARK: - UI Components

extension CreditCheckView {
    
    private func navBar(geo: GeometryProxy) -> some View {
        HStack {
            
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "arrow.left")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.white)
                    .font(Font.title.weight(.medium))
                    .frame(width: 26, height: 26)
            }
            .padding(.leading, 17)
            
            Spacer()
            
            Text("Credit Check")
                .semibold22
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.trailing, 43)
            
        }
        .padding(.top, geo.safeAreaInsets.top)
        .padding(.bottom, 25)
        .frame(width: SCREEN_WIDTH)
        .background(
            Image("top-background")
                .resizable()
        )
        .ignoresSafeArea(edges: .top)
    }
}

struct CreditCheckView_Previews: PreviewProvider {
    static var previews: some View {
        CreditCheckView()
    }
}

extension View {
    func dismissKeyboard() {
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.endEditing(true)
    }
}
