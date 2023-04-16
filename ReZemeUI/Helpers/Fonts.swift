//
//  Fonts.swift
//  ZemeDesign
//
//  Created by Benjamin Kushmakov on 1/3/22.
//

import SwiftUI

public struct ScaledFont: ViewModifier {
    public var name: String
    public var scale: CGFloat
    
    public func body(content: Content) -> some View {
        let scaledSize = UIFontMetrics.default.scaledValue(for: scale)
        return content.font(.custom(name, size: scaledSize))
    }
}

public let Poppins: [String] = ["Poppins-Light", "Poppins-Regular", "Poppins-SemiBold", "Poppins-Bold", "Poppins-ExtraBold", "Poppins-Medium"]

extension View {
    public func light(size: CGFloat) -> some View {
        return self.modifier(ScaledFont(name: "Poppins-Light", scale: size))
    }
    public func regular(size: CGFloat) -> some View {
        return self.modifier(ScaledFont(name: "Poppins-Regular", scale: size))
    }
    
    public func semibold(size: CGFloat) -> some View {
        return self.modifier(ScaledFont(name: "Poppins-SemiBold", scale: size))
    }
    
    public func bold(size: CGFloat) -> some View {
        return self.modifier(ScaledFont(name: "Poppins-Bold", scale: size))
    }
    
    public func extraBold(size: CGFloat) -> some View {
        return self.modifier(ScaledFont(name: "Poppins-ExtraBold", scale: size))
    }
    
    public func medium(size: CGFloat) -> some View {
        return self.modifier(ScaledFont(name: "Poppins-Medium", scale: size))
    }
}



public struct ZemeFonts {
     public static func registerFonts() {
         for style in Poppins {
             registerFont(bundle: .main, fontName: style, fontExtension: "ttf")
        }
     }

    fileprivate static func registerFont(bundle: Bundle, fontName: String, fontExtension: String) {

        guard let fontURL = bundle.url(forResource: fontName, withExtension: fontExtension),
              let fontDataProvider = CGDataProvider(url: fontURL as CFURL),
              let font = CGFont(fontDataProvider) else {
                  fatalError("Couldn't create font from data")
        }

        var error: Unmanaged<CFError>?

        CTFontManagerRegisterGraphicsFont(font, &error)
    }
    

}
