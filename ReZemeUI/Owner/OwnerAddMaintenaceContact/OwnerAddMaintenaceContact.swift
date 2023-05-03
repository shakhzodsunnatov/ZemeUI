//
//  OwnerAddMaintenaceContact.swift
//  ReZemeUI
//
//  Created by Davron_Usmanov on 03.05.2023.
//

import SwiftUI

struct OwnerAddMaintenaceContact: View {
    
    @ObservedObject var viewModel = OwnerAddMaintenaceContactVM()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                VStack(alignment: .leading, spacing: 10) {
                    HStack(spacing: 10) {
                        TextFieldWithIcon(image: "profile", topTitle: "First Name", text: $viewModel.model.name, textFiledStyle: .simple, emailError: $viewModel.firstname)
                        
                        TextFieldWithIcon(image: "profile", topTitle: "Last Name", text: $viewModel.model.lastname, textFiledStyle: .simple, emailError: $viewModel.lastname)
                    }
                    
                    TextFieldWithIcon(image: "mail-agent", topTitle: "Email", text: $viewModel.model.email, textFiledStyle: .simple, emailError: $viewModel.email)
                    
                    TextFieldWithIcon(image: "call", topTitle: "Phone Number", text: $viewModel.model.phone, textFiledStyle: .simple, emailError: $viewModel.phone)
                        .keyboardType(.numberPad)
                    
                    TextFieldWithIcon(image: "briefcase", topTitle: "Title/Role", text: $viewModel.model.location, textFiledStyle: .simple, emailError: $viewModel.role)
                    
                    TextFieldWithIcon(image: "briefcase", topTitle: "Company Name", text: $viewModel.model.company, textFiledStyle: .simple, emailError: $viewModel.company)
                    //
                }
                .onChange(of: viewModel.model.phone) { newValue in
                    self.viewModel.model.phone = format(with: "(XXX) XXX-XXXX", phone: newValue)
                }
                .padding(20)
                .roundedShadowNew()
                .padding(.horizontal,20)
                .padding(.top,15)
                .padding(.bottom, 34)
                
                linkButton(title: "Save") {
                    
                }
                .padding(.horizontal,76)
                .padding(.bottom,35)
            }
        }
        .onTapGesture {
            UIApplication.shared.windows.filter{$0.isKeyWindow}.first?.endEditing(true)
        }
        .navigationOwner(title: "Add Maintenace Contact")
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarHidden(true)
    }
}

extension OwnerAddMaintenaceContact {
    
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
        }//.disabled(!self.viewModel.model.agreement)
    }
}

struct OwnerAddMaintenaceContact_Previews: PreviewProvider {
    static var previews: some View {
        OwnerAddMaintenaceContact()
    }
}

