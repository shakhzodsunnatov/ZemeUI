//
//  AgentEditProfile.swift
//  ReZemeUI
//
//  Created by Davron_Usmanov on 25.04.2023.
//

import SwiftUI

struct AgentEditProfile: View {
    
    @ObservedObject var viewModel = AgentEditProfileVM()
    @Environment(\.presentationMode) var presentationMode
    //    var push: Binding<Bool> { $viewModel.openNextView }
    @State var push = false
    @State var buttonEnable: Bool = false
    
    var body: some View {
        CustomNavBar(
            content: {
                ScrollView(.vertical,showsIndicators: false) {
                    VStack(alignment: .center, spacing: 20) {
                        
                        ZStack {
                            
                            Color.white
                            
                            VStack(alignment: .leading, spacing: 20) {
                                
                                photoSelectButton
                                    .padding(.top,12)
                                
                                Group {
                                    
                                    TextFieldWithIcon(image: "profile", topTitle: "Full Name", text: $viewModel.model.lastname, textFiledStyle: .simple, emailError:$viewModel.fullname)
                                    
                                    TextFieldWithIcon(image: "mail-agent", topTitle: "Email", text: $viewModel.model.email, textFiledStyle: .simple, emailError:$viewModel.email)
                                    
                                    TextFieldWithIcon(image: "briefcase", topTitle: "Company Name", text: $viewModel.model.company, textFiledStyle: .simple, emailError:$viewModel.company)
                                    
                                    TextFieldWithIcon(image: "call", topTitle: "Phone Number", text: $viewModel.model.phone, textFiledStyle: .simple, emailError:$viewModel.phone)
                                        .keyboardType(.numberPad)
                                    
                                    TextFieldWithIcon(image: "edit", topTitle: "Bio",placeHolder: "Add a bio...", text: $viewModel.model.bio, textFiledStyle: .textView, emailError:.constant(false))
                                    
                                    
                                    TextFieldWithIcon(image: "lock-agent", topTitle: "Password", text: $viewModel.model.password, textFiledStyle: .simple, emailError:$viewModel.password)
                                    
                                    
                                    TextFieldWithIcon(image: "pin", topTitle: "Location", text: $viewModel.model.company, textFiledStyle: .simple, emailError:$viewModel.location)
                                   
                                }
                                .onChange(of: viewModel.model.phone) { newValue in
                                    self.viewModel.model.phone = format(with: "(XXX) XXX-XXXX", phone: newValue)
                                }
                            }
                            .padding(20)
                        }
                        .cornerRadius(8)
                        .padding(
                            EdgeInsets(
                                top: 28,
                                leading: 20,
                                bottom: 20,
                                trailing: 20
                            )
                        )
                        .shadowCustom()
                    }
                    
                    linkButton(title: "Continue") {
                        withAnimation {
                            if self.viewModel.validate() {
                                
                            } else {
                                Haptic.generateError()
                            }
                        }
                    }
                    .padding(.vertical, 45)
                    .padding(.horizontal,76)
//                    .opacity(self.viewModel.model.agreement ? 1 : 0.5)
                    
                }
                .sheet(isPresented: $viewModel.isShowPhotoLibrary) {
                    ImagePicker(sourceType: .photoLibrary, selectedImage: self.$viewModel.image)
                }
                .ignoresSafeArea(edges: .top)
                .onTapGesture {
                    UIApplication.shared.windows.filter{$0.isKeyWindow}.first?.endEditing(true)
                }
            },
            title: "Edit Profile",
            style: .newTitleAndIcon,
            type: .agent
        )
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarHidden(true)
    }
}

extension AgentEditProfile {
    
    private var title: some View {
        HStack {
            Text("Register")
                .semibold18
                .foregroundColor(.purpleLow)
            
            Spacer()
        }
    }
    
    private var dividerLine: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .fill(Color.gray.opacity(0.4))
                .frame(height: 1)
                .frame(maxWidth: .infinity)
        }
    }
    
    private var photoSelectButton: some View {
        Button {
            self.viewModel.isShowPhotoLibrary = true
        } label: {
            HStack {
                Spacer()
                ZStack(alignment: .bottomTrailing) {
                    Image(uiImage: self.viewModel.image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 96,height: 96)
                        .cornerRadius(48)
                    
                    ZStack {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 28,height: 28)
                        
                        Image("camera")
                        
                    }
                    .padding(.trailing,9)
                    
                }
                Spacer()
            }
            .padding(.bottom,20)
        }
    }
    
    func linkButton(title: String, action: @escaping () -> Void) -> some View {
        
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

struct AgentEditProfile_Previews: PreviewProvider {
    static var previews: some View {
        AgentEditProfile()
    }
}

