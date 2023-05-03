//
//  OwnerRegistarion.swift
//  ReZemeUI
//
//  Created by Davron_Usmanov on 03.05.2023.
//

import SwiftUI
import UIKit

struct OwnerRegistarionVC: View {
    
    @ObservedObject var viewModel = OwnerRegistarionVM()
    @Environment(\.presentationMode) var presentationMode
    //    var push: Binding<Bool> { $viewModel.openNextView }
    @State var push = false
    @State var buttonEnable: Bool = false
    
    var body: some View {
        ZStack {
            
            VStack(spacing: 0) {
                Image("owner_top_big")
                    .resizable()
                    .frame(height: 300)
                    .offset(y:-1)
                Spacer()
            }
            
            ScrollView(.vertical,showsIndicators: false) {
                VStack(alignment: .center, spacing: 20) {
                    VStack {
                        HStack {
                            Button {
                                presentationMode.wrappedValue.dismiss()
                            } label: {
                                Image("arrow-left")
                            }
                            Spacer()
                        }
                        Image("zemeLogo")
                    }
                    .padding(.horizontal,20)
                    .padding(.top, 40)
                    .padding(.bottom,20)
                    
                    
                    ZStack {
                        Color.white
                        
                        VStack(alignment: .leading, spacing: 22) {
                            VStack(alignment: .leading, spacing: 5) {
                                title
                                dividerLine
                            }
                            
                            photoSelectButton
                            Group {
                                HStack(spacing: 10) {
                                    TextFieldWithIcon(image: "profile", topTitle: "First Name", text: $viewModel.model.name, textFiledStyle: .simple, emailError:$viewModel.firstname)
                                    
                                    TextFieldWithIcon(image: "profile", topTitle: "Middle Name", text: $viewModel.model.middleName, textFiledStyle: .simple, emailError:$viewModel.middlename)
                                }
                                
                                TextFieldWithIcon(image: "profile", topTitle: "Last Name", text: $viewModel.model.lastname, textFiledStyle: .simple, emailError:$viewModel.lastname)
                                
                                TextFieldWithIcon(image: "briefcase", topTitle: "Company Name", text: $viewModel.model.company, textFiledStyle: .simple, emailError:$viewModel.company)
                                
                                TextFieldWithIcon(image: "call", topTitle: "Phone Number", text: $viewModel.model.phone, textFiledStyle: .simple, emailError:$viewModel.phone)

//                                TextFieldWithIcon(image: "mail-agent", topTitle: "Email", text: $viewModel.model.email, textFiledStyle: .simple, emailError:$viewModel.email)

//                                TextFieldWithIcon(image: "lock-agent", topTitle: "Password", text: $viewModel.model.password, textFiledStyle: .simple, emailError:$viewModel.password)

//                                TextFieldWithIcon(image: "lock-agent", topTitle: "Confirm Password", text: $viewModel.confirmPasswordText, textFiledStyle: .simple, emailError:$viewModel.confirmpassword)
                                
                                TextFieldWithIcon(image: "edit", topTitle: "Bio",placeHolder: "Add a bio...", text: $viewModel.model.bio, textFiledStyle: .textView, emailError:$viewModel.confirmpassword)
                                
                                CheckButtonCustom(title: "By checking this box, you agree to the terms of service") { bool in
                                    viewModel.model.agreement = bool
                                }
                            }
                            .onChange(of: viewModel.model.phone) { newValue in
                                self.viewModel.model.phone = format(with: "(XXX) XXX-XXXX", phone: newValue)
                            }
                        }
                        .padding(20)
                    }
                    .roundedShadowNew()
                    .padding([.horizontal,.top],20)
                }
                
                linkButton(title: "Continue") {
                    
                }
                .padding(.top, 50)
                .padding(.horizontal,76)
                .opacity(self.viewModel.model.agreement ? 1 : 0.5)
                
            }
            
            if self.viewModel.isLoading {
                ProgressView()
                    .scaleEffect(2, anchor: .center)
                    .progressViewStyle(
                        CircularProgressViewStyle(tint: Color.secondaryPurple)
                    )
            }
        }
        .sheet(isPresented: $viewModel.isShowPhotoLibrary) {
//            ImagePicker(sourceType: .photoLibrary, selectedImage: self.$viewModel.image)
        }
        .ignoresSafeArea(edges: .top)
        .onTapGesture {
            UIApplication.shared.windows.filter{$0.isKeyWindow}.first?.endEditing(true)
        }
        
        .navigationBarBackButtonHidden(true)
    }
}

struct OwnerRegistarionVC_Previews: PreviewProvider {
    static var previews: some View {
        OwnerRegistarionVC()
    }
}


extension OwnerRegistarionVC {
    
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
        }.disabled(!self.viewModel.model.agreement)
    }
}
