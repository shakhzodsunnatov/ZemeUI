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
    @State var calenarMode: Bool = false
    @State var date = Date()
    
    @State var dateAvailable = ""
    @State var phone = ""
    @State var firstName = ""
    @State var lastName = ""
    @State var middleName = ""
    
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
                        
                        Group {
                            TextFieldWithIcon(image: "profile_agent_red", topTitle: "Legal First Name",placeHolder: "First Name" ,text: $firstName, textFiledStyle: .simple, emailError:.constant(false))
                            
                            TextFieldWithIcon(image: "profile_agent_red", topTitle: "Legal Middle Name",placeHolder: "Middle Name" ,text: $middleName, textFiledStyle: .simple, emailError:.constant(false))
                            
                            TextFieldWithIcon(image: "profile_agent_red", topTitle: "Legal Last Name",placeHolder: "Last Name" ,text: $lastName, textFiledStyle: .simple, emailError:.constant(false))
                            
                            TextFieldWithIcon(image: "password-check", topTitle: "Social Security Number",placeHolder: "Number" ,text: $phone, textFiledStyle: .simple, emailError:.constant(false))
                                .keyboardType(.numberPad)
                                .onChange(of: phone) { newValue in
                                    self.phone = format(with: "XXX-XX-XXXX", phone: newValue)
                                }
                        }
                        .onTapGesture {
                            dismissKeyboard()
                        }
                        
                        ZStack {
                            TextFieldWithIcon(image: "calendar", topTitle: "Date of Birth",placeHolder: "yyyy-mm-dd" ,text: $dateAvailable, textFiledStyle: .simple, emailError: .constant(false))
                                .disabled(true)
                                .onChange(of: date) { newValue in
                                    calenarMode.toggle()
                                    let formatter1 = DateFormatter()
                                    formatter1.dateFormat = "yyyy-MM-dd"
                                    self.dateAvailable = formatter1.string(from: newValue)
                                }.onTapGesture {
                                    withAnimation(.easeInOut) {
                                        calenarMode.toggle()
                                    }
                                }
                            if calenarMode {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.white)
                                    .shadowCustom()
                                    .onTapGesture {
                                        withAnimation(.easeInOut) {
                                            calenarMode.toggle()
                                        }
                                    }
                                DatePicker("select", selection: $date,in: ...Date(), displayedComponents: .date)
                                    .frame(width: 300 , height: 300)
                                    .datePickerStyle(.graphical)
                            }
                            
                        }
                        
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
