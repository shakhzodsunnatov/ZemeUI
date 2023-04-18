//
//  MeetingAlertView.swift
//  ReZemeUI
//
//  Created by Shakhzod on 18/04/23.
//

import SwiftUI

struct MeetingAlertView: ViewModifier {
    
    @Binding var isActive: Bool
    let submit: (Bool)->Void
    
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

extension MeetingAlertView {

    private func alertView(content: Content) -> some View {
        ZStack {
            
            if #available(iOS 15.0, *) { //TODO: - Make modifier for Blueness
                content
                    .background(.thinMaterial)
                    .blur(radius: 10)
                    .disabled(isActive)
            } else {
                content
                    .disabled(isActive)
                
                VisualEffectView(effect: UIBlurEffect(style: .systemMaterialLight))
                    .edgesIgnoringSafeArea(.all)
            }
            
            MeetingTypeAlert(
                presenterView: $isActive,
                submit: submit
            )
            
        }
    }
    
}


//MARK: - Make Modifier

extension View {
    
    func meetingTypeAlert(
        isActive: Binding<Bool>,
        submit: @escaping (Bool)->Void
    ) -> some View {
        modifier(
            MeetingAlertView(isActive: isActive, submit: submit)
        )
    }
}


struct MeetingAlertView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.blue
        }
        .meetingTypeAlert(isActive: .constant(true)) { _ in }
    }
}
