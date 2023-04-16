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
    static let blueGradient = ColorGradient(Color("gradientBlueLow"),
                                            Color("gradientBlueHigh"))
    
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
}
