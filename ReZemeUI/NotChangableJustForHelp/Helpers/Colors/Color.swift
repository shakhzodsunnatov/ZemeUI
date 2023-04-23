//
//  Color.swift
//  ZemeDesign
//
//  Created by Benjamin Kushmakov on 12/18/21.
//

import Foundation
import SwiftUI

private class LocalColor {}

extension Color {
    
    static let foreground = Color("white")//, bundle: .module)
    static let background = Color("lightGray")//, bundle: .module)
    static let darkBlue = Color("darkBlue")
    static let darkBackground = Color("darkGray")//, bundle: .module)
    static let primaryBlue = Color("darkBlue")//, bundle: .module)
    static let lightBlue = Color("lightBlue")//, bundle: .module)
    static let secondaryPurple = Color("purple")//, bundle: .module)
    static let failure = Color("red")//, bundle: .module)
    static let success = Color("green")//, bundle: .module)
    static let purpleLow = Color("gradientPurpleLow")
    static let blueGradient = ColorGradient(Color("gradientBlueHigh"),
                                            Color("gradientBlueLow"))
    
    static let blueGradientNew = ColorGradient(Color("gradientBlueHigh"),
                                            Color("gradientBlueLow"))

    static let purpleGradient = ColorGradient(Color("gradientPurpleLow"), Color("gradientPurpleHigh"))
    
    static let buttonBlueGradient = LinearGradient(gradient: Gradient(colors: [Color("gradientBlueLow"), Color("gradientBlueHigh")]), startPoint: .leading, endPoint: .bottom)
    static let blankGradient = LinearGradient(gradient: Gradient(colors: [.white]), startPoint: .leading, endPoint: .bottom)
    
//    static let chart = ChartStyle(backgroundColor: .white,
//                                  foregroundColor: Color.blueGradient, cornerRadius: 4.0)
    static let mainBgColor = Color(hex: 0xFBFBFC, opacity: 1.0)
    static let textGray =  Color("textGray")
    static let lightGrayBG = Color("lightGrayBG")
    
    //Error Page
    
    static let gradientStartColor = Color("gradientStartColor")
    static let gradientStopColor = Color("gradientStopColor")
    
}

extension Color {
    init(hex: Int, opacity: Double = 1.0) {
        let red = Double((hex & 0xff0000) >> 16) / 255.0
        let green = Double((hex & 0xff00) >> 8) / 255.0
        let blue = Double((hex & 0xff) >> 0) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
    
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
