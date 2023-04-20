//
//  NavigationNavBar.swift
//  ReZeme
//
//  Created by Shakhzod on 13/04/23.
//

import SwiftUI

struct NavigationNavBar<Content: View>: View {
    
    //MARK: - PROPERTIES
    
    private let title: String
    private let type: AccountType
    private let withBeckBtn: Bool
    private let skipBtnAction: (()-> Void)?
    
    private let content: Content
    @Environment(\.presentationMode) var presentationMode
    
    //MARK: - Init
    
    init(
        title: String,
        type: AccountType = .RENTER,
        withBeckBtn: Bool = true,
        skipBtnAction: (() -> Void)? = nil,
        @ViewBuilder _ content: ()->Content
    ) {
        self.title = title
        self.type = type
        self.withBeckBtn = withBeckBtn
        self.content = content()
        self.skipBtnAction = skipBtnAction
    }
    
    //MARK: - body
    
    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 0) {
                
                ZStack {
                    
                    HStack(alignment: .top) {
                        
                        if withBeckBtn {
                            backButton {
                                presentationMode.wrappedValue.dismiss()
                            }
                        }
                        
                        Spacer()
                        
                        if let skipBtnAction {
                            skipButton(action: skipBtnAction)
                        }
                    }
                    
                    
                    Text(title)
                        .foregroundColor(.white)
                        .semibold22
                        
                    
                }
                .padding(.top, geo.safeAreaInsets.top)
                .padding(.bottom, 23)
                .padding(.horizontal, 20)
                .background(
                    Image(type == .RENTER ? "top-background" : "top-background-secondary")
                        .resizable()
                )
                
                content
                    .padding(.top,-1.8)
                
            }
            .edgesIgnoringSafeArea(.top)
            .navigationBarHidden(true)
            
        }
    }
}


//MARK: - UI Components

extension NavigationNavBar {
    
    private func backButton(action: @escaping ()-> Void) -> some View {
        Button(action: action) {
            Image(systemName: "arrow.left")
                .resizable()
                .scaledToFit()
                .foregroundColor(.white)
                .frame(width: 26, height: 26)
        }
    }
    
    private func skipButton(action: @escaping ()-> Void) -> some View {
        Button(action: action) {
            Text("Skip")
                .semibold16
                .foregroundColor(.white)
        }
    }
}


//MARK: - Preview

struct NavigationNavBar_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color.red
            Text("Hello")
                .foregroundColor(.white)
                .font(.system(size: 30))
        }
        .navigationRenter(title: "Renter")
        
        ZStack{
            Color.blue.opacity(0.2)
            Text("Hello")
                .foregroundColor(.white)
                .font(.system(size: 30))
        }
        .navigationAgent(title: "Agent")
    }
}
