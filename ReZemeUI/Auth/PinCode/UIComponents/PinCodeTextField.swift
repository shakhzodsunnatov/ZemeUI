//
//  PinCodeTextField.swift
//  ReZemeUI
//
//  Created by Shakhzod on 20/04/23.
//

import SwiftUI

struct PinCodeTextField: View {
    
    let onChange: (String) -> Void
    
    @StateObject var viewModel = PinViewModel()
    @State var isFocused = false
    
    let textBoxWidth: CGFloat = 44
    let textBoxHeight: CGFloat = 44
    let spaceBetweenBoxes: CGFloat = 10
    let paddingOfBox: CGFloat = 0
    var textFieldOriginalWidth: CGFloat {
        (textBoxWidth*6)+(spaceBetweenBoxes*3)+((paddingOfBox*2)*3)
    }
    
    var body: some View {
        
        VStack {
            
            ZStack {
                
                HStack (spacing: spaceBetweenBoxes) {
                    
                    otpText(text: viewModel.otp1)
                    otpText(text: viewModel.otp2)
                    otpText(text: viewModel.otp3)
                    otpText(text: viewModel.otp4)
                    otpText(text: viewModel.otp5)
                    otpText(text: viewModel.otp6)
                }
                
                
                TextField("", text: $viewModel.otpField)
                    .frame(width: isFocused ? 0 : textFieldOriginalWidth, height: textBoxHeight)
                    .disabled(viewModel.isTextFieldDisabled)
                    .textContentType(.oneTimeCode)
                    .foregroundColor(.clear)
                    .accentColor(.clear)
                    .background(Color.clear)
                    .keyboardType(.numberPad)
            }
        }
        .onChange(of: viewModel.otpField) { newValue in
            onChange(newValue)
        }
    }
    
    private func otpText(text: String) -> some View {
        
        return Text(text)
            .medium16
            .frame(width: textBoxWidth, height: textBoxHeight)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.white)
                    .glow()
            )
            .overlay(
                Text("0")
                    .medium16
                    .foregroundColor(.textGray)
                    .opacity(text.isEmpty ? 1 : 0)
            )
            .padding(paddingOfBox)
    }
}

struct PinCodeTextField_Previews: PreviewProvider {
    static var previews: some View {
        PinCodeTextField { text in
            
        }
    }
}

