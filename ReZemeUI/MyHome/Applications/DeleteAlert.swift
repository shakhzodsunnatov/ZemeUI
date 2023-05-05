//
//  DeleteAlert.swift
//  ReZemeUI
//
//  Created by Shakhzod on 04/05/23.
//

import SwiftUI

struct DeleteAlert: ViewModifier {
    
    @Binding var isActive: Bool
    let yesAction: ()-> Void
    let noAction: ()-> Void
    
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

struct DeleteAlert_Previews: PreviewProvider {
    static var previews: some View {
        DeleteAlertView(presenterView: .constant(true), yesAction: {}, noAction: {})
    }
}



struct DeleteAlertView: View {
    
    @Binding var presenterView: Bool
    
    var yesAction: ()-> Void
    var noAction: () ->Void
    
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            
            VStack(spacing:18) {
                
                Image("danger")
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFill()
                    .foregroundColor(.secondaryPurple)
                    .frame(width: 26, height: 36)
                    .frame(width: 80, height: 80)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.purpleLow.opacity(0.1))
                    )
                    .padding(.top,15)
                
                VStack(spacing: 5) {
                    Text("Delete Application")
                        .semibold18
                        .multilineTextAlignment(.center)
                    
                    Text("Are you sure you want to delete this application?")
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


//MARK: - UI

extension DeleteAlert {
    
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
            
            DeleteAlertView(
                presenterView: $isActive,
                yesAction: yesAction,
                noAction: noAction
            )
            
        }
    }
    
}


//MARK: - Make Modifier

extension View {
    
    func deleteAlert(
        isActive: Binding<Bool>,
        yesAction: @escaping ()->Void,
        noAction: @escaping ()->Void
    ) -> some View {
        modifier(
            DeleteAlert(
                isActive: isActive,
                yesAction: yesAction,
                noAction: noAction
            )
        )
    }
}
