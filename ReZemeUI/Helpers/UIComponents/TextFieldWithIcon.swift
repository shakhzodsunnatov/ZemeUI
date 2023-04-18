//
//  TextFieldWithIcon.swift
//  ReZeme
//
//  Created by Davron Usmanov on 03.04.2023.
//

import SwiftUI

enum TextFieldStyleNew {
    case simple, secure, textView
}

struct TextFieldWithIcon: View {
    
    var image: String
    var topTitle: String
    @State var placeHolder: String = ""
    @Binding var text: String
    var textFiledStyle: TextFieldStyleNew
    
    @Binding var emailError: Bool 
    @State var showPassword = false
    
    var requretdText: String? = nil
    
    var body: some View {
        switch textFiledStyle {
        case .simple:
            VStack(spacing: 11) {
                VStack {
                    HStack(spacing: 10) {
                        Image(image)
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(.purpleLow)
                            .scaledToFit()
                            .frame(width: 18, height: 18)
                        
                        Text(topTitle)
                            .regular14
                        Spacer()
                        
                        if requretdText != nil {
                            Text(requretdText ?? "")
                                .foregroundColor(.purpleLow)
                                .regular12
                        }
                    }
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.red,lineWidth: 1)
                            .frame(height: 70)
                            .scaleEffect(1.02)
                            .opacity(emailError ? 1 : 0)
                            .modifier(Shake(animatableData: emailError ? 2 : 0))
                            .padding(.vertical, 5)
                        
                        TextField(placeHolder.isEmpty ? topTitle : placeHolder, text: $text)
                            .padding(20)
                            .background(Color.white)
                            .cornerRadius(8)
                            .shadowCustom()
                    }
                }
            }
        case .secure:
            #warning("We have to creat secure textfield view")
            VStack(spacing: 11) {
                VStack {
                    HStack(spacing: 10) {
                        Image(image)
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(.blue)
                            .scaledToFit()
                            .frame(width: 18, height: 18)
                        Text(topTitle)
                            .regular14
                        Spacer()
                    }
                    SecureField(topTitle, text: $text)
                        .padding(20)
                        .background(Color.white)
                        .cornerRadius(8)
                        .shadowCustom()
                }
            }
        case .textView:
            VStack(spacing: 11) {
                VStack {
                    HStack(spacing: 10) {
                        Image(image)
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(.blue)
                            .scaledToFit()
                            .frame(width: 18, height: 18)
                        Text(topTitle)
                            .regular14
                        Spacer()
                    }
                    TextEditorWithPlaceholder(text: $text, placeHolder: $placeHolder)
                        .frame(height: 150)
                        .padding(20)
                        .background(Color.white)
                        .cornerRadius(8)
                        .shadowCustom()
                }
            }
        }
    }
    
    func errorAcrion()  {
        withAnimation {
            emailError.toggle()
            emailError = self.text.isEmpty
            if text.isEmpty {
                Haptic.generateError()
            }
        }
    }
}


//struct TextFieldWithIcon_Previews: PreviewProvider {
//    static var previews: some View {
//        TextFieldWithIcon(image: "plus", topTitle: "123", placeHolder: "123", text: , textFiledStyle: .simple, emailError: true, showPassword: false, requretdText: "12313")
//    }
//}



struct TextEditorWithPlaceholder: View {
        @Binding var text: String
        @Binding var placeHolder: String
        var body: some View {
            ZStack(alignment: .leading) {
                if text.isEmpty {
                   VStack {
                        Text(placeHolder)
                           .foregroundColor(.gray)
                            .padding(.top, 10)
                            .padding(.leading, 6)
//                            .opacity(0.1)
                        Spacer()
                    }
                }
                
                VStack {
                    TextEditor(text: $text)
                        .frame(minHeight: 150, maxHeight: 300)
                        .opacity(text.isEmpty ? 0.7 : 1)
                    Spacer()
                }
            }
        }
    }


extension View {
    func shadowCustom() -> some View {
        return self.shadow(color: Color(hexString: "B6B6D2").opacity(0.3),radius: 25,x: 4, y: 4)
    }
}

extension Color {
    /// Create a `Color` from a hexadecimal representation
    /// - Parameter hexString: 3, 6, or 8-character string, with optional (ignored) punctuation such as "#"
    init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let red, green, blue: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (red, green, blue) = ((int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (red, green, blue) = (int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            // FIXME: I think we need an an alpha value on this one. See link below.
            // https://stackoverflow.com/a/56874327/4475605
            (red, green, blue) = (int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (red, green, blue) = (0, 0, 0)
        }
        self.init(red: Double(red) / 255, green: Double(green) / 255, blue: Double(blue) / 255)
    }
}

func format(with mask: String, phone: String) -> String {
    let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
    var result = ""
    var index = numbers.startIndex // numbers iterator

    // iterate over the mask characters until the iterator of numbers ends
    for ch in mask where index < numbers.endIndex {
        if ch == "X" {
            // mask requires a number in this place, so take the next one
            result.append(numbers[index])

            // move numbers iterator to the next index
            index = numbers.index(after: index)

        } else {
            result.append(ch) // just append a mask character
        }
    }
    return result
}
