//
//  CustomAlert.swift
//  ReZeme
//
//  Created by Shakhzod on 20/03/23.
//

import SwiftUI

struct CustomAlert: View {
    
    /// Flag used to dismiss the alert on the presenting view
    @Binding var presentAlert: Bool
    
    @State var isConfirmed = false
    
    var confirmButton: (() -> ())?
    
    var body: some View {
        
        ZStack {
            
            // faded background
            Color.black.opacity(0.35)
                .blur(radius: 4)
                .edgesIgnoringSafeArea(.all)

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
                
                Text("By checking the  box below, you authorize us to obtain a soft inquiry credit report for the purpose of providing it to brokers, agents, landlords, property managers, and other relevant parties (collectively) associated with the properties you are interested in. This soft inquiry credit report may include information on your credit history, payment records, and other information relevant to your creditworthiness. ")
                    .regular16
                    .multilineTextAlignment(.center)
                    .padding(.top, 7)
                
                
                Button(action: {
                    isConfirmed.toggle()
                }, label: {
                    
                    HStack(spacing: 9) {
                        
                        Image(systemName: isConfirmed ? "checkmark.circle" : "circle")
                            .resizable()
                            .scaledToFill()
                            .foregroundColor(.darkBlue)
                            .frame(width: 20, height: 20)
                        
                        Text("I confirm a credit pull")
                            .regular14
                            .foregroundColor(.black)
                            
                    }
                    
                })
                .padding(.top, 30)
                
                
                Button(action: {
                    confirmButton?()
                }) {
                    Text("Confirm")
                        .semibold18
                        .foregroundColor(.white)
                        .disabled(!isConfirmed)
                        .frame(height: 60)
                        .frame(maxWidth: .infinity)
                        .background(
                            Capsule()
                                .fill(Color.blueGradient.toLinearGradient)
                        )
                        .padding(.top, 33)
                        .padding(.horizontal, 85)
                }
                
                
                Button(action: {
                    presentAlert = false
                }) {
                    Text("Back")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.darkBlue)
                        .underline(color: .darkBlue)
                        .padding(.top, 18)
                }
            }
            .padding(EdgeInsets(top: 35, leading: 28, bottom: 26, trailing: 28))
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.white)
            )
            .padding(.horizontal, 20)
        }
        
    }
}

struct CustomAlert_Previews: PreviewProvider {
    static var previews: some View {
        CustomAlert(presentAlert: .constant(true))
    }
}
