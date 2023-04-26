//
//  EditProfileView.swift
//  ReZemeUI
//
//  Created by Shakhzod on 25/04/23.
//

import SwiftUI

struct RenterProfileEditView: View {
    
    @StateObject var viewModel = RenterProfileViewModel()
    
    var body: some View {
        ScrollView {
                
            textFields()
                .padding(.top, 22)
            
            neighborhood()
                .padding(.top, 20)
        
        }
        .navigationRenter(
            title: "Edit Profile",
            rightButton: navBarButton {
                //TODO: - Nav Bar Profile Button action
            }
        )
        
    }
}


//MARK: - UI Components

extension RenterProfileEditView {
    
    private func textFields() -> some View {
        VStack(spacing: 20) {
            
            TextFieldWithIcon(
                image: "profile_agent_red",
                topTitle: "Full Name",
                placeHolder: "Full Name" ,
                text: $viewModel.fullName,
                textFiledStyle: .simple,
                emailError: .constant(false)
            )
            
            TextFieldWithIcon(
                image: "mail-agent",
                topTitle: "Email",
                placeHolder: "Email" ,
                text: $viewModel.email,
                textFiledStyle: .simple,
                emailError: .constant(false)
            )
            
            TextFieldWithIcon(
                image: "lock-agent",
                topTitle: "Password",
                placeHolder: "Password" ,
                text: $viewModel.password,
                textFiledStyle: .simple,
                emailError: .constant(false)
            )
            
            TextFieldWithIcon(
                image: "mapPin_red",
                topTitle: "Location",
                placeHolder: "Location" ,
                text: $viewModel.location,
                textFiledStyle: .simple,
                emailError: .constant(false)
            )
        }
        .padding(EdgeInsets(top: 16, leading: 18, bottom: 24, trailing: 16))
        .roundedShadow()
        .padding(.horizontal, 20)
    }
    
    private func neighborhood() -> some View {
        VStack(spacing: 0) {
            HStack(alignment: .top) {
                Text("What’s most Important to you in a neighborhood?")
                    .semibold18
                    .multilineTextAlignment(.leading)
                
                Spacer()
                
                Image(systemName: "chevron.top.circle")
                    .resizable()
                    .scaledToFill()
                    .foregroundColor(.darkBlue)
                    .frame(width: 26, height: 26)
            }
        }
        .padding(18)
        .padding(.bottom, 2)
        .roundedShadow()
        .padding(.horizontal, 20)
    }
    
    private func navBarButton(action: @escaping ()->Void) -> AnyView {
        AnyView(
            ZStack {
                Image("profile-agent")
                    .resizable()
                    .scaledToFill()
                    .padding(15)
                    .frame(width: 50, height: 50)
                    .roundedShadow(cornerRadius: 16)
                    
                
            }.makeButton(action: action)
        )
    }
}


struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        RenterProfileEditView()
    }
}
