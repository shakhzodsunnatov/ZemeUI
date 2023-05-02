//
//  CreditCheckView.swift
//  ReZeme
//
//  Created by Shakhzod on 19/03/23.
//

import SwiftUI

struct CreditCheckView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var vm = CreditCheckVM()
    
    
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
                            TextFieldWithIcon(image: "profile_agent_red", topTitle: "Legal First Name",placeHolder: "First Name" ,text: $vm.firstnameText, textFiledStyle: .simple, emailError: .constant(false))
                            
                            TextFieldWithIcon(image: "profile_agent_red", topTitle: "Legal Middle Name",placeHolder: "Middle Name" ,text: $vm.middlenameText, textFiledStyle: .simple, emailError: .constant(false))
                            
                            TextFieldWithIcon(image: "profile_agent_red", topTitle: "Legal Last Name",placeHolder: "Last Name" ,text: $vm.lastnameText, textFiledStyle: .simple, emailError: $vm.lastnamecheck)
                            
                            TextFieldWithIcon(image: "password-check", topTitle: "Social Security Number",placeHolder: "Number" ,text: $vm.phoneText, textFiledStyle: .simple, emailError: $vm.phonecheck)
                                .keyboardType(.numberPad)
                                .onChange(of: vm.phoneText) { newValue in
                                    vm.phoneText = format(with: "XXX-XX-XXXX", phone: newValue)
                                }
                        }
                        .onTapGesture {
                            dismissKeyboard()
                        }
                        
                        ZStack {
                            TextFieldWithIcon(image: "calendar", topTitle: "Date of Birth",placeHolder: "yyyy-mm-dd" ,text: $vm.dateofbirdthText, textFiledStyle: .simple, emailError: $vm.dateofbirdthcheck)
                                .disabled(true)
                                .onChange(of: vm.date) { newValue in
                                    vm.calenarMode.toggle()
                                    let formatter1 = DateFormatter()
                                    formatter1.dateFormat = "yyyy-MM-dd"
                                    vm.dateofbirdthText = formatter1.string(from: newValue)
                                }.onTapGesture {
                                    withAnimation(.easeInOut) {
                                        vm.calenarMode.toggle()
                                    }
                                }
                            if vm.calenarMode {
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.white)
                                    .roundedShadowNew()
                                    .onTapGesture {
                                        withAnimation(.easeInOut) {
                                            vm.calenarMode.toggle()
                                        }
                                    }
                                DatePicker("select", selection: $vm.date,in: ...Date(), displayedComponents: .date)
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
                        if vm.validate() {
                            vm.showAlert = true
                        }
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
                
                
                if vm.showAlert {
                    ZStack() {
                        // faded background
                        Color.black.opacity(0.35)
                            .blur(radius: 4)
                            .edgesIgnoringSafeArea(.all)

                        ZStack(alignment: .topTrailing) {
                            
                            VStack(spacing: 0) {
                                
                                Image(systemName: "exclamationmark.triangle")
                                    .resizable()
                                    .scaledToFill()
                                    .font(.title.weight(.light))
                                    .foregroundColor(Color.secondaryPurple)
                                    .padding(22)
                                    .frame(width: 80, height: 80)
                                    .background(
                                        RoundedRectangle(cornerRadius: 8)
                                            .fill(Color.secondaryPurple.opacity(0.15))
                                    )
                                    
                                Text("Notice!")
                                    .semibold18
                                    .padding(.top, 18)
                                
                                ScrollView(showsIndicators: false) {
                                    Text("By checking the  box below, you authorize us to obtain a soft inquiry credit report for the purpose of providing it to brokers, agents, landlords, property managers, and other relevant parties (collectively ) associated with the properties you are interested in. This soft inquiry credit report may include information on your credit history, payment records, and other information relevant to your creditworthiness. Soft inquiry credit reports do not affect your credit score and are not visible to other creditors. You understand that this information may be used by stakeholders to evaluate your application, and that Zeme Inc. is not responsible for any decisions made by stakeholders based on this information.")
                                        .regular16
                                        .multilineTextAlignment(.center)
                                        .padding(.top, 7)
                                }.frame(maxHeight: 300)
                                
                                SimpleTextCheckView(title: "I authorize the soft credit inquiry") { t in
                                    vm.isConfirmed = t
                                }
                                
                                linkButton(title: "Confirm") {
                                    presentationMode.wrappedValue.dismiss()
                                }
                                .disabled(!vm.isConfirmed)
                                .opacity(!vm.isConfirmed ? 0.5 : 1)
                                .padding(.horizontal,84)
                                
                            }
                            .padding(EdgeInsets(top: 35, leading: 28, bottom: 26, trailing: 28))
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.white)
                            )
                            .padding(.horizontal, 20)
                            
                            Button(action: {
                                vm.showAlert = false
                            }) {
                                Image("closeXIcon")
                                    .frame(width: 25,height: 25)
                            }
                            .padding(.trailing, 12)
                            .padding(.top, -7)
                        }
                        
                    }
                }
            }
        }
    }
}



//MARK: - UI Components

extension CreditCheckView {
    
//    private func navBar(geo: GeometryProxy) -> some View {
//        HStack {
//            
//            Button(action: {
//                presentationMode.wrappedValue.dismiss()
//            }) {
//                Image(systemName: "arrow.left")
//                    .resizable()
//                    .scaledToFit()
//                    .foregroundColor(.white)
//                    .font(Font.title.weight(.medium))
//                    .frame(width: 26, height: 26)
//            }
//            .padding(.leading, 17)
//            
//            Spacer()
//            
//            Text("Credit Check")
//                .semibold22
//                .foregroundColor(.white)
//                .frame(maxWidth: .infinity)
//                .padding(.trailing, 43)
//            
//        }
//        .padding(.top, geo.safeAreaInsets.top)
//        .padding(.bottom, 25)
//        .frame(width: SCREEN_WIDTH)
//        .background(
//            Image("top-background")
//                .resizable()
//        )
//        .ignoresSafeArea(edges: .top)
//    }
    
    func linkButton(title: String,action: @escaping () -> Void) -> some View {
        
        Button(action: action) {
            ZStack {
                Color.blueGradient.toLinearGradient
                    
                Text(title)
                    .foregroundColor(.white)
                    .bold18
            }
            .frame(height: 60)
            .cornerRadius(30)
        }
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
