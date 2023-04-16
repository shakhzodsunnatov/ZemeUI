//
//  PrimaryTextField.swift
//  ReZeme
//
//  Created by Yunus on 06/02/23.
//

import SwiftUI

public struct PrimaryTextFieldStyle: TextFieldStyle {
    
    public let title: String
    public let image: Image
    public var required: Bool
    @Binding public var error: Bool
    
    public init(title: String, image: String, error: Binding<Bool>, required: Bool = false) {
        self.title = title
        self.image = Image(image)
        self._error = error
        self.required = required
    }
    public func _body(configuration: TextField<Self._Label>) -> some View {
        
        VStack {
            HStack {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 18, height: 18)
                Text(title)
                    .regular14
                Spacer()
                
                if (required) {
                    Text("Required")
                        .regular14
                        .foregroundColor(.secondaryPurple)
                }
            }
            .padding(.leading, 5)
            .padding(.bottom, -5)
            configuration
                .padding()
                .background(LinearGradient(gradient: Gradient(colors: [.white]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .cornerRadius(8)
                .padding(5)
                .foregroundColor(Color.black)
                .glow()
                .medium16
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(.red, lineWidth: 1.5).opacity(error ? 0.65 : 0))
                .modifier(Shake(animatableData: error ? 2 : 0))
                .autocorrectionDisabled()

        }
    }
}

public struct SecureTextFieldStyle: TextFieldStyle {
    
    public let title: String
    public let image: Image
    public var required: Bool
    @Binding public var error: Bool
    
    public init(title: String, image: String, error: Binding<Bool>, required: Bool = false) {
        self.title = title
        self.image = Image(image)
        self._error = error
        self.required = required
    }
    public func _body(configuration: TextField<Self._Label>) -> some View {
        
        VStack {
            HStack {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                Text(title)
                    .regular14
                Spacer()
                
                if (required) {
                    Text("Required")
                        .regular14
                        .foregroundColor(.secondaryPurple)
                }
            }
            .padding(.leading, 5)
            .padding(.bottom, -5)
            
            HStack {
                configuration
            }
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [.white]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .cornerRadius(8)
            .padding(5)
            .foregroundColor(Color.black)
            .glow()
            .medium16
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(.red, lineWidth: 1.5).opacity(error ? 0.65 : 0))
            .modifier(Shake(animatableData: error ? 2 : 0))
            .autocorrectionDisabled()
        }
    }
}

// MARK: - Shake
public struct Shake: GeometryEffect {
    public var amount: CGFloat = 4
    public var shakesPerUnit = 3
    public var animatableData: CGFloat
    
    public init(animatableData: CGFloat) {
        self.animatableData = animatableData
    }

    public func effectValue(size: CGSize) -> ProjectionTransform {
                
        return ProjectionTransform(CGAffineTransform(translationX:
            amount * sin(animatableData * .pi * CGFloat(shakesPerUnit)),
            y: 0))
    }
}

//MARK: - PlaceHolder
extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
