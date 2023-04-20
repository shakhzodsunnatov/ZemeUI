//
//  FontWithLineHeight.swift
//  ReZeme
//
//  Created by Mirzohidbek on 07/02/23.
//

import SwiftUI

struct FontWithLineHeight: ViewModifier {
    let font: UIFont
    let lineHeight: CGFloat

    func body(content: Content) -> some View {
        content
            .font(Font(font))
            .lineSpacing(lineHeight - font.lineHeight)
            .padding(.vertical, (lineHeight - font.lineHeight) / 2)
    }
}


extension View {
    var semibold22: some View {
        ModifiedContent(content: self,
                        modifier: FontWithLineHeight(
                            font: .semibold(size: 22),
                            lineHeight: 33))
    }
    
    var medium26: some View {
        ModifiedContent(content: self,
                        modifier: FontWithLineHeight(
                            font: .medium(size: 26),
                            lineHeight: 39))
    }
    
    var semibold18: some View {
        ModifiedContent(content: self,
                        modifier: FontWithLineHeight(
                            font: .semibold(size: 18),
                            lineHeight: 27))
    }
    
    var medium18: some View {
        ModifiedContent(content: self,
                        modifier: FontWithLineHeight(
                            font: .medium(size: 18),
                            lineHeight: 27))
    }
    
    var regular18: some View {
        ModifiedContent(content: self,
                        modifier: FontWithLineHeight(
                            font: .regular(size: 18),
                            lineHeight: 27))
    }
    
    var semibold16: some View {
        ModifiedContent(content: self,
                        modifier: FontWithLineHeight(
                            font: .semibold(size: 16),
                            lineHeight: 24))
    }
    
    var medium16: some View {
        ModifiedContent(content: self,
                        modifier: FontWithLineHeight(
                            font: .medium(size: 16),
                            lineHeight: 24))
    }
    
    var regular16: some View {
        ModifiedContent(content: self,
                        modifier: FontWithLineHeight(
                            font: .regular(size: 16),
                            lineHeight: 24))
    }
    
    var light16: some View {
        ModifiedContent(content: self,
                        modifier: FontWithLineHeight(
                            font: .light(size: 16),
                            lineHeight: 24))
    }
    
    var bold14: some View {
        ModifiedContent(content: self,
                        modifier: FontWithLineHeight(
                            font: .bold(size: 14),
                            lineHeight: 21))
    }
    
    var semibold14: some View {
        ModifiedContent(content: self,
                        modifier: FontWithLineHeight(
                            font: .semibold(size: 14),
                            lineHeight: 21))
    }
    
    var medium14: some View {
        ModifiedContent(content: self,
                        modifier: FontWithLineHeight(
                            font: .medium(size: 14),
                            lineHeight: 21))
    }
    
    var regular14: some View {
        ModifiedContent(content: self,
                        modifier: FontWithLineHeight(
                            font: .regular(size: 14),
                            lineHeight: 21))
    }
    
    var medium12: some View {
        ModifiedContent(content: self,
                        modifier: FontWithLineHeight(
                            font: .medium(size: 12),
                            lineHeight: 18))
    }
    
    var regular12: some View {
        ModifiedContent(content: self,
                        modifier: FontWithLineHeight(
                            font: .regular(size: 12),
                            lineHeight: 18))
    }
    
    var semibold11: some View {
        ModifiedContent(content: self,
                        modifier: FontWithLineHeight(
                            font: .semibold(size: 11),
                            lineHeight: 16))
    }
    
    
    
    var regular11: some View {
        ModifiedContent(content: self,
                        modifier: FontWithLineHeight(
                            font: .regular(size: 11),
                            lineHeight: 16))
    }
    
    var medium9: some View {
        ModifiedContent(content: self,
                        modifier: FontWithLineHeight(
                            font: .medium(size: 9),
                            lineHeight: 14))
    }
    
    var regular9: some View {
        ModifiedContent(content: self,
                        modifier: FontWithLineHeight(
                            font: .regular(size: 9),
                            lineHeight: 14))
    }
   
    
    var bold18: some View {
        ModifiedContent(content: self,
                        modifier: FontWithLineHeight(
                            font: .bold(size: 18),
                            lineHeight: 27))
    }
}

extension UIFont {
    static func light(size: CGFloat)-> UIFont {
        return UIFont(name: "Poppins-Light", size: size) ?? .systemFont(ofSize: size)
    }
    
    static func regular(size: CGFloat)-> UIFont {
        return UIFont(name: "Poppins-Regular", size: size) ?? .systemFont(ofSize: size)
    }
    
    static func semibold(size: CGFloat)-> UIFont {
        return UIFont(name: "Poppins-SemiBold", size: size) ?? .systemFont(ofSize: size)
    }
    
    static func bold(size: CGFloat)-> UIFont {
        return UIFont(name: "Poppins-Bold", size: size) ?? .systemFont(ofSize: size)
    }
    
    static func extraBold(size: CGFloat)-> UIFont {
        return UIFont(name: "Poppins-ExtraBold", size: size) ?? .systemFont(ofSize: size)
    }
    
    static func medium(size: CGFloat)-> UIFont {
        return UIFont(name: "Poppins-Medium", size: size) ?? .systemFont(ofSize: size)
    }
}
