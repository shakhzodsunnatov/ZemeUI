//
//  MeetingTypeAlert.swift
//  ReZemeUI
//
//  Created by Shakhzod on 18/04/23.
//

import Foundation
import SwiftUI

struct MeetingTypeAlert: View {
    
    @Binding var presenterView: Bool
    var submit: (Bool)->Void = {_ in}
    
    @State var isVirtual = true
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(spacing:0) {
                
                Image("calendar_light")
                    .resizable()
                    .scaledToFit()
                    .font(.title.weight(.light))
                    .frame(width: 40, height: 40)
                    .padding(20)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.secondaryPurple.opacity(0.2))
                    )
                
                Text("How would you like to meet?")
                    .medium18
                    .padding(.top, 23)
                    .fixedSize(horizontal: false, vertical: true)
                
                checkBox(isVirtualActive: isVirtual) { isVirtualSelected in
                    isVirtual = isVirtualSelected
                }
                .padding(.top,36)
             
                Button {
                    submit(isVirtual)
                    presenterView.toggle()
                } label: {
                    Text("Submit")
                        .bold18
                        .foregroundColor(.white)
                        .frame(height: 60)
                        .frame(maxWidth: .infinity)
                        .background(
                            Capsule()
                                .fill(Color.blueGradient.toLinearGradient)
                        )
                        
                }
                .padding(.horizontal, 36)
                .padding(.top, 44)

                
            }
            .padding(EdgeInsets(
                top: 27,
                leading: 37,
                bottom: 27,
                trailing: 37)
            )
            .frame(width: SCREEN_WIDTH-40)
            .background(Color.white)
            .cornerRadius(8)
            .padding(.horizontal, 20)
            
            Button(action: {
                withAnimation {
                    self.presenterView = false
                }
            }) {
                Image(systemName: "xmark.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .background(
                        Circle()
                            .fill(.white)
                    )
                    .padding(.top,-15)
                    .padding(.trailing,8)
            }
        }
    }
}


//MARK: - UI Components

extension MeetingTypeAlert {
    
    private func checkBox(isVirtualActive: Bool, action: @escaping (Bool)->Void) -> some View {
        HStack {
            checkItem(
                name: "In-Person",
                isActive: !isVirtualActive,
                action: { action(false) }
            )
            Spacer()
            checkItem(
                name: "Virtual",
                isActive: isVirtualActive,
                action: { action(true) }
            )
        }
    }

    private func checkItem(name: String, isActive: Bool, action: @escaping ()-> Void) -> some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Image(systemName: "\(isActive ? "checkmark.":"")circle")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 20, height: 20)
                
                Text(name)
                    .regular16
                    .foregroundColor(.black)
            }
        }
    }
    
}


struct MeetingTypeAlert_Previews: PreviewProvider {
    static var previews: some View {
        MeetingTypeAlert(presenterView: .constant(false))
    }
}
