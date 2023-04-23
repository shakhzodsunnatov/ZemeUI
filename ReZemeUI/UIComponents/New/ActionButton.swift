//
//  ActionButton.swift
//  ReZemeUI
//
//  Created by Shakhzod on 20/04/23.
//

import SwiftUI

 enum ActionButtonType {
     case renter,agent

     var color: LinearGradient {
         switch self {
         case .renter: return Color.blueGradient.toLinearGradient
         case .agent: return Color.purpleGradient.toLinearGradient
         }
     }
 }

 struct ActionButton: View {

     //MARK: - PROPERTIES
     var text: String
     var btnHeight: CGFloat
     var onlyLayer: Bool
     var type: ActionButtonType
     @Binding var isActive: Bool
     var isActiveCondition: ()->Bool
     var action: ()->Void = {}


     init(
         _ text: String,
         btnHeight: CGFloat = 60,
         onlyLayer: Bool = true,
         type: ActionButtonType = .renter,
         isActive: Binding<Bool> = .constant(true), // If button inside NavigationLink
         isActiveCondition: @escaping ()->Bool = { return true},
         action: @escaping ()-> Void = {}
     ) {
         self.text = text
         self.btnHeight = btnHeight
         self.onlyLayer = onlyLayer
         self.type = type
         self._isActive = isActive
         self.isActiveCondition = isActiveCondition
         self.action = action
     }


     //MARK: - body
     
     var body: some View {
         Button(action: action) {
             Text(text)
                 .foregroundColor(.white)
                 .bold18
                 .frame(height: btnHeight)
                 .frame(maxWidth: .infinity)
                 .background(
                     Capsule()
                         .fill(type.color)
                 )
                 .opacity(isActive ? 1 : 0.6)
                 .opacity(isActiveCondition() ? 1 : 0.6)
                 .animation(.easeIn)
         }
         .disabled(!onlyLayer)
         .disabled(!isActiveCondition())
     }
 }

 struct ActionButton_Previews: PreviewProvider {
     static var previews: some View {
         ActionButton("Continue", isActiveCondition: { false })
     }
 }
