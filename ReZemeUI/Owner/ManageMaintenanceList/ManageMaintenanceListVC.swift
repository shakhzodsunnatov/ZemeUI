//
//  ManageMaintenanceListVC.swift
//  ReZemeUI
//
//  Created by Davron_Usmanov on 03.05.2023.
//

import SwiftUI

struct ManageMaintenanceListVC: View {
    @State var isactive: Bool = false
    
    var contacts:[[String]] = [
        ["JD","John Doe"],
        ["MR","Melissa Reed"],
        ["JJ","Jake Jackson"],
        ["MG","Michael Green"],
        ["JJ","Jake Jackson"],
        ["MG","Michael Green"]
    ]
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 20) {
                
                linkButton(title: "Add Maintenance Contact") {
                    
                }
                
                VStack(spacing: 18) {
                    ForEach(contacts, id: \.self) { i in
                        contactCell(name: i[1], titleName: i[0])
                    }
                }
                .padding(15)
                .padding(.bottom,100)
                .roundedShadowNew()
                
            }
            .padding(20)
        }
        
        .onTapGesture {
            UIApplication.shared.windows.filter{$0.isKeyWindow}.first?.endEditing(true)
        }
        .navigationOwner(title: "Manage Maintenance List")
        .loginAlert(
            isActive: $isactive,
            loginAction: {isactive = false},
            createAction: {isactive = false}
        )
        .edgesIgnoringSafeArea(.bottom)
        .navigationBarHidden(true)
    }
}

extension ManageMaintenanceListVC {
    
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
    
    func contactCell(name:String , titleName:String) -> some View {
        HStack(spacing: 12) {
            Text(titleName)
                .medium16
                .foregroundColor(.purpleLow)
                .frame(width: 50,height: 50)
                .background (
                Circle()
                    .fill(Color.purpleLow.opacity(0.1))
                    .frame(width: 50)
                )
            
            Text(name)
                .medium16
            
            Spacer()
            
            Button {
                isactive.toggle()
            } label: {
                ZStack {
                    Circle()
                        .stroke(Color.purpleLow,lineWidth: 1)
                        .frame(width: 37)
                    
                    Image("trash")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(.purpleLow)
                        .frame(width: 24,height: 24)
                }
                
            }

            Button {
                
            } label: {
                ZStack {
                    Circle()
                        .stroke(Color.darkBlue,lineWidth: 1)
                        .frame(width: 37)
                    
                    Image("edit-2")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(.darkBlue)
                        .frame(width: 24,height: 24)
                }
                
            }
        }
        
    }
}

struct ManageMaintenanceListVC_Previews: PreviewProvider {
    static var previews: some View {
        ManageMaintenanceListVC()
    }
}

struct AuthView: View {
    
    @Binding var presenterView: Bool
    
    var yesAction: ()-> Void
    var noAction: () ->Void
    

    var body: some View {
        ZStack(alignment: .topTrailing) {
            
            VStack(spacing:18) {
                
                Image("danger")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 26, height: 36)
                    .frame(width: 80, height: 80)
                    .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.purpleLow.opacity(0.1))
                    )
                    .padding(.top,15)
                
                VStack(spacing: 5) {
                    Text("Delete Maintenance Contact")
                        .semibold18
                        .multilineTextAlignment(.center)
                    
                    Text("Are you sure you want to delete this contact?")
                        .regular16
                        .foregroundColor(.black.opacity(0.5))
                        .multilineTextAlignment(.center)
                }
                
                HStack(spacing: 14) {
                    
                    Button(action: {
                        withAnimation {
                            self.presenterView = false
                        }
                        yesAction()
                    }) {
                        Text("Yes")
                            .bold18
                            .foregroundColor(.darkBlue)
                            .frame(height: 60)
                            .frame(maxWidth: .infinity)
                            .background(
                                Capsule()
                                    .stroke(Color.primaryBlue, lineWidth: 1)
                            )
                            
                    }
                    
                    Button(action: {
                        withAnimation {
                            self.presenterView = false
                        }
                        noAction()
                    }) {
                        Text("No")
                            .bold18
                            .foregroundColor(.white)
                            .frame(height: 60)
                            .frame(maxWidth: .infinity)
                            .background(
                                Capsule()
                                    .fill(Color.blueGradient.toLinearGradient)
                            )
                            
                    }
                }
            }
            .padding(20)
            .roundedShadowNew()
            .padding(20)
        }
        
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView(presenterView: .constant(false), yesAction: {}, noAction: {})
    }
}

struct LoginAlert: ViewModifier {
    
    @Binding var isActive: Bool
    let loginAction: ()-> Void
    let createAction: ()-> Void
    
    func body(content: Content) -> some View {
        
        ZStack {
            
            if isActive {
                alertView(content: content)
            } else {
                content
            }
            
        }
    }
    
}


//MARK: - UI

extension LoginAlert {

    private func alertView(content: Content) -> some View {
        ZStack {
            
            if #available(iOS 15.0, *) { //TODO: - Make modifier for Blueness
                content
                    .background(.thinMaterial)
                    .blur(radius: 10)
                    .disabled(true)
            } else {
                content
                
                VisualEffectView(effect: UIBlurEffect(style: .systemMaterialLight))
                    .edgesIgnoringSafeArea(.all)
            }
            
            AuthView(
                presenterView: $isActive,
                yesAction: loginAction,
                noAction: createAction
            )
            
        }
    }
    
}


//MARK: - Make Modifier

extension View {
    
    func loginAlert(
        isActive: Binding<Bool>,
        loginAction: @escaping ()->Void,
        createAction: @escaping ()->Void
    ) -> some View {
        modifier(
            LoginAlert(
                isActive: isActive,
                loginAction: loginAction,
                createAction: createAction
            )
        )
    }
}
