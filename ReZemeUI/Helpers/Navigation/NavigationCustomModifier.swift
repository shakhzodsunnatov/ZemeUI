//
//  NavigationCustomModifier.swift
//  ReZeme
//
//  Created by Shakhzod on 14/04/23.
//

import SwiftUI

struct NavigationCustomModifier: ViewModifier {
    
    //MARK: - PROPERTIES
    
    private let title: String
    private let type: AccountType
    private let withBeckBtn: Bool
    private let skipBtnAction: (()-> Void)?
    
    //MARK: - Init
    
    init(
        title: String,
        type: AccountType = .RENTER,
        withBeckBtn: Bool = true,
        skipBtnAction: (() -> Void)? = nil
    ) {
        self.title = title
        self.type = type
        self.withBeckBtn = withBeckBtn
        self.skipBtnAction = skipBtnAction
    }
    
    func body(content: Content) -> some View {
        NavigationNavBar(
            title: title,
            type: type,
            withBeckBtn: withBeckBtn,
            skipBtnAction: skipBtnAction) {
                content
            }
    }
}



//MARK: - Make Modifier

extension View {
    
    //MARK: - Renter Navigation
    
    func navigationRenter(
        title: String,
        withBeckBtn: Bool = true,
        skipBtnAction: (() -> Void)? = nil
    ) -> some View {
        modifier(
            NavigationCustomModifier(
                title: title,
                type: .RENTER,
                withBeckBtn: withBeckBtn,
                skipBtnAction: skipBtnAction
            )
        )
    }
    
    
    //MARK: - Agent Navigation
    
    func navigationAgent(
        title: String,
        withBeckBtn: Bool = true,
        skipBtnAction: (() -> Void)? = nil
    ) -> some View {
        modifier(
            NavigationCustomModifier(
                title: title,
                type: .AGENT,
                withBeckBtn: withBeckBtn,
                skipBtnAction: skipBtnAction
            )
        )
    }
}



//MARK: - Preview

struct NavigationCustomModifier_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color.red
            Text("Hello Renter")
                .foregroundColor(.white)
                .font(.system(size: 30))
        }
        .navigationRenter(title: "Renter")
        
        ZStack{
            Color.red
            Text("Hello Agent")
                .foregroundColor(.white)
                .font(.system(size: 30))
        }
        .navigationAgent(title: "Agent")
    }
}
